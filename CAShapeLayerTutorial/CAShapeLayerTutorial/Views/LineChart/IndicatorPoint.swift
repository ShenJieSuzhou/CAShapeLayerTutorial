//
//  IndicatorPoint.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/11/5.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        ZStack {
            Circle().fill(Colors.IndicatorKnob)
            Circle().stroke(Color.white, style: StrokeStyle(lineWidth: 4))
        }
        .frame(width: 14, height: 14, alignment: .center)
        .shadow(color: Colors.LegendColor, radius: 6, x: 0, y: 6)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
