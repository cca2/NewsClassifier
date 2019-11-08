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
    let news:NewsModel
    
    init (data:ClassifiedNewsData) {
        recordName = data.value(forKey: "recordName") as? String
        isClassified = data.value(forKey: "isClassified") as! Bool
        let id = (data.value(forKey: "id") as! String)
        let title = data.value(forKey: "title") as! String
        let subtitle = data.value(forKey: "subtitle") as! String
        let link = data.value(forKey: "link") as! String
        let text = data.value(forKey: "text") as! String
        
        let news = NewsModel(news_id: id, title: title, subtitle: subtitle, link: link, text: text, links: [], links_text: [])
        self.news = news
    }
    
    init(record:CKRecord) throws {
        recordName = record.recordID.recordName
        do {
            let newsFile = record["newsFile"] as! CKAsset
            let decoder = JSONDecoder()
            let json = try Data(contentsOf: newsFile.fileURL!)
            let news = try decoder.decode(NewsModel.self, from: json)
            self.news = news
        }catch {
            throw error
        }
    }
    
    var recordName: String?
    
    var isClassified: Bool = false
    
    var id: UUID {
        return UUID(uuidString: news.news_id.uppercased())!
    }
    
    var title: String {
        return news.title
    }
    
    var subtitle: String {
        return news.subtitle
    }
    
    var link: String {
        return news.link
    }
    
    var text:String {
        return news.text
    }
}
