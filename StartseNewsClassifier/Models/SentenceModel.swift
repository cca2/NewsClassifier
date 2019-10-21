//
//  SentenceModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class SentenceModel: Identifiable {
    let id:UUID
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
        case id
        case text
        case classification
    }
    
    
    init(text:String, classification:SentenceModel.Classification) {
        self.id = UUID()
        self.text = text
        self.classification = classification
    }
    
    init (id:UUID, text:String, classification:SentenceModel.Classification) {
        self.text = text
        self.classification = classification
        self.id = id
    }
}

extension SentenceModel: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(classification.rawValue, forKey: .classification)
    }
}
