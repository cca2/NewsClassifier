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
    @State private var news:NewsViewModel?
    
    @State private var currentNewsIndex = 0
    
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
                    if news != nil {
                        Group {
                            Text(news!.title).font(.headline).bold()
                            Text(news!.subtitle).font(.body).padding([.top], 5)
                        }
                        .offset(x: offset.width, y: 0)
                        .gesture(drag)
                        
                        Spacer()
                        
                        if classifier != nil {
                            NavigationLink(destination: ClassifyOrFinishView(classifier: self.classifier!)) {
                                VStack(alignment: .trailing) {
                                    Text("classificar")
                                }
                            }
                        }
                    }
                }.padding(50)
                .navigationBarTitle(Text("Notícia").font(.subheadline))
                .onAppear() {
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
                            self.news = NewsViewModel(news: newsModel)
                            self.classifier = NewsClassifierViewModel(news: newsModel)
                        }catch {
                            print (error)
                        }
                    }
                    
                    operation.queryCompletionBlock = {
                        cursor, error in
                        
                        DispatchQueue.main.async {
                            if (error == nil) {
                                print(">>> Finalizou com Sucesso <<<")
                            }else {
                                print (">>> FINALIZOU QUERY <<<")
                            }
                        }
                    }
                    database.add(operation)
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
    
//    init?() {
//        do {
//            guard let path = Bundle.main.path(forResource: "StartseNews-03c25ec5-3373-47ad-ba82-9500dacfe6ed", ofType: "json") else { return nil}
//            let newsFileURL = URL(fileURLWithPath: path)
//
//            news = try NewsViewModel(newsFile: newsFileURL)
//            self.classifier = NewsClassifierViewModel(news: news.news)
//
//            print (news.title)
//        }catch {
//            print (error)
//            return nil
//        }
//    }
    
    func nextNews() {
//        let articles = sentences.articles.articles
//        if currentNewsIndex == articles.count - 1 {
//            return
//        }
//
//        currentNewsIndex = currentNewsIndex + 1
//        sentences.currentNewsIndex = currentNewsIndex
    }
    
    func previousNews() {
//        if currentNewsIndex == 0 {
//            return
//        }else {
//            currentNewsIndex = currentNewsIndex - 1
//            sentences.currentNewsIndex = currentNewsIndex
//        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
