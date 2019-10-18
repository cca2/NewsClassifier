//
//  SentenceModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class SentenceModel: Identifiable {
    let id = UUID()
    let news:NewsModel
    var text:String
    var classification:Classification = .none
    
    enum Classification:String {
        case none = "#None"
        case segment = "#Segment"
        case problem = "#Problem"
        case solution = "#Features"
        case uvp = "#UVP"
        case investment = "#Investment"
        case partnership = "#Partnership"
    }
    
    init(news:NewsModel, text:String) {
        self.news = news
        self.text = text
    }
}
