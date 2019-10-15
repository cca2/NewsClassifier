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
                Button(action: classifyAsCustomerSegment, label: {Text("#Segmento")})
                Button(action: classifyAsProblem, label: {Text("#Problema")})
            }

            SentenceView(sentenceViewModel: SentenceViewModel(sentenceModel: self.sentenceList.sentenceList[self.currentSentenceIndex]))
            .offset(x: offset.width, y: offset.height)
            .gesture(drag)
            .animation(.spring())
                        
            HStack {
                Button(action: classifyAsSolution, label: {Text("#Solução")})
                Button(action: classifyAsUVP, label: {Text("#UVP")})
            }.padding(.top)

        }.frame(width: 250, height: 400, alignment: .center)
//        .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.red, lineWidth: 1))
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
