//
//  NewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 30/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct NewsView: View {
    @State var title:String = "Startup recebe investimento"
    @State var subtitle:String = "Recebeu R$ 30 milhões do fundo de invstimento Softbank."
    var date:String = "Quarta-feira 30 de outubro de 2019"
    var numNews = 1
    var newsList:NewsListViewModel?
    
    @State private var offset:CGSize = .zero
    @State var currentNewsIndex = 0

    var body: some View {
        let drag = DragGesture()
            .onChanged {
                self.offset = $0.translation
            }

            .onEnded {
                if ($0.translation.height < 50 && $0.translation.height > -50) {
                    if $0.translation.width < -50 {
                        self.nextNews()
                        self.offset = .init(width: 0, height: 0)
                    }else if $0.translation.width > 50 {
                        self.previousNews()
                        self.offset = .init(width: 0, height: 0)
                    }else {
                        self.offset = .zero
                    }
                }
        }

        return VStack (alignment: .leading) {

            VStack (alignment: .leading) {
                Text(date).font(.caption).foregroundColor(.gray)
                Text("Notícia").font(.title).bold()
            }.padding(50)

            VStack (alignment: .leading){
                Spacer()
                
                Text(title).font(.headline).bold()
                Text(subtitle).font(.body).padding([.top], 5).foregroundColor(.gray)
                Spacer()
            }
            .offset(x: offset.width, y: 0)
            .gesture(drag)
            .padding(50)
            
            Spacer()
            
            VStack (alignment: .trailing) {
                NavigationLink(destination: ClassificationView()) {
                    HStack {
                        Text("classificar").frame(minWidth: 0, maxWidth: .infinity, minHeight: 40).background(Color.red)
                        Image(systemName: "chevron.right").padding([Edge.Set.trailing], 10)
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight:40, alignment: .center).background(Color.pink).foregroundColor(.white)
                }
            }
        }
        .transition(.slide)
        .navigationBarTitle(Text("Notícia").font(.subheadline))
    }
    
    init(title:String, subtitle:String, numNews:Int, date:String, newsList:NewsListViewModel?) {
        self.title = title
        self.subtitle = subtitle
        self.numNews = numNews
        self.date = date
        self.newsList = newsList
    }
    
    func nextNews() {
        if currentNewsIndex == numNews - 1 {
            return
        }

        currentNewsIndex = currentNewsIndex + 1
        self.title = (newsList?.articles[currentNewsIndex].title)!
        self.subtitle = (newsList?.articles[currentNewsIndex].subtitle)!
        self.newsList?.news = newsList?.articles[currentNewsIndex]
    }
    
    func previousNews() {
        if currentNewsIndex == 0 {
            return
        }else {
            currentNewsIndex = currentNewsIndex - 1
            self.newsList?.news = newsList?.articles[currentNewsIndex]
        }
        self.title = (newsList?.articles[currentNewsIndex].title)!
        self.subtitle = (newsList?.articles[currentNewsIndex].subtitle)!
        self.newsList?.news = newsList?.articles[currentNewsIndex]
    }

}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(title: "Startup recebe investimento", subtitle: "Recebeu R$ 40 milhões do fundo do Itaú", numNews: 1, date: "Quarta-feira 30 de outubro de 2019", newsList: nil)
    }
}
