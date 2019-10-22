//
//  NewsModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class NewsModel: Encodable{
    let title:String
    let subtitle:String
    let link:String
    let text:String
    
    var sentences:[SentenceModel]
    var classification:String = ">>> NONE <<<"
    
    init(title:String, subtitle:String, link:String, text:String, sentences:[SentenceModel]) {
        self.title = title
        self.subtitle = subtitle
        self.link = link
        self.text = text
        self.sentences = sentences
    }
}

class Articles: Encodable {
    var articles:[NewsModel] = []
}

