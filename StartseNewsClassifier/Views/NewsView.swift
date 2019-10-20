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
                        Text("E-commerce chinês JD.com inicia entrega de produtos direto no carro do cliente").font(.headline).bold()
                        Text("Usuários podem definir veículo como destino de entrega e autorizar funcionário da empresa a abrir o porta-malas").font(.body).padding([.top], 5)
                    }.padding()
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
