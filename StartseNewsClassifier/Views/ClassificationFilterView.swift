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
                Text("Consumidores").tag(0)
                Text("Jobs").tag(1)
                Text("Outcomes").tag(2)
                Text("Solução & Features").tag(3)
                Text("Tecnologias").tag(4)
                Text("Investimento").tag(5)
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
