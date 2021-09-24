//
//  PieChartView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/9/24.
//

import Foundation
import SwiftUI

struct PieChartView: View {
    public var body: some View{
        ZStack(alignment: .center, content: {
            Path(){ path in
                path.move(to: CGPoint(x: 200, y: 200))
                path.addArc(center: CGPoint(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 90), clockwise: true)
            }
            .fill(Color.green)
            Path(){ path in
                path.move(to: CGPoint(x: 200, y: 500))
                path.addArc(center: CGPoint(x: 200, y: 500), radius: 150, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 190), clockwise: true)
            }
            .fill(Color(.systemYellow))
            Path(){ path in
                path.move(to: CGPoint(x: 200, y: 500))
                path.addArc(center: CGPoint(x: 200, y: 500), radius: 150, startAngle: Angle(degrees: 190.0), endAngle: Angle(degrees: 110), clockwise: true)
            }
            .fill(Color(.systemTeal))
            Path(){ path in
                path.move(to: CGPoint(x: 200, y: 500))
                path.addArc(center: CGPoint(x: 200, y: 500), radius: 150, startAngle: Angle(degrees: 110.0), endAngle: Angle(degrees: 90), clockwise: true)
            }
            .fill(Color(.systemBlue))
            Path(){ path in
                path.move(to: CGPoint(x: 200, y: 500))
                path.addArc(center: CGPoint(x: 200, y: 500), radius: 150, startAngle: Angle(degrees: 90.0), endAngle: Angle(degrees: 360), clockwise: true)
            }
            .fill(Color(.systemPurple))
            .offset(x: 20, y: 20)
            
            Path { path in
                path.move(to: CGPoint(x: 200, y: 500))
                path.addArc(center: .init(x: 200, y: 500), radius: 150, startAngle: Angle(degrees: 90.0), endAngle: Angle(degrees: 360), clockwise: true)
                path.closeSubpath()
            }
            .stroke(Color(red: 52/255, green: 52/255, blue: 122/255), lineWidth: 10)
            .offset(x: 20, y: 20)
            .overlay(
                Text("25%")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .offset(x: 80, y: 180)
            )
        })
//        Spacer()
//        ZStack(alignment: .center, content: {
//            Path(){ path in
//                path.move(to: CGPoint(x: 200, y: 300))
//                path.addArc(center: CGPoint(x: 200, y: 300), radius: 150, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 190), clockwise: true)
//            }
//            .fill(Color(.systemYellow))
//            Path(){ path in
//                path.move(to: CGPoint(x: 200, y: 500))
//                path.addArc(center: CGPoint(x: 200, y: 500), radius: 150, startAngle: Angle(degrees: 190.0), endAngle: Angle(degrees: 110), clockwise: true)
//            }
//            .fill(Color(.systemTeal))
//            Path(){ path in
//                path.move(to: CGPoint(x: 200, y: 500))
//                path.addArc(center: CGPoint(x: 200, y: 500), radius: 150, startAngle: Angle(degrees: 110.0), endAngle: Angle(degrees: 90), clockwise: true)
//            }
//            .fill(Color(.systemBlue))
//            Path(){ path in
//                path.move(to: CGPoint(x: 200, y: 500))
//                path.addArc(center: CGPoint(x: 200, y: 500), radius: 150, startAngle: Angle(degrees: 90.0), endAngle: Angle(degrees: 360), clockwise: true)
//            }
//            .fill(Color(.systemPurple))
//        })
    }
}
