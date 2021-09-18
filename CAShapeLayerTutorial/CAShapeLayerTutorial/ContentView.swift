//
//  ContentView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/9/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Hello, world!")
                .padding()
            StockLine()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
