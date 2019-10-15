//
//  NewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct SentenceView: View {
//    @State var classification:String = ">>> NENHUMA <<<"
//    @State var text:String = "Shawn Fanning é o menos conhecido da dupla que fundou o Napster, o primeiro software de download de músicas que fez sucesso mundial no início dos anos 2000."
    
    @ObservedObject private var sentenceViewModel:SentenceViewModel
    
    var body: some View {
        VStack {
            
            VStack () {
//                Text(sentenceViewModel.classification).bold()
                Text(sentenceViewModel.text).padding()
                HStack {
                    Button(action: editSentence, label: {Text("editar")}).padding([.trailing, .bottom])
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
    
    func editSentence() {}
    
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
