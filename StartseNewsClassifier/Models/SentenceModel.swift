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
//    let news:NewsModel
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
    
    
    enum CodingKeys: String, CodingKey {
        case text
        case classification
    }
    
    init(news:NewsModel, text:String, classification:SentenceModel.Classification) {
//        self.news = news
        self.text = text
        self.classification = classification
    }
}

extension SentenceModel: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(classification.rawValue, forKey: .classification)
    }
}
