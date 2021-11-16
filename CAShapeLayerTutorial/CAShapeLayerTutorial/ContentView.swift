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
                    LineChart().tabItem {
                        Group {
                            Image(systemName: "waveform.path.ecg")
                            Text("Line charts")
                        }
                    }.tag(1)
                    PieChart().tabItem {
                        Group {
                            Image(systemName: "chart.pie")
                            Text("Pie charts")
                        }
                    }.tag(2)
                    LegendLineChart().tabItem {
                        Group {
                            Image(systemName: "waveform.path.ecg")
                            Text("Legend charts")
                        }
                    }.tag(3)
        })
    }
}

struct BarCharts: View {
    var body: some View {
        VStack {
            BarChartView(data: ChartData(points: [8,23,54,32,12,37,7,23,43]), title: "数值", style: Styles.barChartStyleOrangeDark)
        }
    }
}

struct LineChart: View {
    var body: some View {
        HStack {
            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "", style: Styles.lineChartStyleOne).padding()
            MutiLineChartView(data: [([8,23,54,32,12,37,7,23,43], GradientColors.orange), ([5,30,40,12,16,7,57,30,13], GradientColors.purple)], title: "")
        }
    }
}

struct PieChart: View {
    var body: some View {
        VStack {
            PieChartView(data: [8,23,54,32,12,37,7,23,43], title: "", style: Styles.pieChartStyleOne)
        }
    }
}


struct MutiLineChart: View {
    var body: some View {
        VStack {
            MutiLineChartView(data: [([8,23,54,32,12,37,7,23,43], GradientColors.orange), ([5,30,40,12,16,7,57,30,13], GradientColors.purple)], title: "title")
        }
    }
}

struct LegendLineChart: View {
    var body: some View {
        VStack {
            LegendLineChartView(data: [8,23,54,32,12,37,7,23,43], title: "")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
