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
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .segment, to: .problem)
                            }) {
                                Text("Dor & Desejo")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .segment, to: .solution)
                            }) {
                                Text("Solução & Features")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .segment, to: .technology)
                            }) {
                                Text("Tecnologia")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .segment, to: .investment)
                            }) {
                                Text("Investimento")
                            }
                        }
                    }//.onDelete(perform: removeSentenceFromSegmentClassification)
                }

                Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                    ForEach(newsList.newsProblemSentences) { sentence in
                        Text("\(sentence.text)")
                        .contextMenu() {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .problem, to: .segment)
                            }) {
                                Text("Segmento de Consumidores")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .problem, to: .solution)
                            }) {
                                Text("Solução & Features")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .problem, to: .technology)
                            }) {
                                Text("Tecnologia")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .problem, to: .investment)
                            }) {
                                Text("Investimento")
                            }
                        }
                    }
                }

                Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                    ForEach(newsList.newsSolutionSentences) { sentence in
                        Text("\(sentence.text)")
                        .contextMenu() {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .solution, to: .segment)
                            }) {
                                Text("Segmento de Consumidores")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .solution, to: .problem)
                            }) {
                                Text("Dor & Desejo")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .solution, to: .technology)
                            }) {
                                Text("Tecnologia")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .solution, to: .investment)
                            }) {
                                Text("Investimento")
                            }
                        }
                    }
                }

                Section(header: Text(SentenceModel.Classification.technology.rawValue)) {
                    ForEach(newsList.newsTechnologySentences) { sentence in
                        Text("\(sentence.text)")
                        .contextMenu() {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .technology, to: .segment)
                            }) {
                                Text("Segmento de Consumidores")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .technology, to: .problem)
                            }) {
                                Text("Dor & Desejo")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .technology, to: .solution)
                            }) {
                                Text("Solução & Features")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .technology, to: .investment)
                            }) {
                                Text("Investimento")
                            }
                        }
                    }
                }

                Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                    ForEach(newsList.newsInvestmentSentences) { sentence in
                        Text("\(sentence.text)")
                        .contextMenu() {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .investment, to: .segment)
                            }) {
                                Text("Segmento de Consumidores")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .investment, to: .problem)
                            }) {
                                Text("Dor & Desejo")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .investment, to: .solution)
                            }) {
                                Text("Solução & Features")
                            }
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(from: .investment, to: .technology)
                            }) {
                                Text("Tecnologia")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete:\(offsets.filter{_ in true}[0])")
    }
    
    func reclassifySentence(from currentClassification:SentenceModel.Classification, to newClassification:SentenceModel.Classification) {
        guard let sentence = selectedSentence else { return }
        self.newsList.reclassifySentence(sentence: sentence, from: currentClassification, to: newClassification)
    }
    
    func removeSentenceFromSegmentClassification(at offsets: IndexSet) {
        let index = offsets.filter{_ in true}[0]
        self.newsList.removeClassificationAtIndex(at: index, classification: .segment)
    }
    
    func removeSentenceFromProblemClassification(at offset: IndexSet) {
        
    }
    
    func removeSentenceFromSolutionClassification(at offset: IndexSet) {
        
    }
    
    func removeSentenceFromTechnologyClassification(at offset: IndexSet) {
        
    }
    
    func removeSentenceFromInvestmentClassification(at offset: IndexSet) {
        
    }
}

struct ClassifiedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ClassifiedNewsView()
    }
}
