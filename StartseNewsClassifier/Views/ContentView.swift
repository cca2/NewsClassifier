//
//  ContentView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 20/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI
import CloudKit

struct ContentView: View {

    @EnvironmentObject var newsList:NewsListViewModel
    
    
    @State var selectedView = 0
    @State private var currentNewsIndex = 0
    
    private let dateFormater = DateFormatter()
    
    //Acessando o contexto para CoreData
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        return
//        TabView(selection: $selectedView) {
            NavigationView {
                HStack {
                    if !(self.newsList.articles.count == 0) {
                        NewsView(title: newsList.articles[currentNewsIndex].title, subtitle: newsList.articles[currentNewsIndex].subtitle, numNews: newsList.articles.count, date: dateFormater.string(from: Date()), newsList: newsList)
                    }else {
                        Text("Carregando as notícias")
                        
                    }
                }.transition(.slide)
        }.onAppear(perform: fetch)
//            .tabItem {
//                Image(systemName: "1.circle")
//                Text("notícia")
//            }
//            .tag(0)
//            .transition(.slide)
//
//            Group {
//                if (newsList.articles.count > 0) {
//                    ClassifiedNewsView()
//                }else {
//                    Text("Ainda não temos notícias")
//                }
//            }.tabItem {
//                Image(systemName: "2.circle")
//                Text("classificação")
//            }.tag(1)
//        }.onAppear(perform: fetch)
    }
    
    init() {
        self.dateFormater.dateFormat = "EEEE, MMM d, yyyy"
    }
    
    func fetch() {
        self.newsList.loadLatestNews(context: self.managedObjectContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
