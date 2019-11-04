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
            NavigationView {
                HStack {
                    if !(self.newsList.articles.count == 0) {
                        NewsView(title: newsList.articles[currentNewsIndex].title, subtitle: newsList.articles[currentNewsIndex].subtitle, numNews: newsList.articles.count, date: dateFormater.string(from: Date()), newsList: newsList)
                    }else {
                        FetchNewsView()
                        
                    }
                }.transition(.slide)
        }
//        .onAppear(perform: fetch)
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
