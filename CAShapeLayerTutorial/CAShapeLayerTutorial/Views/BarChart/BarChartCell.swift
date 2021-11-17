//
//  BarChartCell.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/11/4.
//

import SwiftUI

struct BarChartCell: View {
    
    var value: Double
    var index: Int = 0
    var width: Float
    var numberOfDataPoints: Int
    var cellWidth: Double {
        return Double(width) / (Double(numberOfDataPoints) * 1.5)
    }
    var accentColor: Color
    var gradient: GradientColor?
    
    @State var scaleValue: Double = 0
    @Binding var touchLocation: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { gr in
                RoundedRectangle(cornerRadius: 4)
                    .fill(LinearGradient(gradient: gradient?.getGradient() ?? GradientColor(start: accentColor, end: accentColor).getGradient(), startPoint: .bottom, endPoint: .top))
                    .frame(width: CGFloat(self.cellWidth))
                    .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
                    .onAppear {
                        self.scaleValue = self.value
                        
                        print("local: \(gr.frame(in: .local))")
                    }
                    .animation(.spring().delay(self.touchLocation < 0 ? Double(self.index) * 0.04 : 0))
                
            }
        }
    }
}

struct BarChartCell_Previews: PreviewProvider {
    static var previews: some View {
        BarChartCell(value: Double(0.75), width: 320, numberOfDataPoints: 12, accentColor: Colors.OrangeStart, gradient: nil, touchLocation: .constant(-1))
    }
}
