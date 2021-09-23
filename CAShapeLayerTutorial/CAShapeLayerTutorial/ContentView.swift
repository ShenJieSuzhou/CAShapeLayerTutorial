//
//  ContentView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/9/18.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @State var tabIndex: Int = 0
    var body: some View {
        TabView(selection: $tabIndex,
                content:  {
                    TestView().tabItem { Text("折线图") }.tag(1)
                    Text("Tab Content 2").tabItem { Text("树状图") }.tag(2)
                    Text("Tab Content 2").tabItem { Text("饼状图") }.tag(2)
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
