//
//  ClassifiedNews.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 18/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ClassifiedNewsView: View {
    @EnvironmentObject var newsList:NewsListViewModel
    
    @State private var selectedSentence:SentenceViewModel?
    
    var body: some View {
        VStack {
            Text("Classificação").font(.headline)
            
            List {
                Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                    ForEach(newsList.newsSegmentSentences) { sentence in
                        Text("\(sentence.text)")
                        .contextMenu() {
                            if !sentence.containsSegment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .segment)
                                }) {
                                    Text("Segmento de Consumidores")
                                }
                            }
                            if !sentence.containsProblem {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .problem)
                                }) {
                                    Text("Dor & Desejo")
                                }
                            }
                            if !sentence.containsSolution {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .solution)
                                }) {
                                    Text("Solução & Features")
                                }
                            }
                            if !sentence.containsTechnology {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .technology)
                                }) {
                                    Text("Tecnologia")
                                }
                            }
                            if !sentence.containsInvestment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .investment)
                                }) {
                                    Text("Investimento")
                                }

                            }
                        }
                    }.onDelete(perform: removeSentenceFromSegmentClassification)
                }

                Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                    ForEach(newsList.newsProblemSentences) { sentence in
                        Text("\(sentence.text)")
                        .contextMenu() {
                            if !sentence.containsSegment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .segment)
                                }) {
                                    Text("Segmento de Consumidores")
                                }
                            }
                            if !sentence.containsProblem {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .problem)
                                }) {
                                    Text("Dor & Desejo")
                                }
                            }
                            if !sentence.containsSolution {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .solution)
                                }) {
                                    Text("Solução & Features")
                                }
                            }
                            if !sentence.containsTechnology {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .technology)
                                }) {
                                    Text("Tecnologia")
                                }
                            }
                            if !sentence.containsInvestment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .investment)
                                }) {
                                    Text("Investimento")
                                }

                            }
                        }
                    }.onDelete(perform: removeSentenceFromProblemClassification)
                }

                Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                    ForEach(newsList.newsSolutionSentences) { sentence in
                        Text("\(sentence.text)")
                        .contextMenu() {
                            if !sentence.containsSegment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .segment)
                                }) {
                                    Text("Segmento de Consumidores")
                                }
                            }
                            if !sentence.containsProblem {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .problem)
                                }) {
                                    Text("Dor & Desejo")
                                }
                            }
                            if !sentence.containsSolution {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .solution)
                                }) {
                                    Text("Solução & Features")
                                }
                            }
                            if !sentence.containsTechnology {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .technology)
                                }) {
                                    Text("Tecnologia")
                                }
                            }
                            if !sentence.containsInvestment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .investment)
                                }) {
                                    Text("Investimento")
                                }

                            }
                        }
                    }.onDelete(perform: removeSentenceFromSolutionClassification)
                }

                Section(header: Text(SentenceModel.Classification.technology.rawValue)) {
                    ForEach(newsList.newsTechnologySentences) { sentence in
                        Text("\(sentence.text)")
                        .contextMenu() {
                            if !sentence.containsSegment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .segment)
                                }) {
                                    Text("Segmento de Consumidores")
                                }
                            }
                            if !sentence.containsProblem {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .problem)
                                }) {
                                    Text("Dor & Desejo")
                                }
                            }
                            if !sentence.containsSolution {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .solution)
                                }) {
                                    Text("Solução & Features")
                                }
                            }
                            if !sentence.containsTechnology {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .technology)
                                }) {
                                    Text("Tecnologia")
                                }
                            }
                            if !sentence.containsInvestment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .investment)
                                }) {
                                    Text("Investimento")
                                }

                            }
                        }
                    }.onDelete(perform: removeSentenceFromTechnologyClassification)
                }

                Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                    ForEach(newsList.newsInvestmentSentences) { sentence in
                        Text("\(sentence.text)")
                        .contextMenu() {
                            if !sentence.containsSegment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .segment)
                                }) {
                                    Text("Segmento de Consumidores")
                                }
                            }
                            if !sentence.containsProblem {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .problem)
                                }) {
                                    Text("Dor & Desejo")
                                }
                            }
                            if !sentence.containsSolution {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .solution)
                                }) {
                                    Text("Solução & Features")
                                }
                            }
                            if !sentence.containsTechnology {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .technology)
                                }) {
                                    Text("Tecnologia")
                                }
                            }
                            if !sentence.containsInvestment {
                                Button(action: {
                                    self.selectedSentence = sentence
                                    self.classifySentence(as: .investment)
                                }) {
                                    Text("Investimento")
                                }

                            }
                        }
                    }.onDelete(perform: removeSentenceFromInvestmentClassification)
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete:\(offsets.filter{_ in true}[0])")
    }
    
    func classifySentence(as newClassification:SentenceModel.Classification) {
        guard let sentence = selectedSentence else { return }
        if newClassification == .segment && !sentence.containsSegment {
            self.newsList.classifySentence(sentence: sentence, as: .segment)
            self.newsList.newsSegmentSentences.append(sentence)
        }else if newClassification == .problem && !sentence.containsProblem {
            self.newsList.classifySentence(sentence: sentence, as: .problem)
            self.newsList.newsProblemSentences.append(sentence)
        }else if newClassification == .solution && !sentence.containsSolution {
            self.newsList.classifySentence(sentence: sentence, as: .solution)
            self.newsList.newsSolutionSentences.append(sentence)
        }else if newClassification == .technology && !sentence.containsTechnology {
            self.newsList.classifySentence(sentence: sentence, as: .technology)
            self.newsList.newsTechnologySentences.append(sentence)
        }else if newClassification == .investment && !sentence.containsInvestment {
            self.newsList.classifySentence(sentence: sentence, as: .investment)
            self.newsList.newsInvestmentSentences.append(sentence)
        }
    }
    
    func removeSentenceFromSegmentClassification(at offsets: IndexSet) {
        let index = offsets.filter{_ in true}[0]
        let sentence = self.newsList.newsSegmentSentences[index]
        self.newsList.removeSentenceClassification(sentence: sentence, classification: .segment)
        self.newsList.newsSegmentSentences.remove(atOffsets: offsets)
    }
    
    func removeSentenceFromProblemClassification(at offsets: IndexSet) {
        let index = offsets.filter{_ in true}[0]
        let sentence = self.newsList.newsProblemSentences[index]
        self.newsList.removeSentenceClassification(sentence: sentence, classification: .problem)
        self.newsList.newsProblemSentences.remove(atOffsets: offsets)
    }
    
    func removeSentenceFromSolutionClassification(at offsets: IndexSet) {
        let index = offsets.filter{_ in true}[0]
        let sentence = self.newsList.newsSolutionSentences[index]
        self.newsList.removeSentenceClassification(sentence: sentence, classification: .solution)
        self.newsList.newsSolutionSentences.remove(atOffsets: offsets)
    }
    
    func removeSentenceFromTechnologyClassification(at offsets: IndexSet) {
        let index = offsets.filter{_ in true}[0]
        let sentence = self.newsList.newsTechnologySentences[index]
        self.newsList.removeSentenceClassification(sentence: sentence, classification: .technology)
        self.newsList.newsTechnologySentences.remove(atOffsets: offsets)

    }
    
    func removeSentenceFromInvestmentClassification(at offsets: IndexSet) {
        let index = offsets.filter{_ in true}[0]
        let sentence = self.newsList.newsInvestmentSentences[index]
        self.newsList.removeSentenceClassification(sentence: sentence, classification: .investment)
        self.newsList.newsInvestmentSentences.remove(atOffsets: offsets)

    }
}

struct ClassifiedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedNewsView()
    }
}
