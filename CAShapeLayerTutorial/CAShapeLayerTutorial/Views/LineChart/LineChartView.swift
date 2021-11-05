//
//  LineChartView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/11/5.
//

import SwiftUI

struct LineChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var data: ChartData
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    
    public var formSize: CGSize
    public var dropShadow: Bool
    public var valueSpecifier: String
    
    @State private var touchLocation: CGPoint = .zero
    @State private var showIndicatorDot: Bool = false
    @State private var currentValue: Double = 2 {
        didSet {
            
        }
    }
    
    public init(data: [Double],
                title: String,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                form: CGSize? = ChartForm.medium,
                rateValue: Int? = 14,
                dropShadow: Bool? = true,
                valueSpecifier: String? = "%.1f") {
        
        self.data = ChartData(points: data)
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
        self.formSize = form!
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
        self.rateValue = rateValue
    }
    
    private var rateValue: Int?
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .fill(self.colorScheme == .dark ? self.darkModeStyle.backgroundColor : self.style.backgroundColor)
                .frame(width: formSize.width, height: formSize.height, alignment: .center)
                .shadow(color: self.style.dropShadowColor, radius: self.dropShadow ? 9 : 0)
        
            VStack(alignment: .leading, spacing: 0) {
                if !self.showIndicatorDot {
                    
                } else {
                    HStack{
                        Spacer()
                        Text("\(self.currentValue, specifier: self.valueSpecifier)")
                            .font(.headline)
                            .offset(x: 0, y: 30)
                        Spacer()
                    }
                    .transition(.scale)
                }
                Spacer()
                GeometryReader{ geometry in
                    Line(data: self.data,
                         frame: .constant(geometry.frame(in: .local)),
                         touchLocation: self.$touchLocation,
                         showIndicator: self.$showIndicatorDot,
                         minDataValue: .constant(nil),
                         maxDataValue: .constant(nil)
                    )
                }
                .frame(width: formSize.width, height: formSize.height, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: 0, y: 0)
            }
            .frame(width: formSize.width, height: formSize.height, alignment: .center)
        }
        .gesture(
            DragGesture().onChanged({ value in
                self.touchLocation = value.location
                self.showIndicatorDot = true
                self.getClosestDataPoint(toPoint: value.location, width: formSize.width, height: formSize.height)
            }).onEnded({ value in
                self.showIndicatorDot = false
            })
        )
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

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(data: [8,9], title: "test").environment(\.colorScheme, .light)
    }
}
