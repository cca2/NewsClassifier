//
//  FetchNewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 03/11/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct FetchNewsView: View {
    @Binding var numNewsToClassify:Int
    @State private var offset:CGSize = .zero
    @State private var isLoading:Bool = false
    
    @EnvironmentObject var newsList:NewsListViewModel
    //Acessando o contexto para CoreData
    @Environment(\.managedObjectContext) var context

    var body: some View {
        let drag = DragGesture()
        .onChanged {
            if $0.translation.height > 0 {
                self.offset = $0.translation
            }
        }
        .onEnded {
            if (($0.translation.width < 30) && ($0.translation.width > -30)) {
                if $0.translation.height > 30 {
                    self.fetchNextNewsToClassify()
                    self.offset = .init(width: 0, height: 0)
                }else {
                    self.offset = .zero
                }
            }
        }

        return VStack {                        
            if (self.newsList.isLoading) {
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            }
            
            Text("\(self.newsList.totalClassifiedNews)").bold().font(.title)
            Text("Notícias classificadas")
            Text("Que tal classificar mais")
            Text("3").bold().font(.title)
            Text("notícias")
            VStack(spacing: 1) {
                Image(systemName: "chevron.down")
                Image(systemName: "chevron.down")
                Image(systemName: "chevron.down")
            }

        }.font(.system(size: 24))
        .foregroundColor(.pink)
        .padding(20)
        .offset(x: 0, y: offset.height)
        .gesture(drag)
    }
        
    func fetchNextNewsToClassify() {
        self.isLoading = true
        self.newsList.loadLatestNews() {
            self.numNewsToClassify = self.newsList.articles.count
        }
    }
}

struct FetchNewsView_Previews: PreviewProvider {
    @State static var numNewsToClassify = 0
    static var previews: some View {
        FetchNewsView(numNewsToClassify: $numNewsToClassify)
    }
}
