//
//  ContentView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 19/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

protocol ActOnClassification {
    func finishedClassification()
    func restartClassification()
}

struct ClassifyOrFinishView: View, ActOnClassification {
    @State var hasFinishedClassification = false

    private let news:NewsModel
    
    var body: some View {
        Group {
            if (hasFinishedClassification) {
                FinishedClassificationView(actOnFinishedClassification: self, news: self.news)
            }else {
                ClassificationView(actOnClassification: self, news: self.news)
            }
        }
    }
    
    init (news:NewsModel) {
        self.news = news
    }
    
    func finishedClassification() {
        hasFinishedClassification = true
    }
    
    func restartClassification() {
        hasFinishedClassification = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifyOrFinishView(news: NewsModel(news_id: "001", title: "Isto é um título", subtitle: "Agora vai mesmo porque é assim", link: "http://cin.ufpe.br", text: "Isto é um texto muito grande", links: [], links_text: []))
    }
}
