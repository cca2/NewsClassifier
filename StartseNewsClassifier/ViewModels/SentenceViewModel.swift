//
//  SentenceViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 24/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class SentenceViewModel: ObservableObject, Identifiable {
    @Published var sentence:SentenceModel
    
    var text: String {
        return sentence.text
    }
    
    var id: UUID {
        return sentence.id
    }
    
    init(sentenceModel:SentenceModel) {
        self.sentence = sentenceModel
    }
    
    func classifySentenceAs(tag:SentenceModel.Classification) {
//        sentence.classification = tag
        if sentence.classifications.contains(tag) {
            sentence.classifications.removeAll() {
                classification in
                print (classification)
                return true
            }
        }
    }
}
