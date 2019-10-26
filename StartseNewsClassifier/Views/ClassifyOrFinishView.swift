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

struct ClassifyOrFinishView: View, ActOnClassification {
    @State var hasFinishedClassification = false

    private let classifier:ClassifiedNewsViewModel
    
    var body: some View {
        Group {
            if (hasFinishedClassification) {
                FinishedClassificationView(actOnFinishedClassification: self, classifier: self.classifier)
            }else {
                ClassificationView(actOnClassification: self, classifier: self.classifier)
            }
        }
    }
    
    init(classifier:ClassifiedNewsViewModel) {
        self.classifier = classifier
    }
    
    func finishedClassification() {
        hasFinishedClassification = true
    }
    
    func restartClassification() {
        hasFinishedClassification = false
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ClassifyOrFinishView(sentences: ClassifiedNewsViewModel(news: NewsModel())
//    }
//}
