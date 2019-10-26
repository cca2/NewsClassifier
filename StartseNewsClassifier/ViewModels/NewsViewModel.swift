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
import CloudKit

import NaturalLanguage

class NewsViewModel: Identifiable {
    var news:NewsModel?
    
    init(news:NewsModel) {
        self.news = news
    }
    
    init(newsFile:URL) throws{
        let decoder = JSONDecoder()
        do {
            let json = try Data(contentsOf: newsFile)
            news = try decoder.decode(NewsModel.self, from: json)
        }catch {
            throw error
        }
    }
    
    var id: UUID {
        return UUID(uuidString: news!.news_id)!
    }
    
    var title: String {
        return news!.title
    }
    
    var subtitle: String {
        return news!.subtitle
    }
    
    var link: String {
        return news!.link
    }
    
    var text:String {
        return news!.text
    }
}
