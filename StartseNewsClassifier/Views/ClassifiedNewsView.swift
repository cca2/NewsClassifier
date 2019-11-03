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

    //Comentado apenas para ver o preview
    @Environment(\.managedObjectContext) var context

    @State private var selectedSentence:SentenceViewModel?

//    @State private var segmentSentences:[SentenceViewModel] = []
//    @State private var problemSentences:[SentenceViewModel] = []
//    @State private var solutionSentences:[SentenceViewModel] = []
//    @State private var technologySentences:[SentenceViewModel] = []
//    @State private var investmentSentences:[SentenceViewModel] = []
    
    @State private var hasFinishedClassification = false

    var body: some View {
        List {
            Section(header: Text(SentenceModel.Classification.segment.rawValue)) {
                ForEach(self.newsList.newsSegmentSentences) { sentence in
                    Text("\(sentence.text)")
                    .contextMenu() {
                        if !sentence.containsSegment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .segment)
                            }) {
                                Text("Segmento de Consumidores")
                            }
                        }
                        if !sentence.containsProblem {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .problem)
                            }) {
                                Text("Dor & Desejo")
                            }
                        }
                        if !sentence.containsSolution {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .solution)
                            }) {
                                Text("Solução & Features")
                            }
                        }
                        if !sentence.containsTechnology {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .technology)
                            }) {
                                Text("Tecnologia")
                            }
                        }
                        if !sentence.containsInvestment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .investment)
                            }) {
                                Text("Investimento")
                            }

                        }
                    }
                }.onDelete(perform: removeSentenceFromSegmentClassification)
            }

            Section(header: Text(SentenceModel.Classification.problem.rawValue)) {
                ForEach(self.newsList.newsProblemSentences) { sentence in
                    Text("\(sentence.text)")
                    .contextMenu() {
                        if !sentence.containsSegment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .segment)
                            }) {
                                Text("Segmento de Consumidores")
                            }
                        }
                        if !sentence.containsProblem {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .problem)
                            }) {
                                Text("Dor & Desejo")
                            }
                        }
                        if !sentence.containsSolution {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .solution)
                            }) {
                                Text("Solução & Features")
                            }
                        }
                        if !sentence.containsTechnology {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .technology)
                            }) {
                                Text("Tecnologia")
                            }
                        }
                        if !sentence.containsInvestment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .investment)
                            }) {
                                Text("Investimento")
                            }

                        }
                    }
                }.onDelete(perform: removeSentenceFromProblemClassification)
            }

            Section(header: Text(SentenceModel.Classification.solution.rawValue)) {
                ForEach(self.newsList.newsSolutionSentences) { sentence in
                    Text("\(sentence.text)")
                    .contextMenu() {
                        if !sentence.containsSegment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .segment)
                            }) {
                                Text("Segmento de Consumidores")
                            }
                        }
                        if !sentence.containsProblem {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .problem)
                            }) {
                                Text("Dor & Desejo")
                            }
                        }
                        if !sentence.containsSolution {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .solution)
                            }) {
                                Text("Solução & Features")
                            }
                        }
                        if !sentence.containsTechnology {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .technology)
                            }) {
                                Text("Tecnologia")
                            }
                        }
                        if !sentence.containsInvestment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .investment)
                            }) {
                                Text("Investimento")
                            }

                        }
                    }
                }.onDelete(perform: removeSentenceFromSolutionClassification)
            }

            Section(header: Text(SentenceModel.Classification.technology.rawValue)) {
                ForEach(self.newsList.newsTechnologySentences) { sentence in
                    Text("\(sentence.text)")
                    .contextMenu() {
                        if !sentence.containsSegment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .segment)
                            }) {
                                Text("Segmento de Consumidores")
                            }
                        }
                        if !sentence.containsProblem {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .problem)
                            }) {
                                Text("Dor & Desejo")
                            }
                        }
                        if !sentence.containsSolution {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .solution)
                            }) {
                                Text("Solução & Features")
                            }
                        }
                        if !sentence.containsTechnology {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .technology)
                            }) {
                                Text("Tecnologia")
                            }
                        }
                        if !sentence.containsInvestment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .investment)
                            }) {
                                Text("Investimento")
                            }

                        }
                    }
                }.onDelete(perform: removeSentenceFromTechnologyClassification)
            }

            Section(header: Text(SentenceModel.Classification.investment.rawValue)) {
                ForEach(self.newsList.newsInvestmentSentences) { sentence in
                    Text("\(sentence.text)")
                    .contextMenu() {
                        if !sentence.containsSegment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .segment)
                            }) {
                                Text("Segmento de Consumidores")
                            }
                        }
                        if !sentence.containsProblem {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .problem)
                            }) {
                                Text("Dor & Desejo")
                            }
                        }
                        if !sentence.containsSolution {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .solution)
                            }) {
                                Text("Solução & Features")
                            }
                        }
                        if !sentence.containsTechnology {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .technology)
                            }) {
                                Text("Tecnologia")
                            }
                        }
                        if !sentence.containsInvestment {
                            Button(action: {
                                self.selectedSentence = sentence
                                self.reclassifySentence(as: .investment)
                            }) {
                                Text("Investimento")
                            }

                        }
                    }
                }.onDelete(perform: removeSentenceFromInvestmentClassification)
            }
        }.navigationBarTitle("Frases")
        .navigationBarItems(trailing: Button(action: finalizeClassification) {Text("finalizar")} )
    }
    
    func delete(at offsets: IndexSet) {
        print("delete:\(offsets.filter{_ in true}[0])")
    }
    
    func finalizeClassification() {
        print(">>> Finalizando a Classificação")
        self.newsList.updateNewsClassificationStatus(isClassified: true, context: context)
    }
    
    func reclassifySentence(as newClassification:SentenceModel.Classification) {
        guard let sentence = selectedSentence else { return }
        if newClassification == .segment && !sentence.containsSegment {
            self.newsList.reclassifySentence(sentence: sentence, as: .segment)
            self.newsList.newsSegmentSentences.append(sentence)
        }else if newClassification == .problem && !sentence.containsProblem {
            self.newsList.reclassifySentence(sentence: sentence, as: .problem)
            self.newsList.newsProblemSentences.append(sentence)
        }else if newClassification == .solution && !sentence.containsSolution {
            self.newsList.reclassifySentence(sentence: sentence, as: .solution)
            self.newsList.newsSolutionSentences.append(sentence)
        }else if newClassification == .technology && !sentence.containsTechnology {
            self.newsList.reclassifySentence(sentence: sentence, as: .technology)
            self.newsList.newsTechnologySentences.append(sentence)
        }else if newClassification == .investment && !sentence.containsInvestment {
            self.newsList.reclassifySentence(sentence: sentence, as: .investment)
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
