//
//  FetchNewsView.swift
//  StartseNewsClassifier
//
//  Created by Cristiano Araújo on 03/11/19.
//  Copyright © 2019 Cristiano Araújo. All rights reserved.
//

import SwiftUI

struct FetchNewsView: View {
    @State private var offset:CGSize = .zero

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
            Text("300").bold().font(.title)
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
    
    func fetchNextNewsToClassify() {}
}

struct FetchNewsView_Previews: PreviewProvider {
    static var previews: some View {
        FetchNewsView()
    }
}
