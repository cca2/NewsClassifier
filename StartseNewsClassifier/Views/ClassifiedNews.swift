//
//  ClassifiedNews.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ClassifiedNews: View {
    @ObservedObject private var sentenceListViewModel:SentenceListViewModel
    
    var body: some View {
        VStack {
            Text("Notícia").font(.title)
            List {
                Section(header: Text("Problema")) {
                    Text("Shawn Fanning é o menos conhecido da dupla que fundou o Napster, o primeiro software de download de músicas que fez sucesso mundial no início dos anos 2000.")
                    Text("Enquanto seu sócio Sean Parker foi mentor do Facebook e chegou a ser interpretado por Justin Timberlake no cinema, o programador Fanning se manteve distante dos holofotes, com alguns projetos de startups de relativo sucesso.")
                }
            }
        }
    }
    
    init(sentenceListViewModel:SentenceListViewModel) {
        self.sentenceListViewModel = sentenceListViewModel
    }
}

struct ClassifiedNews_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedNews(sentenceListViewModel: SentenceListViewModel())
    }
}
