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
    @State var containsProblem = false
    @State var containsFeature = false
    @State var conatainsTechnology = false
    @State var containsInvestment = false
    @State var containsPartnership = false
    
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
                VStack {
                    Button(action: restartClassification, label: {Text("Reclassificar")})
                    Spacer()
                    Button(action: saveClassification, label: {Text("Salvar")})
                }.frame(width: 100, height: 100, alignment: .center)
            }else {
                VStack(alignment: .trailing) {
                    Text("\(self.currentSentenceIndex + 1)/" + "\(self.numSentences)").frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        .font(.title)
                }.padding([.top, .trailing], 30)

                SentenceView(text: text)
                .offset(x: offset.width, y: 0)
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
                            if (containsProblem) {
                                Button(action: classifyAsProblem) {
                                    Text("#Desejo").font(self.classifyButtonFontSize).font(self.classifyButtonFontSize).bold().frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                    .background(Color.white).foregroundColor(.black)
                                    .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsProblem) {
                                    Text("#Desejo").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
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
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight:90, maxHeight: .infinity, alignment: .center).background(Color(UIColor.systemPink.withAlphaComponent(0.8))).foregroundColor(.white)
                        
                        HStack (spacing: 0) {
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
            guard let news = self.newsList.news else { return }
            guard let classifier = self.newsList.classifiedNews[(news.id.uuidString.lowercased())] else {return}
            self.text = classifier.sentenceList[0].text
            self.containsSegment = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.segment)
            self.containsProblem = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.problem)
            self.containsFeature = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.solution)
            self.conatainsTechnology = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.technology)
            self.containsInvestment = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.investment)
        }
    }
    
    func finishedClassification() {
        hasFinishedClassification = true
    }
    
    func restartClassification() {
        hasFinishedClassification = false
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
        self.containsProblem = classifier.sentenceList[currentSentenceIndex].classifications.contains(.problem)
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
        self.containsProblem = classifier.sentenceList[currentSentenceIndex].classifications.contains(.problem)
        self.containsFeature = classifier.sentenceList[currentSentenceIndex].classifications.contains(.solution)
        self.conatainsTechnology = classifier.sentenceList[currentSentenceIndex].classifications.contains(.technology)
        self.containsInvestment = classifier.sentenceList[currentSentenceIndex].classifications.contains(.investment)
    }
    
    func classifyAsCustomerSegment() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .segment)
        self.containsSegment = !self.containsSegment
    }
    
    func classifyAsProblem() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .problem)
        self.containsProblem = !self.containsProblem
    }
    
    func classifyAsSolution() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .solution)
        self.containsFeature = !self.containsFeature
    }
    
    func classifyAsTechnology() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .technology)
        self.conatainsTechnology = !self.conatainsTechnology
    }
    
    func classifyAsPartnership () {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .partnership)
        self.containsPartnership = !self.containsPartnership
    }
    
    func classifyAsInvestment() {
        self.newsList.classifySentenceAtIndexAs(at: currentSentenceIndex, newClassification: .investment)
        self.containsInvestment = !self.containsInvestment
    }
}

struct ClassificationView_Previews: PreviewProvider {
    static var previews: some View {
//        ClassificationView(news: NewsModel(news_id: "001", title: "Isto é um título", subtitle: "Agora vai mesmo porque é assim", link: "http://cin.ufpe.br", text: "Isto é um texto muito grande", links: [], links_text: []))
        ClassificationView()
    }
}
