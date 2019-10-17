//
//  NewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct SentenceView: View {
    @ObservedObject private var sentenceViewModel:SentenceViewModel

    @State var isEditing:Bool = false
    @State private var text:String = "Não consigo inicializar o TextField."
    private var sentenceColor:Color = .pink
        
    var body: some View {
        VStack {
            
            VStack () {
                Group {
                    if !isEditing {
                        Text(sentenceViewModel.sentence.text).foregroundColor(sentenceColor).padding().contextMenu() {
                            Button(action: editSentence) {
                                HStack {
                                    Text("editar")
                                    Image(systemName: "pencil")
                                }
                            }

                            Button(action: editSentence) {
                                HStack {
                                    Text("invalidar")
                                    Image(systemName: "search")
                                }
                            }

                            Button(action: {}) {
                                HStack {
                                    Text("apagar")
                                    Image(systemName: "trash")
                                }
                            }                            
                        }
                    }else {
                        VStack {
                            TextField("", text: $text).padding().multilineTextAlignment(.leading).lineLimit(20)
                            Button(action: saveEditedSentence, label: {Text("salvar edição")}).padding([.bottom, .trailing])
                        }
                    }
                }
//                HStack {
//                    if !isEditing {
//                        Button(action: editSentence, label: {Text("editar")}).padding([.bottom, .trailing]).foregroundColor(sentenceColor)
//                    }else {
//                        Button(action: saveEditedSentence, label: {Text("salvar edição")}).padding([.bottom, .trailing])
//                    }
//                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(height: 350, alignment: .leading)
    }
    
    init(sentenceViewModel:SentenceViewModel) {
        self.sentenceViewModel = sentenceViewModel
        let classification = self.sentenceViewModel.sentence.classification
        if classification == "#Segment" {
            self.sentenceColor = .red
        }else if classification == "#Problem" {
            self.sentenceColor = .green
        }else if classification == "#Solution" {
            self.sentenceColor = .orange
        }else if classification == "#UVP" {
            self.sentenceColor = .gray
        }else if classification == "#Investment" {
            self.sentenceColor = .purple
        }else if classification == "#Partnership" {
            self.sentenceColor = .black
        }
    }
    
    func sentenceCommit() {
        print("sentenceCommited")
    }
    func changedSentence(hasFinished:Bool) {
        print ("finalizou edição")
    }
    
    func editSentence() {
        isEditing.toggle()
        text = sentenceViewModel.sentence.text
    }
    
    func saveEditedSentence() {
        isEditing.toggle()
        sentenceViewModel.sentence.text = text
    }
    
    func classifyAsCustomerSegment() {
        self.sentenceViewModel.classifySentenceAs(tag: "#CustomerSegment")
    }
    
    func classifyAsProblem() {
        self.sentenceViewModel.classifySentenceAs(tag: "#Problem")
    }
    
    func classifyAsSolution() {
        self.sentenceViewModel.classifySentenceAs(tag: "#Solution")
    }
    
    func classifyAsUVP() {
        self.sentenceViewModel.classifySentenceAs(tag: "#UVP")
    }
    
    func classifyAsUnfairAdvantage() {
        self.sentenceViewModel.classifySentenceAs(tag: "#UnfairAdvantage")
    }
    
    func classifyAsInvestiment() {
        self.sentenceViewModel.classifySentenceAs(tag: "#Investiment")
    }
    
    func classifyAsPartnership() {
        self.sentenceViewModel.classifySentenceAs(tag: "#Partnership")
    }
}

struct SentenceView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceView(sentenceViewModel: SentenceViewModel(sentenceModel: SentenceModel(news: NewsModel(title: "teste", link: "http://www.cin.ufpe.br", text: "tesstando"), text: "Shawn Fanning é o menos conhecido da dupla que fundou o Napster, o primeiro software de download de músicas que fez sucesso mundial no início dos anos 2000.")))
    }
}
