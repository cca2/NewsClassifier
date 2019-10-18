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
