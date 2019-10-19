//
//  TabbarView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct TabbarView: View {
    @State var selectedView = 0
    private let sentenceListViewModel = SentenceListViewModel()
    var body: some View {
        TabView(selection: $selectedView) {
            ClassificationView(sentenceList: sentenceListViewModel)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Classificação")
                }.tag(0)
            ClassifiedNewsView(sentenceListViewModel: sentenceListViewModel)
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Notícia")
                }.tag(1)
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
