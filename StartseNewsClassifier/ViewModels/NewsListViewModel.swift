//
//  NewsListViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 26/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class NewsListViewModel: ObservableObject {
    
    @Published var articles:[NewsViewModel] = []
    @Published var classifiedNews:[String:ClassifiedNewsViewModel] = [:]
        
    @Published var newsSegmentSentences:[SentenceViewModel] = []
    @Published var newsProblemSentences:[SentenceViewModel] = []
    @Published var newsSolutionSentences:[SentenceViewModel] = []
    @Published var newsTechnologySentences:[SentenceViewModel] = []
    @Published var newsInvestmentSentences:[SentenceViewModel] = []
    
    var news:NewsViewModel? {
        didSet {
            guard let currentNews = news else { return }
            print(">>> Valendo: \(currentNews.id.uuidString) <<<")
            guard let s = self.classifiedNews[currentNews.id.uuidString.lowercased()] else { return }
            let sentences = s.sentenceListOfType(classification: .segment)
            var sentencesViewModels:[SentenceViewModel] = []
            for sentence in sentences {
                let sentenceViewModel = SentenceViewModel(sentenceModel: sentence)
                sentencesViewModels.append(sentenceViewModel)
            }
            newsSegmentSentences = sentencesViewModels
        }
    }
    
    func classifySentenceAtIndexAs(at index:Int, newClassification: SentenceModel.Classification) {
        guard let currentNews = news else { return }
        guard let classifier = classifiedNews[currentNews.id.uuidString.lowercased()] else { return }
        let sentence = classifier.sentenceList[index]
        classifier.classifySentenceAs(sentence: sentence, newClassification: newClassification)
    }
    
    func loadLatestNews() {
        StartseNewsService().loadLatestNews() {
            articles in
            for news in articles {
                self.articles.append(NewsViewModel(news: news))
                self.classifiedNews[news.news_id] = ClassifiedNewsViewModel(news: news)
            }
            if articles.count > 0 {
                self.news = NewsViewModel(news: articles[0])
            }
        }
    }
    
    init() {
        loadLatestNews()
    }
}
