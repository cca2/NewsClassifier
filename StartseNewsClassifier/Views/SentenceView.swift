//
//  NewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct SentenceView: View {
//    @ObservedObject private var sentenceViewModel:SentenceViewModel

    @State private var text:String = "Está é uma sentença que não foi INICIALIZADA corretamente"
    
    private var sentenceColor:Color = .gray
//    private var classifier:ClassifiedNewsViewModel

    private let circleRadius:CGFloat = 20
    
    var body: some View {
            VStack () {
//                Text(sentenceViewModel.sentence.text)
                Text(text)
                .foregroundColor(sentenceColor)
                .padding()
                .contextMenu() {
                    Button(action: copyToClipboard) {
                        Text("copiar")
                    }

//                    Button(action: classifyAsNone) {
//                        Text("invalidar")
//                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(width:280, height: 350, alignment: .leading)
    }
    
    init(text:String) {
        self.text = text
//        self.sentenceViewModel = sentenceViewModel
//        self.classifier = classifier
    }
    
    func sentenceCommit() {
        print("sentenceCommited")
    }
    func changedSentence(hasFinished:Bool) {
        print ("finalizou edição")
    }
    
    func copyToClipboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
    }
    
//    func classifyAsNone() {
//        self.classifier.classifySentenceAs(sentence: self.sentenceViewModel.sentence, newClassification: .none)
//    }
}

struct SentenceView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceView(text: "Shawn Fanning é o menos conhecido da dupla que fundou o Napster, o primeiro software de download de músicas que fez sucesso mundial no início dos anos 2000.")
    }
}
