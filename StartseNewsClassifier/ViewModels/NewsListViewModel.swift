//
//  NewsListViewModel.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 26/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import Foundation

class NewsListViewModel: ObservableObject {

    @Published var articles:[NewsViewModel] = []

    func loadLatestNews() {
        StartseNewsService().loadLatestNews() {
            articles in
            for news in articles {
                self.articles.append(NewsViewModel(news: news))
            }
        }
    }
    
    init() {
        loadLatestNews()
    }
}
