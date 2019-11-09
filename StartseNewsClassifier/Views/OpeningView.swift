//
//  OpeningView.swift
//  StartseNewsClassifier4Mac
//
//  Created by Cristiano Araújo on 09/11/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct OpeningView: View {
    @State var numNewsToBeClassified:Int = 85
    var body: some View {
        VStack {
            HStack {
                Text("Faltam")
                Text("\(numNewsToBeClassified)")
                Text("notícias a serem classificadas")
            }.padding([.bottom], 50)
            VStack {
                Text("Leia a notícia. Apague ou Envie para classificação")
            }
        }
    }
}

struct OpeningView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningView()
    }
}
