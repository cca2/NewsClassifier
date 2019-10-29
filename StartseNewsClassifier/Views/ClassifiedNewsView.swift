//
//  ClassifiedNews.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ClassifiedNewsView: View {
    @EnvironmentObject var newsList:NewsListViewModel
    
    var body: some View {
        VStack {
            Text("Classificação").font(.headline)
            
            List {
                Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                    ForEach(0..<newsList.newsSegmentSentences.count) {
                        Text("\(self.newsList.newsSegmentSentences[$0].sentence.text)")
                    }.onDelete(perform: removeSentenceFromSegmentClassification)
                }

                Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                    ForEach(0..<newsList.newsProblemSentences.count) {
                        Text("\(self.newsList.newsProblemSentences[$0].sentence.text)")
                    }.onDelete(perform: removeSentenceFromProblemClassification)
                }

                Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                    ForEach(0..<newsList.newsSolutionSentences.count) {
                        Text("\(self.newsList.newsSolutionSentences[$0].sentence.text)")
                    }.onDelete(perform: removeSentenceFromSolutionClassification)
                }

                Section(header: Text(SentenceModel.Classification.uvp.rawValue)) {
                    ForEach(0..<newsList.newsTechnologySentences.count) {
                        Text("\(self.newsList.newsTechnologySentences[$0].sentence.text)")
                    }.onDelete(perform: removeSentenceFromTechnologyClassification)
                }

                Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                    ForEach(0..<newsList.newsInvestmentSentences.count) {
                        Text("\(self.newsList.newsInvestmentSentences[$0].sentence.text)")
                    }.onDelete(perform: removeSentenceFromInvestmentClassification)
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete:\(offsets.filter{_ in true}[0])")
    }
    
    func removeSentenceFromSegmentClassification(at offsets: IndexSet) {
        print(offsets)
    }
    
    func removeSentenceFromProblemClassification(at offset: IndexSet) {
        
    }
    
    func removeSentenceFromSolutionClassification(at offset: IndexSet) {
        
    }
    
    func removeSentenceFromTechnologyClassification(at offset: IndexSet) {
        
    }
    
    func removeSentenceFromInvestmentClassification(at offset: IndexSet) {
        
    }
}

struct ClassifiedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedNewsView()
    }
}
