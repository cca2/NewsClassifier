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
    
    @Published var classifiedSentences:[SentenceViewModel] = []

    var news:NewsViewModel? {
        didSet {
            guard let currentNews = news else { return }
            guard let s = self.classifiedNews[currentNews.id.uuidString.lowercased()] else { return }

            let segmentSentences = s.sentenceListOfType(classification: .segment)
            var sentencesViewModels:[SentenceViewModel] = []
            for sentence in segmentSentences {
                let sentenceViewModel = SentenceViewModel(sentenceModel: sentence)
                sentencesViewModels.append(sentenceViewModel)
                self.classifiedSentences.append(sentenceViewModel)
            }
            newsSegmentSentences = sentencesViewModels
            
            let problemSentences = s.sentenceListOfType(classification: .problem)
            sentencesViewModels = []
            for sentence in problemSentences {
                let sentenceViewModel = SentenceViewModel(sentenceModel: sentence)
                sentencesViewModels.append(sentenceViewModel)
                self.classifiedSentences.append(sentenceViewModel)
            }
            self.newsProblemSentences = sentencesViewModels
            
            let solutionSentences = s.sentenceListOfType(classification: .solution)
            sentencesViewModels = []
            for sentence in solutionSentences {
                let sentenceViewModel = SentenceViewModel(sentenceModel: sentence)
                sentencesViewModels.append(sentenceViewModel)
                self.classifiedSentences.append(sentenceViewModel)
            }
            self.newsSolutionSentences = sentencesViewModels
            
            let technologySentences = s.sentenceListOfType(classification: .technology)
            sentencesViewModels = []
            for sentence in technologySentences {
                let sentenceViewModel = SentenceViewModel(sentenceModel: sentence)
                sentencesViewModels.append(sentenceViewModel)
                self.classifiedSentences.append(sentenceViewModel)
            }
            self.newsTechnologySentences = sentencesViewModels
            
            let investmentSentences = s.sentenceListOfType(classification: .investment)
            sentencesViewModels = []
            for sentence in investmentSentences {
                let sentenceViewModel = SentenceViewModel(sentenceModel: sentence)
                sentencesViewModels.append(sentenceViewModel)
                self.classifiedSentences.append(sentenceViewModel)
            }
            self.newsInvestmentSentences = sentencesViewModels
        }
    }
    
    func removeClassificationAtIndex(at index:Int, classification: SentenceModel.Classification) {
      classifySentenceAtIndexAs(at: index, newClassification: classification)
    }

    func removeSentenceClassification(sentence:SentenceViewModel, classification: SentenceModel.Classification) {
        sentence.removeClassification(classification: classification)
    }
    
    func classifySentence(sentence: SentenceViewModel, as newClassification:SentenceModel.Classification) {
        if !sentence.sentence.classifications.contains(newClassification) {
            sentence.sentence.classifications.append(newClassification)
        }
    }

    
    func classifySentenceAtIndexAs(at index:Int, newClassification: SentenceModel.Classification) {
        guard let currentNews = news else { return }
        guard let classifier = classifiedNews[currentNews.id.uuidString.lowercased()] else { return }
        let sentence = classifier.sentenceList[index]
        classifier.classifySentenceAs(sentence: sentence, newClassification: newClassification)
        
        //Atualizando as listas de sentenças classificadas para se mostrar na View
        let sentences = classifier.sentenceListOfType(classification: newClassification)
        var sentencesViewModels:[SentenceViewModel] = []
        for sentence in sentences {
            let sentenceViewModel = SentenceViewModel(sentenceModel: sentence)
            sentencesViewModels.append(sentenceViewModel)
        }
        
        if newClassification == .segment {
            newsSegmentSentences = sentencesViewModels
        }else if newClassification == .problem {
            newsProblemSentences = sentencesViewModels
        }else if newClassification == .solution {
            newsSolutionSentences = sentencesViewModels
        }else if newClassification == .technology {
            newsTechnologySentences = sentencesViewModels
        }else if newClassification == .investment {
            newsInvestmentSentences = sentencesViewModels
        }
        
        classifier.saveClassifiedSentences()
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
