//
//  MutiLineChartView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/11/5.
//

import SwiftUI

struct MutiLineChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var data: [MultiLineChartData]
    public var title: String
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    
    public var formSize: CGSize
    public var dropShadow: Bool
    public var valueSpecifier: String
    
    @State private var touchLocation: CGPoint = .zero
    @State private var showIndicatorDot: Bool = false
    
    var globalMin:Double {
        if let min = data.flatMap({$0.onlyPoints()}).min() {
            return min
        }
        return 0
    }
    
    var globalMax:Double {
        if let max = data.flatMap({$0.onlyPoints()}).max() {
            return max
        }
        return 0
    }
    
    private var rateValue: Int?
    var frame = CGSize(width: 180, height: 120)
    
    public init(data: [([Double], GradientColor)],
                title: String,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleOne,
                form: CGSize? = ChartForm.medium,
                rateValue: Int? = 14,
                dropShadow: Bool? = true,
                valueSpecifier: String? = "%.1f") {
        
        self.data = data.map({ MultiLineChartData(points: $0.0, gradient: $0.1)})
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
        self.formSize = form!
        frame = CGSize(width: self.formSize.width, height: self.formSize.height/2)
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
        self.rateValue = rateValue
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .fill(self.colorScheme == .dark ? self.darkModeStyle.backgroundColor : self.style.backgroundColor)
                .frame(width: formSize.width, height: formSize.height, alignment: .center)
                .shadow(color: self.style.dropShadowColor, radius: self.dropShadow ? 8 : 0)
        
            VStack(alignment: .leading, spacing: 8) {
                GeometryReader{ geometry in
                    ZStack {
                        ForEach(0..<self.data.count) { i in
                            Line(data: self.data[i],
                                 frame: .constant(geometry.frame(in: .local)),
                                 touchLocation: self.$touchLocation,
                                 showIndicator: self.$showIndicatorDot,
                                 minDataValue: .constant(self.globalMin),
                                 maxDataValue: .constant(self.globalMax),
                                 showBackground: false,
                                 gradient: self.data[i].getGradient(),
                                 index: i
                            )
                        }
                    }
                }
                .frame(width: formSize.width, height: formSize.height/2, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(x: 0, y: 0)
            }
            .frame(width: formSize.width, height: formSize.height, alignment: .center)
        }
    }
}

struct MutiLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        MutiLineChartView(data: [([8,23,54,32,12,37,7,23,43], GradientColors.orange)], title: "Line chart", legend: "Basic")
    }
}
