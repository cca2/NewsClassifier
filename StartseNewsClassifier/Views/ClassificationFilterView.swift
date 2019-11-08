//
//  ClassificationFilterView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 05/11/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ClassificationFilterView: View {
    @Binding var selection:Int
    var body: some View {
        
        return VStack {
            Picker("", selection: $selection) {
                Text("Segmentos de Consumidores").tag(0)
                Text("Dores & Desejos").tag(1)
                Text("Solução & Features").tag(2)
                Text("Tecnologias").tag(3)
                Text("Investimento").tag(4)
            }.navigationBarTitle("Seleção")
            Spacer()
        }
    }
}


struct ClassificationFilterView_Previews: PreviewProvider {
    @State static var selection = 0
    static var previews: some View {
        ClassificationFilterView(selection: $selection)
    }
}
