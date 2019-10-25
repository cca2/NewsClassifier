//
//  ClassifiedNews.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ClassifiedNewsView: View {
    @ObservedObject private var NewsClassifierViewModel:NewsClassifierViewModel
    
    var body: some View {
        VStack {
            Text("Notícia").font(.title)
            List {
                if (NewsClassifierViewModel.sentenceListOfType(classification: .segment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                        ForEach((0...(NewsClassifierViewModel.sentenceListOfType(classification: .segment).count - 1)), id: \.self) {
                            Text("\(self.NewsClassifierViewModel.sentenceListOfType(classification: .segment)[$0].text)")
                        }.onDelete(perform: removeSentenceFromSegmentClassification)
                    }
                }
                
                if (NewsClassifierViewModel.sentenceListOfType(classification: .problem).count > 0) {
                    Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                        ForEach((0...(NewsClassifierViewModel.sentenceListOfType(classification: .problem).count - 1)), id: \.self) {
                            Text("\(self.NewsClassifierViewModel.sentenceListOfType(classification: .problem)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                
                if (NewsClassifierViewModel.sentenceListOfType(classification: .uvp).count > 0) {
                    Section(header: Text(SentenceModel.Classification.uvp.rawValue)) {
                        ForEach((0...(NewsClassifierViewModel.sentenceListOfType(classification: .uvp).count - 1)), id: \.self) {
                            Text("\(self.NewsClassifierViewModel.sentenceListOfType(classification: .uvp)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                

                if (NewsClassifierViewModel.sentenceListOfType(classification: .solution).count > 0) {
                    Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                        ForEach((0...(NewsClassifierViewModel.sentenceListOfType(classification: .solution).count - 1)), id: \.self) {
                            Text("\(self.NewsClassifierViewModel.sentenceListOfType(classification: .solution)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                

                if (NewsClassifierViewModel.sentenceListOfType(classification: .investment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                        ForEach((0...(NewsClassifierViewModel.sentenceListOfType(classification: .investment).count - 1)), id: \.self) {
                            Text("\(self.NewsClassifierViewModel.sentenceListOfType(classification: .investment)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                
                if (NewsClassifierViewModel.sentenceListOfType(classification: .partnership).count > 0) {
                    Section(header: Text(SentenceModel.Classification.partnership.rawValue)) {
                        ForEach((0...(NewsClassifierViewModel.sentenceListOfType(classification: .partnership).count - 1)), id: \.self) {
                            Text("\(self.NewsClassifierViewModel.sentenceListOfType(classification: .partnership)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
            }.onAppear() {
                print("Hello")
            }
        }
    }
    
    init(NewsClassifierViewModel:NewsClassifierViewModel) {
        self.NewsClassifierViewModel = NewsClassifierViewModel
    }
    
    func delete(at offsets: IndexSet) {
        print("delete:\(offsets)")
    }
    
    func removeSentenceFromSegmentClassification(at offsets: IndexSet) {
    }
}

//struct ClassifiedNewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClassifiedNewsView(NewsClassifierViewModel: NewsClassifierViewModel())
//    }
//}
