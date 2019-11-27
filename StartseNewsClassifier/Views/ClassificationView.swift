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
    @EnvironmentObject var newsList:NewsListViewModel
    
    @State private var offset: CGSize = .zero
    @State var currentSentenceIndex:Int = 0
    @State var numSentences:Int = 15
    @State var hasFinishedClassification = false
    
    @State var containsSegment = false
    @State var containsJob = false
    @State var containsFeature = false
    @State var conatainsTechnology = false
    @State var containsInvestment = false
    @State var containsOutcome = false
    
    @State var text = "Está é a sentença que está sendo avaliada."
    
    private let sentencesOffset:Int = 0
    private let classificationHeight:CGFloat = 85
    private let classificationWidth:CGFloat = 85
    private let classificationFont:Font = .footnote
    private let classifyButtonFontSize = Font.system(size:11)
        
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
                }
            }
        
        return VStack {
            if (hasFinishedClassification) {
                ClassifiedNewsView().animation(.easeIn)
            }else {
                ZStack {
                    VStack {
                        Circle()
                        .size(width: 40, height: 40)
                        .fill(Color.pink)
                    }.frame(width: 40, height: 40)

                    VStack {
                        Circle()
                        .size(width: 50, height: 50)
                        .fill(Color.pink)
                            
                    }.frame(width: 50, height: 50)
                        .offset(x: -25, y: -25)

                    VStack {
                        Text("\(self.numSentences)")
                        .font(.body)
                        .bold()
                        .foregroundColor(.white)
                    }.frame(width: 40, height: 40)
                    VStack {
                        Text("\(self.currentSentenceIndex + 1)")
                        .font(.body)
                        .bold()
                        .foregroundColor(.white)
                    }.frame(width: 50, height: 50)
                    .offset(x: -25, y: -25)
                }.frame(minWidth: 0, maxWidth: .infinity,  minHeight: 40, maxHeight: 40, alignment: .trailing)
                    .padding([.top], 40)
                    .offset(x: 0, y: -30)
                
                Spacer()
                
                SentenceView(text: text)
                .offset(x: offset.width, y: -50)
                .gesture(drag)
                .animation(.spring()).padding()

                Group {                    
                    VStack(spacing:0) {
                        HStack (spacing: 0) {
                            if (containsSegment) {
                                Button(action: classifyAsCustomerSegment) {
                                    Text("#Segmento").font(self.classifyButtonFontSize).font(self.classifyButtonFontSize).bold().frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                    .background(Color.white).foregroundColor(.black)
                                    .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsCustomerSegment) {
                                    Text("#Segmento").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
                            if (containsJob) {
                                Button(action: classifyAsProblem) {
                                    Text("#Job").font(self.classifyButtonFontSize).font(self.classifyButtonFontSize).bold().frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                    .background(Color.white).foregroundColor(.black)
                                    .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsProblem) {
                                    Text("#Job").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
                            if (containsOutcome) {
                                Button(action: classifyAsOutcome) {
                                    Text("#Outcome").font(self.classifyButtonFontSize).font(self.classifyButtonFontSize).bold().frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                    .background(Color.white).foregroundColor(.black)
                                    .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsOutcome) {
                                    Text("#Outcome").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight:90, maxHeight: .infinity, alignment: .center).background(Color(UIColor.systemPink.withAlphaComponent(0.8))).foregroundColor(.white)
                        
                        HStack (spacing: 0) {
                            if (containsFeature) {
                                Button(action: classifyAsSolution) {
                                    Text("#Features").font(self.classifyButtonFontSize).font(self.classifyButtonFontSize).bold().frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                    .background(Color.white).foregroundColor(.black)
                                    .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsSolution) {
                                    Text("#Features").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }

                            if (conatainsTechnology) {
                                Button(action: classifyAsTechnology) {
                                    Text("#Tecnologia").font(self.classifyButtonFontSize).bold().frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.black)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsTechnology) {
                                    Text("#Tecnologia").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
                            if (containsInvestment) {
                                Button(action: classifyAsInvestment) {
                                    Text("#Investimento").font(self.classifyButtonFontSize).font(self.classifyButtonFontSize).bold().frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                    .background(Color.white).foregroundColor(.black)
                                    .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsInvestment) {
                                    Text("#Investimento").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight:90, maxHeight: .infinity, alignment: .center).background(Color(UIColor.systemPink.withAlphaComponent(0.8))).foregroundColor(.white)
                    }
                    Spacer()
                }.offset(CGSize(width: 0, height: -55))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .padding(.bottom)
        .onAppear() {
            //Comentado apenas para o Preview
            guard let news = self.newsList.news else { return }
            guard let classifier = self.newsList.classifiedNews[(news.id.uuidString.lowercased())] else {return}
            self.numSentences = classifier.sentenceList.count
            self.text = classifier.sentenceList[0].text
            self.containsSegment = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.segment)
            self.containsJob = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.job)
            self.containsFeature = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.solution)
            self.conatainsTechnology = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.technology)
            self.containsInvestment = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.investment)
            self.containsOutcome = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.outcome)
        }
    }
    
    func finishedClassification() {
        hasFinishedClassification = true
    }

    func saveClassification() {
        let classifier = self.newsList.classifiedNews[(self.newsList.news?.id.uuidString.lowercased())!]
        classifier?.saveClassifiedSentences()
    }

    func nextSentence() {
        guard let classifier = self.newsList.classifiedNews[(self.newsList.news?.id.uuidString.lowercased())!] else {return}
        let numSentencesInNews = classifier.sentenceList.count
        
        if (currentSentenceIndex == (numSentencesInNews - 1)) {
            finishedClassification()
            return
        }

        currentSentenceIndex = currentSentenceIndex + 1
        self.text = classifier.sentenceList[currentSentenceIndex].text
        self.containsSegment = classifier.sentenceList[currentSentenceIndex].classifications.contains(.segment)
        self.containsJob = classifier.sentenceList[currentSentenceIndex].classifications.contains(.job)
        self.containsFeature = classifier.sentenceList[currentSentenceIndex].classifications.contains(.solution)
        self.conatainsTechnology = classifier.sentenceList[currentSentenceIndex].classifications.contains(.technology)
        self.containsInvestment = classifier.sentenceList[currentSentenceIndex].classifications.contains(.investment)
    }
    
    func previousSentence() {
        guard let classifier = self.newsList.classifiedNews[(self.newsList.news?.id.uuidString.lowercased())!] else {return}
        if currentSentenceIndex == 0 {
            return
        }
        currentSentenceIndex = currentSentenceIndex - 1
        self.text = classifier.sentenceList[currentSentenceIndex].text
        self.containsSegment = classifier.sentenceList[currentSentenceIndex].classifications.contains(.segment)
        self.containsJob = classifier.sentenceList[currentSentenceIndex].classifications.contains(.job)
        self.containsFeature = classifier.sentenceList[currentSentenceIndex].classifications.contains(.solution)
        self.conatainsTechnology = classifier.sentenceList[currentSentenceIndex].classifications.contains(.technology)
        self.containsInvestment = classifier.sentenceList[currentSentenceIndex].classifications.contains(.investment)
        self.containsOutcome = classifier.sentenceList[currentSentenceIndex].classifications.contains(.outcome)
    }
    
    func classifyAsCustomerSegment() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .segment)
        self.containsSegment.toggle()
    }
    
    func classifyAsProblem() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .job)
        self.containsJob.toggle()
    }
    
    func classifyAsSolution() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .solution)
        self.containsFeature.toggle()
    }
    
    func classifyAsTechnology() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .technology)
        self.conatainsTechnology.toggle()
    }
    
    func classifyAsOutcome () {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .outcome)
        self.containsOutcome.toggle()
    }
    
    func classifyAsInvestment() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .investment)
        self.containsInvestment.toggle()
    }
}

struct ClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationView()
    }
}
