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
    private let sentencesOffset:Int = 0
    private let actOnClassification:ActOnClassification
    
    private let classifier:ClassifiedNewsViewModel
    private let classificationHeight:CGFloat = 30
    private let classificationFont:Font = .footnote
    
    init(actOnClassification: ActOnClassification, classifier: ClassifiedNewsViewModel) {
        self.actOnClassification = actOnClassification
        self.classifier = classifier
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
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.white).foregroundColor(.red)
                    .overlay(Rectangle().stroke(Color.red, lineWidth: 1))
                
                VStack {
                    Text("#Problema").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.white).foregroundColor(.green)
                .overlay(Rectangle().stroke(Color.green, lineWidth: 1))
                
                VStack {
                    Text("#Features").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.white).foregroundColor(.orange)
                .overlay(Rectangle().stroke(Color.orange, lineWidth: 1))
            }

            SentenceView(sentenceViewModel: SentenceViewModel(sentenceModel: self.classifier.sentenceList[self.currentSentenceIndex + self.sentencesOffset]), classifier: self.classifier)
            .offset(x: offset.width, y: offset.height)
            .gesture(drag)
            .animation(.spring()).padding()

            HStack {
                VStack {
                    Text("#UVP").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.white).foregroundColor(.pink)
                .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                
                VStack {
                    Text("#Investimento").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.white).foregroundColor(.purple)
                .overlay(Rectangle().stroke(Color.purple, lineWidth: 1))
                
                VStack {
                    Text("#Parceria").bold().font(self.classificationFont)
                }.frame(width: 120, height:classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false).background(Color.white).foregroundColor(.black)
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
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
        if (currentSentenceIndex == classifier.sentenceList.count - 1)  {
            actOnClassification.finishedClassification()
            return
        }
        currentSentenceIndex = currentSentenceIndex + 1
    }
    
    func nextSentence() {
        let numSentencesInNews = self.classifier.sentenceList.count
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
        self.classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .segment)
    }
    
    func classifyAsProblem() {
        self.classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .problem)
    }
    
    func classifyAsSolution() {
        self.classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .solution)
    }
    
    func classifyAsUVP() {
        self.classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .uvp)
    }
    
    func classifyAsPartnership () {
        self.classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .partnership)
    }
    
    func classifyAsInvestment() {
        self.classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .investment)
    }
}

//struct ClassificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClassificationView(actOnClassification: ClassifyOrFinishView(sentences: ClassifiedNewsViewModel()), sentences: ClassifiedNewsViewModel())
//    }
//}
