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
        
        breakIntoSentences()

//        fetchListOfNews()
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
//        do {
//
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(self.classifiedNews)
//            let jsonFileURL = playgroundSharedDataDirectory.appendingPathComponent("classifiedStartseNews-\(self.news.id).json", isDirectory: false)
//
//            try data.write(to: jsonFileURL)
//        }catch {
//            print("Error: \(error)")
//        }
    }
    
//    private func fetchListOfNews() {
//        
//        //Verify is a jsonFile e local exists
//        let fileManager = FileManager.default
//        let path = Bundle.main.resourcePath!
//        
//        var newsIDs:[String] = []
//        
//        do {
//            let items = try fileManager.contentsOfDirectory(atPath: path)
//            for item in items {
//                if item.description.contains("StartseNews-") && item.description.contains(".json") {
//                    let name = item.description
//                    let start = name.index(name.startIndex, offsetBy: 12)
//                    let end = name.index(name.endIndex, offsetBy: -5)
//                    let range = start..<end
//                    print(name[range])
//                    newsIDs.append(String(name[range]))
//                }
//            }
//        }catch {
//            print ("Error:\(error)")
//        }
//        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        print (documentsURL)
//        
//        let documentPath = documentsURL.path
//        print(documentPath)
//        
//        
//        do {
//            for id in newsIDs {
//                let classifiedNewsPath = documentsURL.appendingPathComponent("classifiedNews-\(id).json")
//                guard let path = Bundle.main.path(forResource: "StartseNews-\(id)", ofType: "json") else { return }
//                let originalFileURL = URL(fileURLWithPath: path)
//                
//                if !fileManager.fileExists(atPath: classifiedNewsPath.path) {
//                    try fileManager.copyItem(at: originalFileURL, to: classifiedNewsPath)
//                }
//                        
//                var json: Any?
//                // Getting data from JSON file using the file URL
//                let data = try Data(contentsOf: classifiedNewsPath, options: .mappedIfSafe)
//                json = try? JSONSerialization.jsonObject(with: data)
//
//                if let dictionary = json as? [String:Any] {
//                    let item = dictionary
//                    let title = item["title"] as! String
//                    let subtitle = item["subtitle"] as! String
//                    let link = item["link"] as! String
////                    let newsModel = NewsModel(id:UUID(), title: title, subtitle: subtitle, link:link, text:"", sentences: [])
////                    self.articles.articles.append(newsModel)
////
////                    let sentences = item["sentences"] as! [[String:Any?]]
////                    for j in 0..<sentences.count {
////                        let sentence = sentences[j] as! [String:String]
////
////                        let classification = SentenceModel.Classification(rawValue: sentence["classification"]!)!
////                        let uuid = UUID(uuidString: sentence["id"]!)!
////                        let sentenceModel = SentenceModel(id:uuid, text:sentence["text"]!, classification: classification)
////                        newsModel.sentences.append(sentenceModel)
////
////                        classifiedSentencesDictionary[classification]![sentenceModel.id] = sentenceModel
////
////                        self.sentenceList.append(sentenceModel)
////                    }
//                }
//            }
//        } catch {
//            print("error: \(error)")
//        }        
//    }
}
