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
                        StartseNewsService().loadLatestNews() {
                            articles in
                            for news in articles {
                                let newsViewModel = NewsViewModel(news: news)
                                self.articles.append(newsViewModel)
                            }
                            self.classifier = NewsClassifierViewModel(news: self.articles[self.currentNewsIndex].news!)
                            self.isLoading = false
                        }
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
