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
                Section(header: Text(SentenceModel.Classification.none.rawValue)) {
                    Text("Shawn Fanning é o menos conhecido da dupla que fundou o Napster, o primeiro software de download de músicas que fez sucesso mundial no início dos anos 2000.")
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.segment]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                        Text("Enquanto seu sócio Sean Parker foi mentor do Facebook e chegou a ser interpretado por Justin Timberlake no cinema, o programador Fanning se manteve distante dos holofotes, com alguns projetos de startups de relativo sucesso.")
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.problem]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                        Text("Enquanto seu sócio Sean Parker foi mentor do Facebook e chegou a ser interpretado por Justin Timberlake no cinema, o programador Fanning se manteve distante dos holofotes, com alguns projetos de startups de relativo sucesso.")
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.solution]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                        Text("Enquanto seu sócio Sean Parker foi mentor do Facebook e chegou a ser interpretado por Justin Timberlake no cinema, o programador Fanning se manteve distante dos holofotes, com alguns projetos de startups de relativo sucesso.")
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.uvp]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.uvp.rawValue)) {
                        Text("Enquanto seu sócio Sean Parker foi mentor do Facebook e chegou a ser interpretado por Justin Timberlake no cinema, o programador Fanning se manteve distante dos holofotes, com alguns projetos de startups de relativo sucesso.")
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.investment]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                        Text("Enquanto seu sócio Sean Parker foi mentor do Facebook e chegou a ser interpretado por Justin Timberlake no cinema, o programador Fanning se manteve distante dos holofotes, com alguns projetos de startups de relativo sucesso.")
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.partnership]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.partnership.rawValue)) {
                        Text("Enquanto seu sócio Sean Parker foi mentor do Facebook e chegou a ser interpretado por Justin Timberlake no cinema, o programador Fanning se manteve distante dos holofotes, com alguns projetos de startups de relativo sucesso.")
                    }
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
