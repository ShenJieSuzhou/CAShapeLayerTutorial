//
//  LegendLineChartView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/11/8.
//

import SwiftUI

struct LegendLineChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var data: ChartData
    public var title: String?
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    
    public var formSize: CGSize?
    public var dropShadow: Bool?
    public var valueSpecifier: String
    
    @State private var showLegend = false
    @State private var dragLocation: CGPoint = .zero
    @State private var indicatorLocation: CGPoint = .zero
    @State private var closestPoint: CGPoint = .zero
    @State private var opacity: Double = 0
    @State private var currentValue: Double = 0
    @State private var hideHorizontalLines: Bool = false
    
    
    public init(data: [Double],
                title: String,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                form: CGSize? = ChartForm.medium,
                dropShadow: Bool? = true,
                valueSpecifier: String? = "%.1f") {
        
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.formSize = form
        self.dropShadow = dropShadow
        self.valueSpecifier = valueSpecifier!
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
    }
    
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    if self.title != nil {
                        Text(self.title!)
                            .font(.title)
                            .bold()
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.style.textColor)
                    }
                    
                    if self.legend != nil {
                        Text(self.legend!)
                            .font(.callout)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.style.legendTextColor)
                    }
                }.offset(x: 20, y: 20)
                ZStack {
                    GeometryReader { reader in
                        Rectangle()
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.backgroundColor : self.style.backgroundColor)
                        if self.showLegend {
                            Legend(data: self.data,
                                   frame: .constant(reader.frame(in: .local)), hideHorizontalLines: self.$hideHorizontalLines)
                                .transition(.opacity)
                                .animation(Animation.easeOut(duration: 1).delay(1))
                        }
                        Line(data: self.data,
                             frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 30, height: reader.frame(in: .local).height)), touchLocation: self.$indicatorLocation,
                             showIndicator: self.$hideHorizontalLines,
                             minDataValue: .constant(nil),
                             maxDataValue: .constant(nil), showBackground: false, gradient: self.style.gradientColor)
                            .offset(x: 30, y: -20)
                            .onAppear {
                                self.showLegend = true
                            }
                            .onDisappear {
                                self.showLegend = false
                            }
                    }.frame(width: geometry.frame(in: .local).size.width - 20, height: 240, alignment: .center)
                        .offset(x: 0, y: 40)
                    Magnifier(currentNumer: self.$currentValue, valueSpecifer: self.valueSpecifier)
                        .opacity(self.opacity)
                        .offset(x: self.dragLocation.x - geometry.frame(in: .local).size.width / 2, y: 36)
                    
                }.frame(width: geometry.frame(in: .local).size.width, height: 240, alignment: .center)
                    .gesture(
                        DragGesture().onChanged({ value in
                            self.dragLocation = value.location
                            self.indicatorLocation = CGPoint(x: max(value.location.x - 30, 0), y: 32)
                            self.opacity = 1
                            self.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: geometry.frame(in: .local).size.width - 30, height: 240)
                            self.hideHorizontalLines = true
                        }).onEnded({ value in
                                self.opacity = 0
                                self.hideHorizontalLines = false
                            })
                    )
            }
        }
    }
    
    
    @discardableResult func getClosestDataPoint(toPoint: CGPoint, width: CGFloat, height: CGFloat) -> CGPoint{
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count - 1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(round((toPoint.x)/stepWidth))
        if index >= 0 && index < points.count {
            self.currentValue = points[index]
            return CGPoint(x: CGFloat(index) * stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}


struct Legend: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var data: ChartData
    @Binding var frame: CGRect
    @Binding var hideHorizontalLines: Bool

    let padding: CGFloat = 3.0

    var stepWidth: CGFloat {
        if data.points.count < 2 {
            return 0
        }
        return frame.size.width / CGFloat(data.points.count - 1)
    }

    var stepHeight: CGFloat {
        let points = self.data.onlyPoints()
        if let min = points.min(), let max = points.max(), min != max {
            return (frame.size.height - padding) / CGFloat(max - min)
        }

        return 0
    }

    var min: CGFloat {
        let points = self.data.onlyPoints()
        return CGFloat(points.min() ?? 0)
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            ForEach((0...4), id: \.self) { height in
                HStack(alignment: .center) {
                    Text("\(self.getYLegendSafe(height: height), specifier: "%.2f")")
                        .offset(x: 0, y: self.getYPosition(height: height))
                        .foregroundColor(Colors.LegendText)
                        .font(.caption)
                    self.line(atHeight: self.getYLegendSafe(height: height), width: self.frame.width)
                        .stroke(self.colorScheme == .dark ? Colors.LegendDarkColor : Colors.LegendColor, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5,height == 0 ? 0 : 10]))
                        .opacity((self.hideHorizontalLines && height != 0) ? 0 : 1)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 0.2))
                        .clipped()
                }
            }
        }
    }

    func getYLegendSafe(height: Int) -> CGFloat {
        if let legend = getYLegend() {
            return CGFloat(legend[height])
        }
        return 0
    }

    func getYLegend() -> [Double]? {
        let points = self.data.onlyPoints()
        guard let max = points.max() else {
            return nil
        }

        guard let min = points.min() else {
            return nil
        }

        let step = Double(max - min)/4
        return [min+step * 0, min+step * 1, min+step * 2, min+step * 3, min+step * 4]
    }

    func getYPosition(height: Int) -> CGFloat {
        if let legend = getYLegend() {
            return (self.frame.height-((CGFloat(legend[height]) - min)*self.stepHeight))-(self.frame.height/2)
        }
        
        return 0.0
    }

    func line(atHeight: CGFloat, width: CGFloat) -> Path {
        var hLine = Path()
        hLine.move(to: CGPoint(x: 5, y: (atHeight-min)*stepHeight))
        hLine.addLine(to: CGPoint(x: width, y: (atHeight - min) * stepHeight))
        return hLine
    }
}



struct LegendLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            Legend(data: ChartData(points: [0.2,0.4,1.4,4.5]), frame: .constant(geometry.frame(in: .local)), hideHorizontalLines: .constant(false))
        }.frame(width: 320, height: 200)
    }
}
