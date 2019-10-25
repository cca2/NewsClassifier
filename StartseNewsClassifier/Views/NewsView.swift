//
//  NewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 20/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI
import CloudKit

struct NewsView: View {
    @State var selectedView = 0
    
    @State private var offset:CGSize = .zero
    
    @State private var classifier:NewsClassifierViewModel?
    
    @State private var currentNewsIndex = 0
    
    @State private var isLoading = true
    
    @State private var articles:[NewsViewModel] = []
    
    var body: some View {
        let drag = DragGesture()
            .onChanged {
                self.offset = $0.translation
            }
            
            .onEnded {
                if ($0.translation.height < 50 && $0.translation.height > -50) {
                    if $0.translation.width < -50 {
                        self.nextNews()
                        self.offset = .init(width: 0, height: 0)
                    }else if $0.translation.width > 50 {
                        self.previousNews()
                        self.offset = .init(width: 0, height: 0)
                    }else {
                        self.offset = .zero
                    }
                }
        }

        return TabView(selection: $selectedView) {
            NavigationView {
                VStack (alignment: .leading) {
                    if !self.isLoading {
                        Group {
                            Text(articles[currentNewsIndex].title).font(.headline).bold()
                            Text(articles[currentNewsIndex].subtitle).font(.body).padding([.top], 5)
                        }
                        .offset(x: offset.width, y: 0)
                        .gesture(drag)
                        
                        Spacer()
                        
                        NavigationLink(destination: ClassifyOrFinishView(classifier: self.classifier!)) {
                            VStack(alignment: .trailing) {
                                Text("classificar")
                            }
                        }
                    }else {
                        Text("Carregando as notícias")
                    }
                }.padding(50)
                .navigationBarTitle(Text("Notícia").font(.subheadline))
                .onAppear() {
                    if self.isLoading {
                        //Verifica se há novas notícias a serem baixadas do cloudkit
                        let database = CKContainer.init(identifier: "iCloud.br.ufpe.cin.StartseNewsClassifier").privateCloudDatabase
                        let predicate = NSPredicate(value: true)
                        
                        let query = CKQuery(recordType: "News", predicate: predicate)
                        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                        
                        let operation = CKQueryOperation(query: query)
                        
                        operation.recordFetchedBlock = {
                            record in
                            
                            do {
                                let newsFile = record["newsFile"] as! CKAsset
                                let decoder = JSONDecoder()
                                let json = try Data(contentsOf: newsFile.fileURL!)
                                let newsModel = try decoder.decode(NewsModel.self, from: json)
                                let news = NewsViewModel(news: newsModel)
                                self.articles.append(news)
                            }catch {
                                print (error)
                            }
                        }
                        
                        operation.queryCompletionBlock = {
                            cursor, error in
                            
                            DispatchQueue.main.async {
                                if (error == nil) {
                                    print(">>> Finalizou com Sucesso <<<")
                                    self.classifier = NewsClassifierViewModel(news: self.articles[self.currentNewsIndex].news!)
                                    self.isLoading = false
                                }else {
                                    print (">>> FINALIZOU QUERY <<<")
                                }
                            }
                        }
                        database.add(operation)
                    }

                }
            }.background(Color.yellow)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("notícia")
            }
            .tag(0)
            
            if classifier != nil {
                ClassifiedNewsView(newsClassifierViewModel: classifier!)
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("classificação")
                    }.tag(1)
            }
        }
    }
    
    func nextNews() {
        if currentNewsIndex == articles.count - 1 {
            return
        }

        currentNewsIndex = currentNewsIndex + 1
        self.classifier = NewsClassifierViewModel(news: articles[currentNewsIndex].news!)
    }
    
    func previousNews() {
        if currentNewsIndex == 0 {
            return
        }else {
            currentNewsIndex = currentNewsIndex - 1
            self.classifier = NewsClassifierViewModel(news: articles[currentNewsIndex].news!)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
