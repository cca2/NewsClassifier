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

//                Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
//                    ForEach(0..<newsList.newsProblemSentences.count, id: \.self) {
//                        Text("\(self.newsList.classifiedNews[self.news.id.uuidString]!.sentenceListOfType(classification: .problem)[$0].text)")
//                    }.onDelete(perform: delete)
//                }
//
//                Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
//                    ForEach(0..<self.newsList.newsSolutionSentences.count, id: \.self) {
//                        Text("\(self.newsList.classifiedNews[self.news.id.uuidString]!.sentenceListOfType(classification: .solution)[$0].text)")
//                    }.onDelete(perform: delete)
//                }
//
//
//                Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
//                    ForEach(0..<self.newsList.newsTechnologySentences.count, id: \.self) {
//                        Text("\(self.newsList.classifiedNews[self.news.id.uuidString]!.sentenceListOfType(classification: .investment)[$0].text)")
//                    }.onDelete(perform: delete)
//                }
//
//                Section(header: Text(SentenceModel.Classification.partnership.rawValue)) {
//                    ForEach(0..<self.newsList.newsInvestmentSentences.count, id: \.self) {
//                        Text("\(self.newsList.classifiedNews[self.news.id.uuidString]!.sentenceListOfType(classification: .partnership)[$0].text)")
//                    }.onDelete(perform: delete)
//                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete:\(offsets.filter{_ in true}[0])")
    }
    
    func removeSentenceFromSegmentClassification(at offsets: IndexSet) {
        print(offsets)
    }
}

struct ClassifiedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedNewsView()
    }
}
