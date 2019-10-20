//
//  ContentView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 19/10/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

protocol ActOnClassification {
    func finishedClassification()
    func restartClassification()
}

struct ContentView: View, ActOnClassification {
    @State var hasFinishedClassification = false

    private let sentences:SentenceListViewModel
    
    var body: some View {
        Group {
            if (hasFinishedClassification) {
                FinishedClassificationView(actOnFinishedClassification: self, sentences: self.sentences)
            }else {
                ClassificationView(actOnClassification: self, sentences: self.sentences)
            }
        }
    }
    
    init(sentences:SentenceListViewModel) {
        self.sentences = sentences
    }
    
    func finishedClassification() {
        hasFinishedClassification = true
    }
    
    func restartClassification() {
        hasFinishedClassification = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sentences: SentenceListViewModel())
    }
}
