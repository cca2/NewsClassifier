//
//  ClassifiedNews.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ClassifiedNewsView: View {
    @ObservedObject private var sentenceListViewModel:SentenceListViewModel
    
    var body: some View {
        VStack {
            Text("Notícia").font(.title)
            List {
                if (sentenceListViewModel.sentenceListOfType(classification: .segment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .segment).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .segment)[$0].text)")
                        }.onDelete(perform: removeSentenceFromSegmentClassification)
                    }
                }
                
                if (sentenceListViewModel.sentenceListOfType(classification: .problem).count > 0) {
                    Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .problem).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .problem)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                
                if (sentenceListViewModel.sentenceListOfType(classification: .uvp).count > 0) {
                    Section(header: Text(SentenceModel.Classification.uvp.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .uvp).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .uvp)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                

                if (sentenceListViewModel.sentenceListOfType(classification: .solution).count > 0) {
                    Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .solution).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .solution)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                

                if (sentenceListViewModel.sentenceListOfType(classification: .investment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .investment).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .investment)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
                
                if (sentenceListViewModel.sentenceListOfType(classification: .partnership).count > 0) {
                    Section(header: Text(SentenceModel.Classification.partnership.rawValue)) {
                        ForEach((0...(sentenceListViewModel.sentenceListOfType(classification: .partnership).count - 1)), id: \.self) {
                            Text("\(self.sentenceListViewModel.sentenceListOfType(classification: .partnership)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
            }.onAppear() {
                print("Hello")
            }
        }
    }
    
    init(sentenceListViewModel:SentenceListViewModel) {
        self.sentenceListViewModel = sentenceListViewModel
    }
    
    func delete(at offsets: IndexSet) {
        print("delete:\(offsets)")
    }
    
    func removeSentenceFromSegmentClassification(at offsets: IndexSet) {
    }
}

struct ClassifiedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedNewsView(sentenceListViewModel: SentenceListViewModel())
    }
}
