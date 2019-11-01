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

//                Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
//                    ForEach(newsList.newsSolutionSentences) { sentence in
//                        Text("\(sentence.text)")
//                        .contextMenu() {
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .solution, to: .segment)
//                            }) {
//                                Text("Segmento de Consumidores")
//                            }
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .solution, to: .problem)
//                            }) {
//                                Text("Dor & Desejo")
//                            }
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .solution, to: .technology)
//                            }) {
//                                Text("Tecnologia")
//                            }
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .solution, to: .investment)
//                            }) {
//                                Text("Investimento")
//                            }
//                        }
//                    }
//                }
//
//                Section(header: Text(SentenceModel.Classification.technology.rawValue)) {
//                    ForEach(newsList.newsTechnologySentences) { sentence in
//                        Text("\(sentence.text)")
//                        .contextMenu() {
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .technology, to: .segment)
//                            }) {
//                                Text("Segmento de Consumidores")
//                            }
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .technology, to: .problem)
//                            }) {
//                                Text("Dor & Desejo")
//                            }
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .technology, to: .solution)
//                            }) {
//                                Text("Solução & Features")
//                            }
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .technology, to: .investment)
//                            }) {
//                                Text("Investimento")
//                            }
//                        }
//                    }
//                }
//
//                Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
//                    ForEach(newsList.newsInvestmentSentences) { sentence in
//                        Text("\(sentence.text)")
//                        .contextMenu() {
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .investment, to: .segment)
//                            }) {
//                                Text("Segmento de Consumidores")
//                            }
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .investment, to: .problem)
//                            }) {
//                                Text("Dor & Desejo")
//                            }
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .investment, to: .solution)
//                            }) {
//                                Text("Solução & Features")
//                            }
//                            Button(action: {
//                                self.selectedSentence = sentence
//                                self.reclassifySentence(from: .investment, to: .technology)
//                            }) {
//                                Text("Tecnologia")
//                            }
//                        }
//                    }
//                }
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
        }
    }
    
    func removeSentenceFromSegmentClassification(at offsets: IndexSet) {
        let index = offsets.filter{_ in true}[0]
        let sentence = self.newsList.newsSegmentSentences[index]
        self.newsList.removeSentenceClassification(sentence: sentence, classification: .segment)
        self.newsList.newsSegmentSentences.remove(atOffsets: offsets)
    }
    
    func removeSentenceFromProblemClassification(at offsets: IndexSet) {
        self.newsList.newsProblemSentences.remove(atOffsets: offsets)
    }
    
    func removeSentenceFromSolutionClassification(at offsets: IndexSet) {
        
    }
    
    func removeSentenceFromTechnologyClassification(at offsets: IndexSet) {
        
    }
    
    func removeSentenceFromInvestmentClassification(at offsets: IndexSet) {
        
    }
}

struct ClassifiedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedNewsView()
    }
}
