//
//  NewsModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class NewsModel: Encodable, Decodable{
    let news_id: String
    let title:String
    let subtitle:String
    let link:String
    let text:String
    
    let links:[String]
    let links_text:[String]
    
//    var sentences:[SentenceModel]
//    var classification:String = ">>> NONE <<<"
//    
//    init(id:UUID, title:String, subtitle:String, link:String, text:String, sentences:[SentenceModel]) {
//        self.id = id
//        self.title = title
//        self.subtitle = subtitle
//        self.link = link
//        self.text = text
//        self.sentences = sentences
//    }
}

class Articles: Encodable {
    var articles:[NewsModel] = []
}

