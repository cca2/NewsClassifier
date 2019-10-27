//
//  SentenceViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 24/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class SentenceViewModel: ObservableObject {
    @Published var sentence:SentenceModel
    
    
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
