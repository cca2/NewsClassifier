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
    @State var hasFinishedClassification = false
    
    @State var containsSegment = false
    @State var containsProblem = false
    @State var containsFeature = false
    @State var containsUVP = false
    @State var containsInvestment = false
    @State var containsPartnership = false
    
    private let news:NewsModel

    private let sentencesOffset:Int = 0
    
//    private let classifier:ClassifiedNewsViewModel
    private let classificationHeight:CGFloat = 60
    private let classificationWidth:CGFloat = 110
    private let classificationFont:Font = .footnote
    
    private let categories:[SentenceModel.Classification]
    private let classifyButtonFontSize = Font.system(size:12)
    
    init(news:NewsModel) {
//        self.classifier = ClassifiedNewsViewModel(news: news)
        
        self.news = news
        var categories:[SentenceModel.Classification] = []
        for category in SentenceModel.Classification.allCases {
            categories.append(category)
            print (category)
        }
        self.categories = categories
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
                SentenceView(sentenceViewModel: SentenceViewModel(sentenceModel: self.newsList.classifiedNews[news.news_id]!.sentenceList[self.currentSentenceIndex + self.sentencesOffset]), classifier: self.newsList.classifiedNews[news.news_id]!)
                .offset(x: offset.width, y: 0)
                .gesture(drag)
                .animation(.spring()).padding()

                Group {                    
                    VStack(spacing:5) {
                        HStack (spacing: 5) {
                            if (containsSegment) {
                                Button(action: classifyAsCustomerSegment) {
                                    Text("#Segmento").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.pink).foregroundColor(.white)
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
                                    Text("#Problema").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.pink).foregroundColor(.white)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsProblem) {
                                    Text("#Problema").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
                            if (containsFeature) {
                                Button(action: classifyAsSolution) {
                                    Text("#Features").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.pink).foregroundColor(.white)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsSolution) {
                                    Text("#Features").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
                        }
                        HStack (spacing: 5) {
                            if (containsUVP) {
                                Button(action: classifyAsUVP) {
                                    Text("#UVP").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.pink).foregroundColor(.white)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsUVP) {
                                    Text("#UVP").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
                            if (containsInvestment) {
                                Button(action: classifyAsInvestment) {
                                    Text("#Investimento").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.pink).foregroundColor(.white)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }else {
                                Button(action: classifyAsInvestment) {
                                    Text("#Investimento").font(self.classifyButtonFontSize).frame(width: classificationWidth, height:self.classificationHeight, alignment: .center).fixedSize(horizontal: false, vertical: false)
                                        .background(Color.white).foregroundColor(.pink)
                                        .overlay(Rectangle().stroke(Color.pink, lineWidth: 1))
                                }
                            }
                        }
                    }
                }
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .padding(.bottom)
        .offset(CGSize(width: 0, height: -20))
        .onAppear() {
            guard let classifier = self.newsList.classifiedNews[self.news.news_id] else {return}
            self.containsSegment = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.segment)
            self.containsProblem = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.problem)
            self.containsFeature = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.solution)
            self.containsUVP = classifier.sentenceList[self.currentSentenceIndex].classifications.contains(.uvp)
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
        let classifier = self.newsList.classifiedNews[news.news_id]
        classifier?.saveClassifiedSentences()
    }

    func nextSentence() {
        guard let classifier = self.newsList.classifiedNews[news.news_id] else {return}
        let numSentencesInNews = classifier.sentenceList.count
        
        if (currentSentenceIndex == (numSentencesInNews - 1)) {
            finishedClassification()
            return
        }
        currentSentenceIndex = currentSentenceIndex + 1
        
        self.containsSegment = classifier.sentenceList[currentSentenceIndex].classifications.contains(.segment)
        self.containsProblem = classifier.sentenceList[currentSentenceIndex].classifications.contains(.problem)
        self.containsFeature = classifier.sentenceList[currentSentenceIndex].classifications.contains(.solution)
        self.containsUVP = classifier.sentenceList[currentSentenceIndex].classifications.contains(.uvp)
        self.containsInvestment = classifier.sentenceList[currentSentenceIndex].classifications.contains(.investment)
    }
    
    func previousSentence() {
        guard let classifier = self.newsList.classifiedNews[news.news_id] else {return}
        if currentSentenceIndex == 0 {
            return
        }
        currentSentenceIndex = currentSentenceIndex - 1
        self.containsSegment = classifier.sentenceList[currentSentenceIndex].classifications.contains(.segment)
        self.containsProblem = classifier.sentenceList[currentSentenceIndex].classifications.contains(.problem)
        self.containsFeature = classifier.sentenceList[currentSentenceIndex].classifications.contains(.solution)
        self.containsUVP = classifier.sentenceList[currentSentenceIndex].classifications.contains(.uvp)
        self.containsInvestment = classifier.sentenceList[currentSentenceIndex].classifications.contains(.investment)
    }
    
    func classifyAsCustomerSegment() {
        guard let classifier = self.newsList.classifiedNews[news.news_id] else {return}

        classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .segment)
        self.containsSegment = !self.containsSegment
    }
    
    func classifyAsProblem() {
        guard let classifier = self.newsList.classifiedNews[news.news_id] else {return}

        classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .problem)
        
        self.containsProblem = !self.containsProblem
    }
    
    func classifyAsSolution() {
        guard let classifier = self.newsList.classifiedNews[news.news_id] else {return}

        classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .solution)
        self.containsFeature = !self.containsFeature
    }
    
    func classifyAsUVP() {
        guard let classifier = self.newsList.classifiedNews[news.news_id] else {return}

        classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .uvp)
        self.containsUVP = !self.containsUVP
    }
    
    func classifyAsPartnership () {
        guard let classifier = self.newsList.classifiedNews[news.news_id] else {return}

        classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .partnership)
        self.containsPartnership = !self.containsPartnership
    }
    
    func classifyAsInvestment() {
        guard let classifier = self.newsList.classifiedNews[news.news_id] else {return}

        classifier.classifySentenceAs(sentence: classifier.sentenceList[currentSentenceIndex + sentencesOffset], newClassification: .investment)
        self.containsInvestment = !self.containsInvestment
    }
}

struct ClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationView(news: NewsModel(news_id: "001", title: "Isto é um título", subtitle: "Agora vai mesmo porque é assim", link: "http://cin.ufpe.br", text: "Isto é um texto muito grande", links: [], links_text: []))
    }
}
