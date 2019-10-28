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

    @EnvironmentObject var newsList:NewsListViewModel
    
    @State private var classifiedNews:ClassifiedNewsViewModel?

    @State var selectedView = 0
    @State private var offset:CGSize = .zero
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
                VStack {
                    if !(self.newsList.articles.count == 0) {
                        Spacer()
                        
                        VStack (alignment: .leading){
                            Text(newsList.articles[currentNewsIndex].title).font(.headline).bold()
                            Text(newsList.articles[currentNewsIndex].subtitle).font(.body).padding([.top], 5).foregroundColor(.gray)
                        }
                        .offset(x: offset.width, y: 0)
                        .gesture(drag)
                        .padding(50)
                        
                        Spacer()
                        
                        VStack (alignment: .trailing) {
                            NavigationLink(destination: ClassificationView(news: newsList.articles[currentNewsIndex].news!)) {
                                HStack {
                                    Text("classificar").frame(minWidth: 0, maxWidth: .infinity, minHeight: 40).background(Color.red)
                                    Image(systemName: "arrow.right").padding([Edge.Set.trailing], 10)
                                }.frame(minWidth: 0, maxWidth: .infinity, minHeight:40, alignment: .center).background(Color.pink).foregroundColor(.white)
                            }
                        }
                    }else {
                        Text("Carregando as notícias")
                    }
                }
                .navigationBarTitle(Text("Notícia").font(.subheadline))
            }.background(Color.yellow)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("notícia")
            }
            .tag(0)
            
            Group {
                if (newsList.articles.count > 0) {
                    ClassifiedNewsView(news: newsList.articles[currentNewsIndex].news!)
                }else {
                    Text("Ainda não temos notícias")
                }
            }.tabItem {
                Image(systemName: "2.circle")
                Text("classificação")
            }.tag(1)
        }
    }
    
    func nextNews() {
        if currentNewsIndex == self.newsList.articles.count - 1 {
            return
        }

        currentNewsIndex = currentNewsIndex + 1
        self.classifiedNews = newsList.classifiedNews[newsList.articles[currentNewsIndex].news!.news_id]
    }
    
    func previousNews() {
        if currentNewsIndex == 0 {
            return
        }else {
            currentNewsIndex = currentNewsIndex - 1
            self.classifiedNews = newsList.classifiedNews[newsList.articles[currentNewsIndex].news!.news_id]
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
