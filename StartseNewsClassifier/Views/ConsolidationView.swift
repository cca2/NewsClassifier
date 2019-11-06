//
//  ConsolidationView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 05/11/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ConsolidationView: View {
    //Comentado apenas para ver o preview
    @Environment(\.managedObjectContext) var context
    
    @State var consolidationViewModel:ConsolidationViewModel?

    @State var sentences:[SentenceViewModel] = []
    
    @State private var selectionTitle:String = "Dor ou Desejo"
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ClassificationFilterView()){
                    HStack {
                        Text("Filtrar todas as classificações")
                        Image(systemName: "slider.horizontal.3")
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .trailing)
                        .padding([.trailing])
                        .background(Color.black)
                        .foregroundColor(.white)
                }

                Spacer()
                List (sentences) { sentence in
                    Text(sentence.text)
                }.navigationBarTitle(selectionTitle).font(.headline)
            }
        }.onAppear() {
            self.consolidationViewModel = ConsolidationViewModel(context: self.context)
        }
    }
}

struct ConsolidationView_Previews: PreviewProvider {
    static var previews: some View {
        ConsolidationView()
    }
}
