//
//  NewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 20/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: ContentView(sentences: SentenceListViewModel())) {
                VStack (alignment: .leading) {
                    Text("E-commerce chinês JD.com inicia entrega de produtos direto no carro do cliente").font(.headline).bold()
                    Text("Usuários podem definir veículo como destino de entrega e autorizar funcionário da empresa a abrir o porta-malas").font(.body).padding([.top], 5)
                }.padding()
            }
            .navigationBarTitle(Text("Notícia").font(.subheadline))
        }.background(Color.yellow)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
