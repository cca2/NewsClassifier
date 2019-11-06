//
//  ClassifiedNewsViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation
import NaturalLanguage
import CoreData

class ClassifiedNewsViewModel: ObservableObject {
        
    var sentenceList:[SentenceModel] {
        return classifiedNews.classifiedSentences
    }
    
    
    
    let news:NewsModel
    var classifiedNews:ClassifiedNewsModel
    var context: NSManagedObjectContext
    
    @Published var classifiedSentencesDictionary:[SentenceModel.Classification:[UUID:SentenceModel]] = [:]
    
    init(news:NewsModel, context: NSManagedObjectContext) {
        self.news = news
        self.classifiedNews = ClassifiedNewsModel(newsModel: news, classifiedSentences: [])
        self.context = context

        classifiedSentencesDictionary[.none] = [:]
        classifiedSentencesDictionary[.segment] = [:]
        classifiedSentencesDictionary[.problem] = [:]
        classifiedSentencesDictionary[.solution] = [:]
        classifiedSentencesDictionary[.technology] = [:]
        classifiedSentencesDictionary[.investment] = [:]
        classifiedSentencesDictionary[.partnership] = [:]
        
        
//        fetchListOfNews()
        fetchListOfSentences()
    }
    
    private func fetchListOfSentences() {
        let request = NSFetchRequest<SentenceData>(entityName: "SentenceData")
        let predicate = NSPredicate(format: "ofNews.id == %@", news.news_id)
        request.predicate = predicate
        
        do {
            let sentenceData = try context.fetch(request)
            let sentences = sentenceData
            sentences.forEach{sentence in
                var classifications:[SentenceModel.Classification] = []
                let id = sentence.id
                let text = sentence.text
                
                if sentence.containsSegment {
                    classifications.append(.segment)
                }
                
                if sentence.containsProblem {
                    classifications.append(.problem)
                }
                
                if sentence.containsSolution {
                    classifications.append(.solution)
                }
                
                if sentence.containsTechnology {
                    classifications.append(.technology)
                }
                
                if sentence.containsInvestment {
                    classifications.append(.investment)
                }
                
                let sentenceModel = SentenceModel(id: UUID(uuidString: sentence.id!)!, text: text!, classifications: classifications)
                self.classifiedNews.classifiedSentences.append(sentenceModel)
                
                for classification in classifications {
                    self.classifiedSentencesDictionary[classification]![sentenceModel.id] = sentenceModel
                }
            }
        }catch {
            print("Error: \(error)")
        }

    }
    
    func classifySentenceAs(sentence:SentenceModel, newClassification:SentenceModel.Classification) {                
        if sentence.classifications.contains(newClassification) {
            sentence.classifications.removeAll(where: {
                $0 == newClassification
            })
            classifiedSentencesDictionary[newClassification]!.removeValue(forKey: sentence.id)
        }else {
            sentence.classifications.append(newClassification)            
        }

        if sentence.classifications.contains(newClassification) {
            classifiedSentencesDictionary[newClassification]![sentence.id] = sentence
        }
    }
    
    func removeClassification(from sentence:SentenceModel, oldClassification:SentenceModel.Classification) {
        if sentence.classifications.contains(oldClassification) {
            classifiedSentencesDictionary[oldClassification]![sentence.id] = nil
        }        
        saveClassifiedSentences()
    }
    
    func reclassifySentence(sentence:SentenceModel, as newClassification:SentenceModel.Classification) {
        if !sentence.classifications.contains(newClassification) {
            sentence.classifications.append(newClassification)
            classifiedSentencesDictionary[newClassification]![sentence.id] = sentence
        }
        
        saveClassifiedSentences()
    }
    
    func sentenceListOfType(classification: SentenceModel.Classification) -> [SentenceModel] {
        return classifiedSentencesDictionary[classification]!.values.sorted(by: {$0.id < $1.id})
    }
    
    func saveClassifiedSentences() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        print (documentsURL)
        
        let documentPath = documentsURL.path
        print(documentPath)
        
        let classifiedNewsPath = documentsURL.appendingPathComponent("classifiedNews-\(self.news.news_id).json")
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(classifiedNews)
            try data.write(to: classifiedNewsPath)
            
            //AQUI:Salva sentenças em CoreData
            
        }catch {
            print("Error:\(error)")
        }
    }            
}
