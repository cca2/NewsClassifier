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
    
    let consolidationViewModel:ConsolidationViewModel
    @State var title:String = ""
    @State var sentences:[SentenceViewModel] = []

    @State var selection:Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ClassificationFilterView(selection: $selection)){
                    HStack {
                        Text("Filtrar todas as classificações")
                        Image(systemName: "slider.horizontal.3")
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50, alignment: .trailing)
                        .padding([.trailing])
                        .background(Color.black)
                        .foregroundColor(.white)
                }.padding([.top])

                Spacer()
                List (self.sentences) { sentence in
                    Text(sentence.text).font(.body)
                }.navigationBarTitle(title).font(.headline)
                .onAppear() {
                    if self.selection == 0 {
                        self.title = "Consumidores"
                    }else if self.selection == 1 {
                        self.title = "Jobs"
                    }else if self.selection == 2 {
                        self.title = "Outcomes"
                    }else if self.selection == 3 {
                        self.title = "Solução & Features"
                    }else if self.selection == 4 {
                        self.title = "Tecnologias"
                    }else {
                        self.title = "Investimento"
                    }
                    self.consolidationViewModel.filterSelection = self.selection
                    self.sentences = self.consolidationViewModel.filteredSentences
                }
            }
        }
    }
}

//struct ConsolidationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConsolidationView(
//    }
//}
