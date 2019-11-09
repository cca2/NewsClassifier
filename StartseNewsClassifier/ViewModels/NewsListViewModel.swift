//
//  NewsListViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 26/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation
import CoreData
import NaturalLanguage

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
    
    var currentNewsIndex = 0
    
    
    private var context:NSManagedObjectContext?
    
    var totalClassifiedNews:Int {
        let defaults = UserDefaults.standard
        let val = defaults.integer(forKey: "totalClassifiedNews")
        return val
    }
    
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
        
        saveSentence(sentence: sentence, context: self.context!)
    }
    
    func  numMarkAsClassifiedNews() -> Int {
        let markAsClassifiedNews = articles.filter{
            $0.isClassified == true
        }
        
        return markAsClassifiedNews.count
    }
    
    func deleteAllSentences(context: NSManagedObjectContext) {
        let request = NSFetchRequest<SentenceData>(entityName: "SentenceData")
        let predicate = NSPredicate(value: true)
        request.predicate = predicate
        
        do {
            let sentencesData = try context.fetch(request)
            sentencesData.forEach{
                sentence in
                context.delete(sentence)
            }
            try context.save()
        }catch {
            print ("error:\(error)")
        }
    }

    func loadLatestNews(context: NSManagedObjectContext) {
        self.context = context
        var articles:[NewsViewModel] = []
        self.currentNewsIndex = 0
        
        self.isLoading = true
        
        do {
            let result = try context.fetch(self.fetchAllNews())
            for data in result {
                let news = NewsViewModel(data: data)
                articles.append(news)
                self.classifiedNews[news.id.uuidString.lowercased()] = ClassifiedNewsViewModel(news: news.news, context: context)

//                UserDefaults.standard.set(0, forKey: "totalClassifiedNews")
//                context.delete(data)
//                deleteAllSentences(context: context)
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
                        //Salva em CoreData as novas notícias vindas do CloudKit
                        articles.append(newsModel)

                        let news = ClassifiedNewsData(context: context)
                        news.recordName = record.recordID.recordName
                        news.id = newsModel.id.uuidString
                        news.isClassified = false
                        news.title = newsModel.title
                        news.subtitle = newsModel.subtitle
                        news.link = newsModel.link
                        news.text = newsModel.text
                        try context.save()
                        //Quebra a notícia em sentença e salva em CoreData
                        let sentences = self.breakIntoSentences(news: newsModel.news)

                        try sentences.forEach{ sentence in
                            let sentenceData = SentenceData(context: context)
                            sentenceData.containsSegment = false
                            sentenceData.containsProblem = false
                            sentenceData.containsSolution = false
                            sentenceData.containsTechnology = false
                            sentenceData.containsInvestment = false

                            sentenceData.id = sentence.id.uuidString
                            sentenceData.text = sentence.text
                            sentenceData.ofNews = news
                            try context.save()
                        }
                        self.classifiedNews[newsModel.id.uuidString.lowercased()] = ClassifiedNewsViewModel(news: newsModel.news, context: context)                        
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
    private func saveSentence(sentence: SentenceModel, context:NSManagedObjectContext) {
        let sentenceId:UUID = sentence.id
        let request = NSFetchRequest<SentenceData>(entityName: "SentenceData")
        let predicate = NSPredicate(format: "id = %@", sentenceId.uuidString)
        request.predicate = predicate
        
        do {
            let sentenceData = try context.fetch(request)
            let sentenceToUpdate = sentenceData[0]

            let containsSegment = sentence.classifications.contains(.segment)
            let containsProblem = sentence.classifications.contains(.problem)
            let containsSolution = sentence.classifications.contains(.solution)
            let containsTechnology = sentence.classifications.contains(.technology)
            let containsInvestment = sentence.classifications.contains(.investment)
            
            
            sentenceToUpdate.setValue(containsSegment, forKey: "containsSegment")
            sentenceToUpdate.setValue(containsProblem, forKey: "containsProblem")
            sentenceToUpdate.setValue(containsSolution, forKey: "containsSolution")
            sentenceToUpdate.setValue(containsTechnology, forKey: "containsTechnology")
            sentenceToUpdate.setValue(containsInvestment, forKey: "containsInvestment")
    
            try context.save()

        }catch {
            print("Error: \(error)")
        }

    }

    private func breakIntoSentences(news: NewsModel) -> [SentenceModel] {
        var result:[SentenceModel] = []
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        var text = news.text
        text = text.replacingOccurrences(of: ".", with: ". ").trimmingCharacters(in: .whitespacesAndNewlines)
        
        tagger.string = text
        
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .sentence, scheme: .lexicalClass, options: options) { tag, tokenRange in
            let sentence = "\(text[tokenRange].trimmingCharacters(in: .whitespacesAndNewlines))"
            let sentenceModel = SentenceModel(id:UUID(), text: sentence, classifications: [])
            result.append(sentenceModel)
            return true
        }
        
        return result
    }

    func fetchAllNews() -> NSFetchRequest<ClassifiedNewsData> {
        let request = NSFetchRequest<ClassifiedNewsData>(entityName: "ClassifiedNewsData")
        request.sortDescriptors = [NSSortDescriptor(key: "recordName", ascending: true)]
        return request
    }
        
    func updateNewsClassificationStatus(isClassified:Bool, context:NSManagedObjectContext) {
        let defaults = UserDefaults.standard
        let totalClassifiedNews = defaults.integer(forKey: "totalClassifiedNews")
        
        let request = NSFetchRequest<ClassifiedNewsData>(entityName: "ClassifiedNewsData")
        let predicate = NSPredicate(format: "recordName = %@", self.news!.recordName!)
        request.predicate = predicate
        
        do {
            let newsData = try context.fetch(request)
            let newsToUpdate = newsData[0]
            newsToUpdate.setValue(isClassified, forKey: "isClassified")
            self.news?.isClassified = isClassified
    
            try context.save()
            
            defaults.set(totalClassifiedNews + 1, forKey: "totalClassifiedNews")
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
