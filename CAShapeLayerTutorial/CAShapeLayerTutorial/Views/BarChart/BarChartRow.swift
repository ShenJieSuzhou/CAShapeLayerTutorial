//
//  BarChartRow.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/11/4.
//

import SwiftUI

struct BarChartRow: View {
    var data: [Double]
    var accentColor: Color
    var gradient: GradientColor?
    
    var maxValue: Double {
        guard let max = data.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }
    
    @Binding var touchLocation: CGFloat
    public var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: getSpaceWidth(width: geometry.frame(in: .local).width - 20)) {
                ForEach(0..<self.data.count, id: \.self){ i in
                    BarChartCell(value: self.normalizedValue(index: i),
                                 index: i,
                                 width: Float(geometry.frame(in: .local).width - 20),
                                 numberOfDataPoints: self.data.count,
                                 accentColor: self.accentColor,
                                 gradient: self.gradient,
                                 touchLocation: self.$touchLocation)
                        .scaleEffect(self.touchLocation > CGFloat(i) / CGFloat(self.data.count) && self.touchLocation < CGFloat(i+1) / CGFloat(self.data.count) ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                        .animation(.spring())
                }
            }.padding([.top, .leading, .trailing], 20)
        }
    }

    
    func normalizedValue(index: Int) -> Double {
        return Double(self.data[index]) / Double(self.maxValue)
    }
    
    func getSpaceWidth(width: Double) -> Double{
        let perCellWidth: Double = width / (Double(data.count) * 1.5)
        return (width - (perCellWidth * Double(data.count))) / Double((data.count + 1))
    }
}

struct BarChartRow_Previews: PreviewProvider {
    static var previews: some View {
        BarChartRow(data: [0], accentColor: Colors.OrangeStart, touchLocation: .constant(-1))
    }
}
