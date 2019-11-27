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
    @State var numNewsToClassify:Int = 0
    @State var title:String = ""
    @State var subtitle:String = ""
    @State var numNews:Int = 0
    
    
    //Acessando o contexto para CoreData
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        TabView() {
            NavigationView {
                HStack {
                    if numNewsToClassify == 0 {
                        FetchNewsView()
                    }else {
                        NewsView(title: title, subtitle: subtitle, numNews: numNews)
                    }
                }.onAppear() {
                    self.newsList.context = self.managedObjectContext
                    self.numNewsToClassify = self.newsList.articles.count
                }
                .transition(.slide)
            }.tabItem({
                Text("Classificação")
            })
            
            ConsolidationView(consolidationViewModel: ConsolidationViewModel(context: managedObjectContext))
            .tabItem({
                Text("Consolidação")
            })
        }
    }
    
//    init() {
//        self.dateFormater.dateFormat = "EEEE, MMM d, yyyy"
//    }
    
    func fetch() {
        self.newsList.loadLatestNews(context: self.managedObjectContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
