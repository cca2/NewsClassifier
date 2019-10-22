//
//  ClassificationView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI
import CoreML
import NaturalLanguage

struct ClassificationView: View {
    @State private var offset: CGSize = .zero
    @State var currentSentenceIndex:Int = 0
    private let sentencesOffset:Int
    private let actOnClassification:ActOnClassification
    
    private let sentenceList:SentenceListViewModel
    private let classificationHeight:CGFloat = 30
    private let classificationFont:Font = .footnote
    
    init(actOnClassification: ActOnClassification, sentences: SentenceListViewModel) {
        self.actOnClassification = actOnClassification
        self.sentenceList = sentences
        let index = sentences.currentNewsIndex
        var numSentences = 0
        for i in 0..<index {
            numSentences = numSentences + sentences.articles.articles[i].sentences.count
        }
        self.sentencesOffset = numSentences
    }
    
    var body: some View {
        let drag = DragGesture()
            .onChanged {
                self.offset = $0.translation
            }
            
            .onEnded {
                if ($0.translation.height < 50 && $0.translation.height > -50) {
                    if $0.translation.width < -50 {
                        self.nextSentence()
                        self.offset = .init(width: 0, height: 0)
                    }else if $0.translation.width > 50 {
                        self.previousSentence()
                        self.offset = .init(width: 0, height: 0)
                    }else {
                        self.offset = .zero
                    }
                }else if ($0.translation.height > 50 || $0.translation.height < -50) || ($0.translation.width < -50 || $0.translation.height > 50) {
                    self.classifySentence(offset: $0.translation)
                    self.offset = .init(width: 0, height: 0)
                }else {
                    self.offset = .zero
                }                
        }
        
        return VStack {
            HStack {
                ZStack {
                    Group {
                        Text("#Segmento").bold().font(self.classificationFont)
                    }
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.red).foregroundColor(.white)
                    .overlay(Rectangle().stroke(Color.red, lineWidth: 1))
                
                VStack {
                    Text("#Problema").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.green).foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.green, lineWidth: 1))
                
                VStack {
                    Text("#Features").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.orange).foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.orange, lineWidth: 1))
            }

            SentenceView(sentenceViewModel: SentenceViewModel(sentenceModel: self.sentenceList.sentenceList[self.currentSentenceIndex + self.sentencesOffset]))
            .offset(x: offset.width, y: offset.height)
            .gesture(drag)
                .animation(.spring()).padding()

            HStack {
                VStack {
                    Text("#UVP").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.pink).foregroundColor(.white)
                
                VStack {
                    Text("#Investimento").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.purple).foregroundColor(.white)
                
                VStack {
                    Text("#Parceria").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.black).foregroundColor(.white)
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .padding(.bottom)
        .offset(CGSize(width: 0, height: -20))
    }
    
    func classifySentence(offset:CGSize) {
        if offset.height < -50  && offset.width < -50 {
            classifyAsCustomerSegment()
        }else if offset.height > 50  && offset.width < -50 {
            classifyAsUVP()
        }else if offset.height < -50  && offset.width > 50 {
            classifyAsSolution()
        }else if offset.height > 50  && offset.width > 50 {
            classifyAsPartnership()
        }else if offset.height > 50 {
            classifyAsInvestment()
        }else {
            classifyAsProblem()
        }
        if (currentSentenceIndex == sentenceList.sentenceList.count - 1)  {
            actOnClassification.finishedClassification()
            return
        }
        currentSentenceIndex = currentSentenceIndex + 1
    }
    
    func nextSentence() {
        let numSentencesInNews = sentenceList.articles.articles[sentenceList.currentNewsIndex].sentences.count
        if (currentSentenceIndex == (numSentencesInNews - 1)) {
            actOnClassification.finishedClassification()
            return
        }
        currentSentenceIndex = currentSentenceIndex + 1
    }
    
    func previousSentence() {
        if currentSentenceIndex == 0 {
            return
        }
        currentSentenceIndex = currentSentenceIndex - 1
    }
    
    func classifyAsCustomerSegment() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .segment)
    }
    
    func classifyAsProblem() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .problem)
    }
    
    func classifyAsSolution() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .solution)
    }
    
    func classifyAsUVP() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .uvp)
    }
    
    func classifyAsPartnership () {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .partnership)
    }
    
    func classifyAsInvestment() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .investment)
    }
}

struct ClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationView(actOnClassification: ContentView(sentences: SentenceListViewModel()), sentences: SentenceListViewModel())
    }
}
