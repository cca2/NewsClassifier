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
    private let classifier:NewsClassifierViewModel
    
    var body: some View {
        VStack {
            Button(action: restartClassification, label: {Text("Reclassificar")})
            Spacer()
            Button(action: saveClassification, label: {Text("Salvar")})
        }.frame(width: 100, height: 100, alignment: .center)
    }
    
    init (actOnFinishedClassification:ActOnClassification, classifier:NewsClassifierViewModel) {
        self.actOnClassification = actOnFinishedClassification
        self.classifier = classifier
    }
    
    func restartClassification() {
        actOnClassification.restartClassification()
    }
    
    func saveClassification() {
        classifier.saveClassifiedSentences()
    }
}

//struct FinishedClassificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        FinishedClassificationView(actOnFinishedClassification: ClassifyOrFinishView(sentences: NewsClassifierViewModel()), sentences: NewsClassifierViewModel())
//    }
//}