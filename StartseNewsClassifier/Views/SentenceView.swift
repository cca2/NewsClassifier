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

    @State private var text:String = "Não consigo inicializar o TextField."
    private var sentenceColor:Color = .gray
        
    var body: some View {
            VStack () {
                Text(sentenceViewModel.sentence.text)
                .foregroundColor(sentenceColor)
                .padding()
                .contextMenu() {
                    Button(action: copyToClipboard) {
                        Text("copiar")
                    }

                    Button(action: classifyAsNone) {
                        Text("invalidar")
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
    
    func copyToClipboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = sentenceViewModel.sentence.text
    }
    
    func classifyAsNone() {
        self.sentenceViewModel.classifySentenceAs(tag: .none)
    }
}

struct SentenceView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceView(sentenceViewModel: SentenceViewModel(sentenceModel: SentenceModel(news: NewsModel(title: "teste", link: "http://www.cin.ufpe.br", text: "tesstando", sentences: []), text: "Shawn Fanning é o menos conhecido da dupla que fundou o Napster, o primeiro software de download de músicas que fez sucesso mundial no início dos anos 2000.", classification: SentenceModel.Classification(rawValue: "#None")!)))
    }
}
