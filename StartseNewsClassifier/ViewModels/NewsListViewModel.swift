//
//  NewsListViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 26/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation
import CoreData

class NewsListViewModel: ObservableObject {
    @Published var articles:[NewsViewModel] = []
    @Published var classifiedNews:[String:ClassifiedNewsViewModel] = [:]
        
    @Published var newsSegmentSentences:[SentenceViewModel] = []
    @Published var newsProblemSentences:[SentenceViewModel] = []
    @Published var newsSolutionSentences:[SentenceViewModel] = []
    @Published var newsTechnologySentences:[SentenceViewModel] = []
    @Published var newsInvestmentSentences:[SentenceViewModel] = []
    
    @Published var classifiedSentences:[SentenceViewModel] = []
    
    @Published var isLoading:Bool = false
    
    @Published var classificationCompleted:Bool = false

    var newsView:NewsView?
    
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
        guard let currentNews = news else { return }
        guard let classifier = classifiedNews[currentNews.id.uuidString.lowercased()] else { return }
        classifier.removeClassification(from: sentence.sentence, oldClassification: classification)
    }
    
    func reclassifySentence(sentence: SentenceViewModel, as newClassification:SentenceModel.Classification) {
        guard let currentNews = news else { return }
        guard let classifier = classifiedNews[currentNews.id.uuidString.lowercased()] else { return }
        
        classifier.reclassifySentence(sentence: sentence.sentence, as: newClassification)
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
    
    func  numMarkAsClassifiedNews() -> Int {
        let markAsClassifiedNews = articles.filter{
            $0.isClassified == true
        }
        
        return markAsClassifiedNews.count
    }
    
    func loadLatestNews(context: NSManagedObjectContext) {
        var articles:[NewsViewModel] = []
        
        self.isLoading = true
        do {
            let result = try context.fetch(self.fetchAllNews())
            for data in result {
                let news = NewsViewModel(data: data)
                articles.append(news)
                self.classifiedNews[news.id.uuidString.lowercased()] = ClassifiedNewsViewModel(news: news.news)
//                context.delete(data)
//                try context.save()
            }
        }catch {
            print("Error:\(error)")
        }

        StartseNewsService().loadLatestNews() {
            records in
            records.forEach {
                record in
                do {
                    let newsModel = try NewsViewModel(record: record)
                    if !articles.contains(where: {
                        $0.recordName == newsModel.recordName
                    }) {
                        articles.append(newsModel)
                        self.classifiedNews[newsModel.id.uuidString.lowercased()] = ClassifiedNewsViewModel(news: newsModel.news)
                        let news = NewsData(context: context)
                        news.recordName = record.recordID.recordName
                        news.id = newsModel.id
                        news.isClassified = false
                        news.title = newsModel.title
                        news.subtitle = newsModel.subtitle
                        news.link = newsModel.link
                        news.text = newsModel.text
                        try context.save()
                    }
                }catch {
                    print("Error: \(error)")
                }
            }

            articles.removeAll(where: {
                $0.isClassified == true
            })

            if articles.count > 0 {
                //Separa as primeiras 3 notícias não classificadas para classificação
                var firstThreeNews:[NewsViewModel] = []
                if articles.count >= 3 {
                    firstThreeNews = Array(articles[0...2])
                }else {
                    firstThreeNews = Array(articles[0..<articles.count])
                }
                self.articles = firstThreeNews
                self.news = articles[0]
            }
            self.isLoading = false
        }
    }
}

extension NewsListViewModel {
    func fetchAllNews() -> NSFetchRequest<NewsData> {
        let request = NSFetchRequest<NewsData>(entityName: "NewsData")
        request.sortDescriptors = [NSSortDescriptor(key: "recordName", ascending: true)]
        return request
    }
    
    func updateNewsClassificationStatus(isClassified:Bool, context:NSManagedObjectContext) {
        let request = NSFetchRequest<NewsData>(entityName: "NewsData")
        let predicate = NSPredicate(format: "recordName = %@", self.news!.recordName!)
        request.predicate = predicate
        
        do {
            let newsData = try context.fetch(request)
            let newsToUpdate = newsData[0]
            newsToUpdate.setValue(isClassified, forKey: "isClassified")
            self.news?.isClassified = isClassified
    
            try context.save()
            
            if articles.count == self.numMarkAsClassifiedNews() {
                self.classificationCompleted = true
            }else {
                self.classificationCompleted = false
            }
        }catch {
            print("Error:\(error)")
        }
    }    
}
