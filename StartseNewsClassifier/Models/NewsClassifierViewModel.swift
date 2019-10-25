//
//  NewsClassifierViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation
import NaturalLanguage

class NewsClassifierViewModel: ObservableObject {
    var sentenceList:[SentenceModel] {
        return classifiedNews.classifiedSentences
    }
    
    let news:NewsModel
    var classifiedNews:ClassifiedNewsModel
    
    @Published var classifiedSentencesDictionary:[SentenceModel.Classification:[UUID:SentenceModel]] = [:]
        
    init(news:NewsModel) {
        self.news = news
        self.classifiedNews = ClassifiedNewsModel(newsModel: news, classifiedSentences: [])
        classifiedSentencesDictionary[.none] = [:]
        classifiedSentencesDictionary[.segment] = [:]
        classifiedSentencesDictionary[.problem] = [:]
        classifiedSentencesDictionary[.solution] = [:]
        classifiedSentencesDictionary[.uvp] = [:]
        classifiedSentencesDictionary[.investment] = [:]
        classifiedSentencesDictionary[.partnership] = [:]
        
        fetchListOfNews()
    }
    
    func classifySentenceAs(sentence:SentenceModel, newClassification:SentenceModel.Classification) {
        
        let currentClassification = sentence.classification
        sentence.classification = newClassification

        if currentClassification != newClassification {
            classifiedSentencesDictionary[newClassification]![sentence.id] = sentence
            classifiedSentencesDictionary[currentClassification]!.removeValue(forKey: sentence.id)
        }
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
        }catch {
            print("Error:\(error)")
        }
    }
    
    private func breakIntoSentences() {
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        let text = self.news.text
        tagger.string = text
        
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .sentence, scheme: .lexicalClass, options: options) { tag, tokenRange in
            let sentence = "\(text[tokenRange].trimmingCharacters(in: .whitespacesAndNewlines))"
            let sentenceJSON = SentenceModel(id:UUID(), text: sentence, classification: .none)
            self.classifiedNews.classifiedSentences.append(sentenceJSON)
            return true
        }
    }
    
    private func fetchListOfNews() {
        //Verify is a jsonFile e local exists
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

        do {
            let classifiedNewsPath = documentsURL.appendingPathComponent("classifiedNews-\(self.news.news_id).json")
            if !fileManager.fileExists(atPath: classifiedNewsPath.path) {
                self.breakIntoSentences()
            }else {
                var json: Any?
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: classifiedNewsPath, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
                
                if let dictionary = json as? [String:Any] {
                    let item = dictionary
                    let classifiedSentences = item["classifiedSentences"] as! [[String:Any]]
                    
                    for sentence in classifiedSentences {
                        let id = sentence["id"] as! String
                        let text = sentence["text"] as! String
                        let classification = SentenceModel.Classification(rawValue: sentence["classification"] as! String)!
                        
                        let sentenceModel = SentenceModel(id: UUID(uuidString: id)!, text: text, classification: classification)
                        self.classifiedNews.classifiedSentences.append(sentenceModel)
                    }
                }
            }                
        } catch {
            print("error: \(error)")
        }
    }
}
