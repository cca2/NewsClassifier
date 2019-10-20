//
//  FinishedClassificationView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 19/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct FinishedClassificationView: View {
    private let actOnClassification:ActOnClassification
    private let sentences:SentenceListViewModel
    
    var body: some View {
        VStack {
            Button(action: restartClassification, label: {Text("Reiniciar")})
            Spacer()
            Button(action: saveClassification, label: {Text("Salvar")})
        }.frame(width: 100, height: 100, alignment: .center)
    }
    
    init (actOnFinishedClassification:ActOnClassification, sentences:SentenceListViewModel) {
        self.actOnClassification = actOnFinishedClassification
        self.sentences = sentences
    }
    
    func restartClassification() {
        actOnClassification.restartClassification()
    }
    
    func saveClassification() {
        sentences.saveClassifiedSentences()
    }
}

struct FinishedClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedClassificationView(actOnFinishedClassification: ContentView(sentences: SentenceListViewModel()), sentences: SentenceListViewModel())
    }
}
