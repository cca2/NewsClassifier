//
//  NewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 13/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct SentenceView: View {
    private let text:String
    
    private var sentenceColor:Color = .white
    private let circleRadius:CGFloat = 20
    
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                    ScrollView {
                        Text(self.text)
                        .foregroundColor(sentenceColor)
                        .padding()
//                        .contextMenu() {
//                            Button(action: copyToClipboard) {
//                                Text("copiar")
//                            }
//                        }
                    }.contextMenu() {
                        Button(action: copyToClipboard) {
                            Text("copiar")
                        }
                    }
                }
                .frame(minWidth: 220, idealWidth: 220, maxWidth: 220, minHeight: 0, maxHeight: 280)
                .padding()
            }.frame(height: 280, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
        .background(Color.pink)
        .foregroundColor(sentenceColor)
        .cornerRadius(20)
    }
    
    init(text:String) {
        self.text = text
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
}

struct SentenceView_Previews: PreviewProvider {
    static var previews: some View {
        SentenceView(text: "Shawn Fanning é o menos conhecido da dupla que fundou o Napster, o primeiro software de download de músicas que fez sucesso mundial no início dos anos 2000.")
    }
}
