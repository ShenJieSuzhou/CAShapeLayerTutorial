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
                    BarCharts().tabItem {
                        Group {
                            Image(systemName: "chart.bar")
                            Text("Bar charts")
                        }
                    }.tag(0)
                    TestView().tabItem { Text("折线图") }.tag(1)
                    RectangleChartView().tabItem { Text("树状图") }.tag(2)
                    PieChartView().tabItem { Text("饼状图") }.tag(3)
                })
    }
}

struct BarCharts: View {
    var body: some View {
        VStack {
            BarChartView(data: ChartData(points: [8,3]), title: "Hello", style: Styles.barChartStyleOrangeLight)
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
