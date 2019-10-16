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
    @State var isEditing = false
    @State private var text:String = "Não consigo inicializar o TextField. Ainda não sou um expert em swiftui."

    var body: some View {
        VStack {
            
            VStack () {
                Group {
                    if !isEditing {
                        Text(sentenceViewModel.text).padding()
                    }else {
                        TextField("", text: $text).padding().multilineTextAlignment(.leading).lineLimit(20)
                    }
                }
                HStack {
                    Toggle(isOn: $isEditing) {
                        Text("Editar")
                    }.padding([.trailing, .bottom, .leading])
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            }
            .overlay(RoundedRectangle(cornerRadius: 20.0).stroke(Color.blue, lineWidth: 1))
            .padding(.horizontal)
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(height: 350, alignment: .leading)
    }
    
    init(sentenceViewModel:SentenceViewModel) {
        self.sentenceViewModel = sentenceViewModel
    }
    
    func sentenceCommit() {
        print("sentenceCommited")
    }
    func changedSentence(hasFinished:Bool) {
        print ("finalizou edição")
    }
    
    func editSentence() {
        isEditing = true
        text = sentenceViewModel.text
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
