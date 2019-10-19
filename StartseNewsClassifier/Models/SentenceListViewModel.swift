//
//  SentenceListViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class SentenceListViewModel: ObservableObject {
    var startseNewsList:[NewsModel] = []
    var sentenceList:[SentenceModel] = []
    @Published var classifiedSentencesDictionary:[SentenceModel.Classification:[UUID:SentenceModel]] = [:]
        
    init() {
        fetchListOfNews()
        classifiedSentencesDictionary[.none] = [:]
        classifiedSentencesDictionary[.segment] = [:]
        classifiedSentencesDictionary[.problem] = [:]
        classifiedSentencesDictionary[.solution] = [:]
        classifiedSentencesDictionary[.uvp] = [:]
        classifiedSentencesDictionary[.investment] = [:]
        classifiedSentencesDictionary[.partnership] = [:]
    }
    
    func classifySentenceAs(sentence:SentenceModel, newClassification:SentenceModel.Classification) {
        
        let currentClassification = sentence.classification
        sentence.classification = newClassification

        if currentClassification != newClassification {
            classifiedSentencesDictionary[newClassification]![sentence.id] = sentence
//            classifiedSentencesDictionary[newClassification]?.contains{
//                element in
//                if element.key == sentence.id {
//                    return true
//                }
//                return false
//            }
        }
    }
    
    func sentenceListOfType(classification: SentenceModel.Classification) -> [SentenceModel] {
        return classifiedSentencesDictionary[classification]!.values.sorted(by: {$0.id < $1.id})
    }
    
    private func fetchListOfNews() {
        var json: Any?
        if let path = Bundle.main.path(forResource: "StartseNews", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
                
                if let dictionary = json as? [String:Any] {
                    if let items = dictionary["articles"] as? [[String:Any]] {
                        for i in 0..<items.count {
                            let item = items[i]
                            let title = ">>> NO TITLE <<<"
                            let link = item["link"] as! String
                            let newsModel = NewsModel(title: title, link:link, text:"")
                            
                            let sentences = item["sentences"] as! [[String:Any?]]
                            for j in 0..<sentences.count {
                                let sentence = sentences[j] as! [String:String]
                                let sentenceModel = SentenceModel(news:newsModel, text:sentence["text"]!)
                                self.sentenceList.append(sentenceModel)
                            }
                        }
                    }
                }
            } catch {
                // Handle error here
            }
        }
    }
}
