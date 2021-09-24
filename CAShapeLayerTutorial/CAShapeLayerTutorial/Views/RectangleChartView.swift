//
//  RectangleChartView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/9/24.
//

import SwiftUI

struct RectangleChartView: View {
    var body: some View {
        ZStack(alignment: .center) {
//            RoundedRectangle(cornerRadius: 4)
//                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .bottom, endPoint: .top))
//                .frame(width: CGFloat(20), height: 100)
//                .scaleEffect(CGSize(width: 1, height: 100), anchor: .bottom)
//            }
        
            Capsule()
                .fill(Color.green)
                .frame(width: 100, height: 50)

            Ellipse()
                .fill(Color.blue)
                .frame(width: 100, height: 50)

            Circle()
                .fill(Color.white)
                .frame(width: 100, height: 50)
            
        }
    }
}


struct RectangleChartView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleChartView()
    }
}
