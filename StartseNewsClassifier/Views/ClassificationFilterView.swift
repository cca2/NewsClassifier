//
//  ClassificationFilterView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 05/11/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ClassificationFilterView: View {
    @State private var classificationSelection = 0
    var body: some View {
        VStack {
            Picker("", selection: $classificationSelection) {
                Text("Segmentos de Consumidores").tag(SentenceModel.Classification.segment)
                Text("Dores & Desejos").tag(SentenceModel.Classification.problem)
                Text("Solução & Features").tag(SentenceModel.Classification.solution)
                Text("Tecnologias").tag(SentenceModel.Classification.technology)
                Text("Investimento").tag(SentenceModel.Classification.investment)
            }.navigationBarTitle("Seleção")
            Spacer()
        }
    }
}

struct ClassificationFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ClassificationFilterView()
    }
}
