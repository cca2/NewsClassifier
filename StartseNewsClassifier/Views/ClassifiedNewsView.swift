//
//  ClassifiedNews.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ClassifiedNewsView: View {
    @ObservedObject private var classifier:NewsClassifierViewModel
    
    var body: some View {
        VStack {
            Text("Notícia").font(.title)
            List {
                if (classifier.sentenceListOfType(classification: .segment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                        ForEach((0...(classifier.sentenceListOfType(classification: .segment).count - 1)), id: \.self) {
                            Text("\(self.classifier.sentenceListOfType(classification: .segment)[$0].text)")
                        }.onDelete(perform: removeSentenceFromSegmentClassification)
                    }
                }
                
                if (classifier.sentenceListOfType(classification: .problem).count > 0) {
                    Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                        ForEach((0...(classifier.sentenceListOfType(classification: .problem).count - 1)), id: \.self) {
                            Text("\(self.classifier.sentenceListOfType(classification: .problem)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                
                if (classifier.sentenceListOfType(classification: .uvp).count > 0) {
                    Section(header: Text(SentenceModel.Classification.uvp.rawValue)) {
                        ForEach((0...(classifier.sentenceListOfType(classification: .uvp).count - 1)), id: \.self) {
                            Text("\(self.classifier.sentenceListOfType(classification: .uvp)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                

                if (classifier.sentenceListOfType(classification: .solution).count > 0) {
                    Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                        ForEach((0...(classifier.sentenceListOfType(classification: .solution).count - 1)), id: \.self) {
                            Text("\(self.classifier.sentenceListOfType(classification: .solution)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                

                if (classifier.sentenceListOfType(classification: .investment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                        ForEach((0...(classifier.sentenceListOfType(classification: .investment).count - 1)), id: \.self) {
                            Text("\(self.classifier.sentenceListOfType(classification: .investment)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                
                if (classifier.sentenceListOfType(classification: .partnership).count > 0) {
                    Section(header: Text(SentenceModel.Classification.partnership.rawValue)) {
                        ForEach((0...(classifier.sentenceListOfType(classification: .partnership).count - 1)), id: \.self) {
                            Text("\(self.classifier.sentenceListOfType(classification: .partnership)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
            }.onAppear() {
                print("Hello")
            }
        }
    }
    
    init(newsClassifierViewModel:NewsClassifierViewModel) {
        self.classifier = newsClassifierViewModel
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
