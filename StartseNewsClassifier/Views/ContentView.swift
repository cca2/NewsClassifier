//
//  ContentView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI
import CoreML
import NaturalLanguage

struct ContentView: View {
    @State private var offset: CGSize = .zero
    @State var currentSentenceIndex = 0

    private let sentenceList = SentenceListViewModel()

    var body: some View {
        let drag = DragGesture()
            .onChanged { self.offset = $0.translation }
            .onEnded {
                if $0.translation.width < -50 {
                    self.offset = .init(width: 0, height: 0)
                    self.nextNews()
                } else if $0.translation.width > 50 {
                    self.offset = .init(width: 0, height: 0)
                    self.previousNews()
                } else if $0.translation.height < 0 {
                    self.offset = .init(width: 0, height: 0)
                    self.previousNews()
                } else if $0.translation.height > 50 {
                    self.offset = .init(width: 0, height: 0)
                    self.nextNews()
                } else {
                    self.offset = .zero
                }
        }
        
        return VStack {
            HStack {
                VStack {
                    Text("#Seg")
                    Text("mento")
                }.frame(width: 120, height:100, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.red).foregroundColor(.white)
                    .overlay(Rectangle().stroke(Color.red, lineWidth: 1))
                
                VStack {
                    Text("#Problema")
                }.frame(width: 120, height:100, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.green).foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.green, lineWidth: 1))
                
                VStack {
                    Text("#Solução")
                }.frame(width: 120, height:100, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.orange).foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.orange, lineWidth: 1))
            }.padding(.top)

            SentenceView(sentenceViewModel: SentenceViewModel(sentenceModel: self.sentenceList.sentenceList[self.currentSentenceIndex]))
            .offset(x: offset.width, y: offset.height)
            .gesture(drag)
                .animation(.spring()).padding()
                        
            HStack {
                VStack {
                    Text("#UVP")
                }.frame(width: 120, height:100, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.gray).foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
                
                VStack {
                    Text("#In")
                    Text("vestimento")
                }.frame(width: 120, height:100, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.purple).foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.purple, lineWidth: 1))
                
                VStack {
                    Text("#Parceria").padding()
                }.frame(width: 120, height:100, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.black).foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
            }.padding(.bottom)
            
            HStack {
                Text("\(currentSentenceIndex)/\(sentenceList.sentenceList.count)")
            }.padding(.bottom)
        }.frame(width: 400, height: 400, alignment: .center)
    }
    
    func nextNews() {
        currentSentenceIndex = currentSentenceIndex + 1
    }
    
    func previousNews() {
        if currentSentenceIndex == 0 {
            return
        }
        currentSentenceIndex = currentSentenceIndex - 1
    }
    
    func classifyAsCustomerSegment() {}
    func classifyAsProblem() {}
    func classifyAsSolution() {}
    func classifyAsUVP() {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
