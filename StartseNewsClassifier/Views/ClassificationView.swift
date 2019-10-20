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
    @State var currentSentenceIndex = 0

    private let actOnClassification:ActOnClassification
    
    private let sentenceList:SentenceListViewModel
    private let classificationHeight:CGFloat = 30
    private let classificationFont:Font = .footnote
    
    init(actOnClassification: ActOnClassification, sentences: SentenceListViewModel) {
        self.actOnClassification = actOnClassification
        self.sentenceList = sentences
    }
    
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
            }.padding(.top)

            SentenceView(sentenceViewModel: SentenceViewModel(sentenceModel: self.sentenceList.sentenceList[self.currentSentenceIndex]))
            .offset(x: offset.width, y: offset.height)
            .gesture(drag)
                .animation(.spring()).padding()
                        
            HStack {
                VStack {
                    Text("#UVP").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.pink).foregroundColor(.white)
                    .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                
                VStack {
                    Text("#Investimento").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.purple).foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.purple, lineWidth: 1))
                
                VStack {
                    Text("#Parceria").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.black).foregroundColor(.white)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
            }.padding(.bottom)
        }.frame(width: 400, height: 400, alignment: .center)
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
    
    func nextNews() {
        if (currentSentenceIndex == sentenceList.sentenceList.count - 1) {
            actOnClassification.finishedClassification()
            return
        }
        currentSentenceIndex = currentSentenceIndex + 1
    }
    
    func previousNews() {
        if currentSentenceIndex == 0 {
            return
        }
        currentSentenceIndex = currentSentenceIndex - 1
        print (self.sentenceList.sentenceList[currentSentenceIndex].classification)
    }
    
    func classifyAsCustomerSegment() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex], newClassification: .segment)
    }
    
    func classifyAsProblem() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex], newClassification: .problem)
    }
    
    func classifyAsSolution() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex], newClassification: .solution)
    }
    
    func classifyAsUVP() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex], newClassification: .uvp)
    }
    
    func classifyAsPartnership () {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex], newClassification: .partnership)
    }
    
    func classifyAsInvestment() {
        self.sentenceList.classifySentenceAs(sentence: sentenceList.sentenceList[currentSentenceIndex], newClassification: .investment)
    }
}

struct ClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationView(actOnClassification: ContentView(sentences: SentenceListViewModel()), sentences: SentenceListViewModel())
    }
}
