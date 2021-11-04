//
//  ContentView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/9/18.
//

import SwiftUI

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
                    BarCharts().tabItem {
                        Group {
                            Image(systemName: "chart.bar")
                            Text("Bar charts")
                        }
                    }.tag(1)
                    BarCharts().tabItem {
                        Group {
                            Image(systemName: "chart.bar")
                            Text("Bar charts")
                        }
                    }.tag(2)
                    BarCharts().tabItem {
                        Group {
                            Image(systemName: "chart.bar")
                            Text("Bar charts")
                        }
                    }.tag(3)
//                    TestView().tabItem { Text("折线图") }.tag(1)
//                    RectangleChartView().tabItem { Text("树状图") }.tag(2)
//                    PieChartView().tabItem { Text("饼状图") }.tag(3)
                })
    }
}

struct BarCharts: View {
    var body: some View {
        VStack {
            BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "value", style: Styles.barChartStyleNeonBlueLight)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
