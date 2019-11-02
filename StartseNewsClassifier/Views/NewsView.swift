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

    var date:String = "Quarta-feira 30 de outubro de 2019"
    var newsList:NewsListViewModel?
    
    //Comentado apenas para ver o preview
//    @Environment(\.managedObjectContext) var managedObjectContext
    
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
            VStack {
                ZStack {
                    ZStack {
                            Circle()
                            .size(width: 40, height: 40)
                            .fill(Color.pink)
                            .frame(minWidth: 0, maxWidth: .infinity,  minHeight: 40, maxHeight: 40, alignment: .trailing)
                            .background(Color.green)

                        Text("\(numNews)")
                        .font(.body)
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: .infinity,  minHeight: 40, maxHeight: 40, alignment: .trailing)
                        .offset(x: -40, y: 0)
                    }.frame(minWidth: 0, maxWidth: .infinity,  minHeight: 40, maxHeight: 40, alignment: .trailing)
                    .background(Color.yellow)

                    VStack (alignment: .leading) {
                        Text(date).font(.body).foregroundColor(.gray)
                        Text("Notícia").font(.title).bold()
                    }.frame(minWidth: 0, maxWidth: .infinity,  minHeight: 40, maxHeight: 40, alignment: .leading)
                    .padding(40)
                }.frame(minWidth: 0, maxWidth: .infinity,  minHeight: 40, maxHeight: 40, alignment: .trailing)
                    .padding([.top], 40)
                
            }.padding([.bottom], 50)
                        
            VStack (alignment: .leading){
                Text(title).font(.headline).foregroundColor(.white).bold().padding([.top, .leading, .trailing], 20)
                Text(subtitle).font(.body).padding([.top], 5).padding([.bottom], 20).padding([.leading, .trailing], 20).foregroundColor(.white)
                VStack {
                    Button(action: markAsClassified) {
                        //Comentado apenas para ver o preview
//                        if (self.newsList?.news!.isClassified)! {
                            Image(systemName: "checkmark.circle.fill").foregroundColor(.white)
//                        }else {
//                            Image(systemName: "checkmark.circle").foregroundColor(.white)
//                        }
                    }
                }.padding([.trailing, .bottom])
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            }.background(Color.pink)
            .cornerRadius(20)
            .offset(x: offset.width, y: 0)
            .gesture(drag)
            .padding([.leading, .trailing], 30)
            
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
    }
    
    init(title:String, subtitle:String, numNews:Int, date:String, newsList:NewsListViewModel?) {
        self._title = State(initialValue: title)
        self._subtitle = State(initialValue: subtitle)
        self._numNews = State(initialValue: numNews)
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

    func markAsClassified() {
        //Comentado apenas para ver o preview
//        self.newsList?.updateNewsClassificationStatus(isClassified: true, context: self.managedObjectContext)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(title: "Startup recebe investimento", subtitle: "Recebeu R$ 40 milhões do fundo do Itaú", numNews: 1, date: "Quarta-feira 30 de outubro de 2019", newsList: nil)
    }
}
