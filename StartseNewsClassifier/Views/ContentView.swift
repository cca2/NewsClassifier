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
    
    
    
    private let dateFormater = DateFormatter()
    
    //Acessando o contexto para CoreData
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        return
            NavigationView {
                HStack {
                    if !(self.newsList.articles.count == self.newsList.numMarkAsClassifiedNews()) {
                        NewsView(title: newsList.articles.first!.title, subtitle: newsList.articles.first!.subtitle, numNews: newsList.articles.count, date: dateFormater.string(from: Date()), newsList: newsList)
                    }else {
                        FetchNewsView()
                    }
                }.transition(.slide)
        }
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
