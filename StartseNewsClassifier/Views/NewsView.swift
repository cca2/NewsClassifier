//
//  NewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 30/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct NewsView: View {
    @State private var title:String
    @State private var subtitle:String
    @State private var offset:CGSize = .zero
    @State private var currentNewsIndex = 0
    @State private var numNews:Int
    @State private var numClassifiedNews:Int = 0
    @State private var isClassified:Bool = false

    var date:String = "Quarta-feira 30 de outubro de 2019"
//    var newsList:NewsListViewModel?
    @EnvironmentObject var newsList:NewsListViewModel
    
    var body: some View {
        return VStack (alignment: .leading) {
            VStack {
                ZStack {
                    VStack (alignment: .leading) {
                        Text(date).font(.body).foregroundColor(.gray)
                        Text("Notícia").font(.title).bold()
                    }.frame(minWidth: 0, maxWidth: .infinity,  minHeight: 40, maxHeight: 40, alignment: .leading)
                    .padding(40)
                }.frame(minWidth: 0, maxWidth: .infinity,  minHeight: 40, maxHeight: 40, alignment: .trailing)
                    .padding([.top], 40)
                
            }.padding([.bottom], 50)
            NavigationLink(destination: ClassificationView()) {
                VStack (alignment: .leading){
                    Text(title).font(.headline).foregroundColor(.white).bold().padding([.top, .leading, .trailing], 20)
                    Text(subtitle).font(.body).padding([.top], 5).padding([.bottom], 20).padding([.leading, .trailing], 20).foregroundColor(.white)
                }.onAppear() {
                    self.title = (self.newsList.news!.title)
                    self.subtitle = (self.newsList.news!.subtitle)
                    self.isClassified = (self.newsList.news!.isClassified)
                }
                .background(Color.pink)
                .cornerRadius(20)
                .offset(x: offset.width, y: 0)
                .padding([.leading, .trailing], 30)
            }
            
            Spacer()
        }
        .transition(.slide)
        .onAppear() {
            self.newsList.newsView = self
            if ((self.newsList.news!.isClassified)) {
                if self.newsList.currentNewsIndex < self.newsList.articles.count - 1 {
                    self.newsList.currentNewsIndex = self.newsList.currentNewsIndex + 1
                    self.newsList.news = self.newsList.articles[self.newsList.currentNewsIndex]
                }
            }
            self.numClassifiedNews = self.newsList.numMarkAsClassifiedNews() ?? 0
        }
    }
    
    init(title:String, subtitle:String, numNews:Int) {
        self._title = State(initialValue: title)
        self._subtitle = State(initialValue: subtitle)
        self._numNews = State(initialValue: numNews)
        self._numClassifiedNews = State(initialValue: numNews)
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEEE, MMM d, yyyy"
        
        self.date = dateFormater.string(from: Date())
        
//        self.newsList = newsList
//        self.newsList.newsView = self
    }
    
    func nextNews() {
        if currentNewsIndex == numNews - 1 {
            return
        }

        currentNewsIndex = currentNewsIndex + 1
        self.title = (newsList.articles[currentNewsIndex].title)
        self.subtitle = (newsList.articles[currentNewsIndex].subtitle)
        self.newsList.news = newsList.articles[currentNewsIndex]
        self.isClassified = (self.newsList.news!.isClassified)
    }
    
    func previousNews() {
        if currentNewsIndex == 0 {
            return
        }else {
            currentNewsIndex = currentNewsIndex - 1
            self.newsList.news = newsList.articles[currentNewsIndex]
        }
        self.title = (newsList.articles[currentNewsIndex].title)
        self.subtitle = (newsList.articles[currentNewsIndex].subtitle)
        self.newsList.news = newsList.articles[currentNewsIndex]
        self.isClassified = (self.newsList.news!.isClassified)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(title: "Startup recebe investimento", subtitle: "Recebeu R$ 40 milhões do fundo do Itaú", numNews: 1)
    }
}
