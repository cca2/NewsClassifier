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
    
    var body: some View {
        VStack {
            Button(action: restartClassification, label: {Text("Reiniciar")})
            Spacer()
            Button(action: {}, label: {Text("Salvar")})
        }.frame(width: 100, height: 100, alignment: .center)
    }
    
    init (actOnFinishedClassification:ActOnClassification) {
        self.actOnClassification = actOnFinishedClassification
    }
    
    func restartClassification() {
        actOnClassification.restartClassification()
    }
}

struct FinishedClassificationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedClassificationView(actOnFinishedClassification: ContentView(sentences: SentenceListViewModel()))
    }
}
