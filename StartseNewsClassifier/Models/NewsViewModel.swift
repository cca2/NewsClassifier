//
//  NewsViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NewsViewModel: Identifiable {
    let id = UUID()
    let news:NewsModel
    
    init(news:NewsModel) {
        self.news = news
    }
    
    var title: String {
        return news.title
    }
    
    var link: String {
        return news.link
    }
    
    var text:String {
        return news.text
    }
}

class SentenceViewModel: ObservableObject {
    @Published var sentence:SentenceModel
    
    
    init(sentenceModel:SentenceModel) {
        self.sentence = sentenceModel
    }
    
    func classifySentenceAs(tag:String) {
        sentence.classification = tag
    }
}

class SentenceListViewModel {
    var startseNewsList:[NewsModel] = []
    var sentenceList:[SentenceModel] = []
    
    init() {
        fetchListOfNews()
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
