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
    private var sentenceColor:Color = .gray
        
    var body: some View {
        VStack {
            
            VStack () {
                Group {
                    if !isEditing {
                        Text(sentenceViewModel.sentence.text)
                        .foregroundColor(sentenceColor)
                        .padding().contextMenu() {
//                            Button(action: editSentence) {
//                                HStack {
//                                    Text("editar")
//                                    Image(systemName: "pencil")
//                                }
//                            }
//
                            Button(action: classifyAsNone) {
                                HStack {
                                    Text("invalidar")
                                    Image(systemName: "bolt")
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
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(width:280, height: 450, alignment: .leading)
    }
    
    init(sentenceViewModel:SentenceViewModel) {
        self.sentenceViewModel = sentenceViewModel
        let classification = self.sentenceViewModel.sentence.classification
        if classification == .segment {
            self.sentenceColor = .red
        }else if classification == .problem {
            self.sentenceColor = .green
        }else if classification == .solution {
            self.sentenceColor = .orange
        }else if classification == .uvp {
            self.sentenceColor = .pink
        }else if classification == .investment {
            self.sentenceColor = .purple
        }else if classification == .partnership {
            self.sentenceColor = .black
        }else {
            self.sentenceColor = .gray
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
    
//    func classifyAsCustomerSegment() {
//        self.sentenceViewModel.classifySentenceAs(tag: "#CustomerSegment")
//    }
    
//    func classifyAsProblem() {
//        self.sentenceViewModel.classifySentenceAs(tag: "#Problem")
//    }
//
//    func classifyAsSolution() {
//        self.sentenceViewModel.classifySentenceAs(tag: "#Solution")
//    }
//
//    func classifyAsUVP() {
//        self.sentenceViewModel.classifySentenceAs(tag: "#UVP")
//    }
//
//    func classifyAsUnfairAdvantage() {
//        self.sentenceViewModel.classifySentenceAs(tag: "#UnfairAdvantage")
//    }
//
//    func classifyAsInvestiment() {
//        self.sentenceViewModel.classifySentenceAs(tag: "#Investiment")
//    }
    
//    func classifyAsPartnership() {
//        self.sentenceViewModel.classifySentenceAs(tag: "#Partnership")
//    }
//    
    func classifyAsNone() {
        self.sentenceViewModel.classifySentenceAs(tag: .none)
    }
}

struct SentenceView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceView(sentenceViewModel: SentenceViewModel(sentenceModel: SentenceModel(news: NewsModel(title: "teste", link: "http://www.cin.ufpe.br", text: "tesstando"), text: "Shawn Fanning é o menos conhecido da dupla que fundou o Napster, o primeiro software de download de músicas que fez sucesso mundial no início dos anos 2000.")))
    }
}
