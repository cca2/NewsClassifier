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
    private var news:NewsModel
    
    var body: some View {
        VStack {
            Text("Classificação").font(.headline)
            
            List {
                if (newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .segment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                        ForEach((0...(newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .segment).count - 1)), id: \.self) {
                            Text("\(self.newsList.classifiedNews[self.news.news_id]!.sentenceListOfType(classification: .segment)[$0].text)")
                        }.onDelete(perform: removeSentenceFromSegmentClassification)
                    }
                }
                
                if (newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .problem).count > 0) {
                    Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                        ForEach((0...(newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .problem).count - 1)), id: \.self) {
                            Text("\(self.newsList.classifiedNews[self.news.news_id]!.sentenceListOfType(classification: .problem)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }

                if (newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .uvp).count > 0) {
                    Section(header: Text(SentenceModel.Classification.uvp.rawValue)) {
                        ForEach((0...(newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .uvp).count - 1)), id: \.self) {
                            Text("\(self.newsList.classifiedNews[self.news.news_id]!.sentenceListOfType(classification: .uvp)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }


                if (newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .solution).count > 0) {
                    Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                        ForEach((0...(newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .solution).count - 1)), id: \.self) {
                            Text("\(self.newsList.classifiedNews[self.news.news_id]!.sentenceListOfType(classification: .solution)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }


                if (newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .investment).count > 0) {
                    Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                        ForEach((0...(newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .investment).count - 1)), id: \.self) {
                            Text("\(self.newsList.classifiedNews[self.news.news_id]!.sentenceListOfType(classification: .investment)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }

                if (newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .partnership).count > 0) {
                    Section(header: Text(SentenceModel.Classification.partnership.rawValue)) {
                        ForEach((0...(newsList.classifiedNews[news.news_id]!.sentenceListOfType(classification: .partnership).count - 1)), id: \.self) {
                            Text("\(self.newsList.classifiedNews[self.news.news_id]!.sentenceListOfType(classification: .partnership)[$0].text)")
                        }.onDelete(perform: delete)
                    }
                }
            }
        }
    }
    
    init (news:NewsModel) {
        self.news = news
    }
        
    func delete(at offsets: IndexSet) {
        print("delete:\(offsets)")
    }
    
    func removeSentenceFromSegmentClassification(at offsets: IndexSet) {
    }
}

struct ClassifiedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedNewsView(news: NewsModel(news_id: "001", title: "Isto é um título", subtitle: "Agora vai mesmo porque é assim", link: "http://cin.ufpe.br", text: "Isto é um texto muito grande", links: [], links_text: []))
    }
}
