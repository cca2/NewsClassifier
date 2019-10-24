//
//  NewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 20/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct NewsView: View {
    @State var selectedView = 0
    
    @State private var offset:CGSize = .zero
    
//    private let sentences = SentenceListViewModel()
    private let news:NewsViewModel
    
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
                        Group {
//                            Text(sentences.articles.articles[currentNewsIndex].title).font(.headline).bold()
//                            Text(sentences.articles.articles[currentNewsIndex].subtitle).font(.body).padding([.top], 5)
                            Text(news.title).font(.headline).bold()
                            Text(news.subtitle).font(.body).padding([.top], 5)
                        }
                        .offset(x: offset.width, y: 0)
                        .gesture(drag)
                        
                        Spacer()
                        
//                        NavigationLink(destination: ContentView(sentences: sentences)) {
//                            VStack(alignment: .trailing) {
//                                Text("classificar")
//                            }
//                        }
                    }.padding(50)
                .navigationBarTitle(Text("Notícia").font(.subheadline))
            }.background(Color.yellow)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("notícia")
            }
            .tag(0)
            
//            ClassifiedNewsView(sentenceListViewModel: sentences)
//                .tabItem {
//                    Image(systemName: "2.circle")
//                    Text("classificação")
//                }.tag(1)
        }
    }
    
    init?() {
        do {
            guard let path = Bundle.main.path(forResource: "StartseNews-03c25ec5-3373-47ad-ba82-9500dacfe6ed", ofType: "json") else { return nil}
            let newsFileURL = URL(fileURLWithPath: path)
            
            news = try NewsViewModel(newsFile: newsFileURL)
            
            print (news.title)
        }catch {
            print (error)
            return nil
        }
    }
    
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
