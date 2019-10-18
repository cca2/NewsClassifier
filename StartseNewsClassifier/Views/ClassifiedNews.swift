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
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.segment]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                        ForEach((0...(sentenceListViewModel.classifiedSentencesDictionary[.segment]!.count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.classifiedSentencesDictionary[.segment]![$0].text)")
                        }
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.problem]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                        ForEach((0...(sentenceListViewModel.classifiedSentencesDictionary[.problem]!.count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.classifiedSentencesDictionary[.problem]![$0].text)")
                        }
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.solution]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                        ForEach((0...(sentenceListViewModel.classifiedSentencesDictionary[.solution]!.count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.classifiedSentencesDictionary[.solution]![$0].text)")
                        }
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.uvp]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.uvp.rawValue)) {
                        ForEach((0...(sentenceListViewModel.classifiedSentencesDictionary[.uvp]!.count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.classifiedSentencesDictionary[.uvp]![$0].text)")
                        }
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.investment]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                        ForEach((0...(sentenceListViewModel.classifiedSentencesDictionary[.investment]!.count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.classifiedSentencesDictionary[.investment]![$0].text)")
                        }
                    }
                }
                
                if (sentenceListViewModel.classifiedSentencesDictionary[.partnership]!.count > 0) {
                    Section(header: Text(SentenceModel.Classification.partnership.rawValue)) {
                        ForEach((0...(sentenceListViewModel.classifiedSentencesDictionary[.partnership]!.count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.classifiedSentencesDictionary[.partnership]![$0].text)")
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
