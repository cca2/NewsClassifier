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
                if (sentenceListViewModel.classifiedSentencesDictionary[.none]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.none.rawValue)) {
                        Text("Shawn Fanning é o menos conhecido da dupla que fundou o Napster, o primeiro software de download de músicas que fez sucesso mundial no início dos anos 2000.")
                    }
                }
                

                if (sentenceListViewModel.sentenceListOfType(classification: .segment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .segment).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .segment)[$0].text)")
                        }
                    }
                }
                
                if (sentenceListViewModel.sentenceListOfType(classification: .problem).count > 0) {
                    Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .problem).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .problem)[$0].text)")
                        }
                    }
                }
                
                if (sentenceListViewModel.sentenceListOfType(classification: .solution).count > 0) {
                    Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .solution).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .solution)[$0].text)")
                        }
                    }
                }
                

                if (sentenceListViewModel.sentenceListOfType(classification: .uvp).count > 0) {
                    Section(header: Text(SentenceModel.Classification.uvp.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .uvp).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .uvp)[$0].text)")
                        }
                    }
                }
                

                if (sentenceListViewModel.sentenceListOfType(classification: .investment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .investment).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .investment)[$0].text)")
                        }
                    }
                }
                
                if (sentenceListViewModel.sentenceListOfType(classification: .partnership).count > 0) {
                    Section(header: Text(SentenceModel.Classification.partnership.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .partnership).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .partnership)[$0].text)")
                        }
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
