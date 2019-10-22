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
    
    private let sentences = SentenceListViewModel()
    
    var body: some View {
        TabView(selection: $selectedView) {
            NavigationView {
                NavigationLink(destination: ContentView(sentences: sentences)) {
                    VStack (alignment: .leading) {
                        Text(sentences.articles.articles[0].title).font(.headline).bold()
                        Text(sentences.articles.articles[0].subtitle).font(.body).padding([.top], 5)
                    }.padding(50)
                }
                .navigationBarTitle(Text("Notícia").font(.subheadline))
            }.background(Color.yellow)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("notícia")
            }
            .tag(0)
            
            ClassifiedNewsView(sentenceListViewModel: sentences)
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("classificação")
                }.tag(1)
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
