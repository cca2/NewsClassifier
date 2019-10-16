//
//  NewsModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class NewsModel {
    let title:String
    let link:String
    let text:String
    
    var classification:String = ">>> NONE <<<"
    
    init(title:String, link:String, text:String) {
        self.title = title
        self.link = link
        self.text = text
    }
}

class SentenceModel {
    let news:NewsModel
    var text:String
    var classification:String = ">>> NONE <<<"
    
    init(news:NewsModel, text:String) {
        self.news = news
        self.text = text
    }
}

