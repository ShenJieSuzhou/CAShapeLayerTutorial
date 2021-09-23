//
//  TestView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/9/18.
//

import Foundation
import SwiftUI

struct TestView: View {
    
    public var body: some View {
        ZStack(alignment: .center, content: {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .fill(Color.gray)
                .frame(width: 200, height: 200, alignment: .center)
                .shadow(color: Color.orange, radius: 8)
            ZStack(alignment: .leading, content: {
               Text("这是一根线")
            })
            Spacer()
            GeometryReader(content: { geometry in
                TestLine()
            })
            .frame(width: 200, height: 200, alignment: .center)
            .offset(x: 0, y: 0)
        })
    }
}

struct TestLine: View {
    private func controlPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
        var controlPoint = midPointForPoints(p1:p1, p2:p2)
        let diffY = abs(p2.y - controlPoint.y)
        
        if (p1.y < p2.y){
            controlPoint.y += diffY
        } else if (p1.y > p2.y) {
            controlPoint.y -= diffY
        }
        return controlPoint
    }
    
    private func midPointForPoints(p1:CGPoint, p2:CGPoint) -> CGPoint {
        return CGPoint(x:(p1.x + p2.x) / 2,y: (p1.y + p2.y) / 2)
    }
    
    private func quadCurvedPathWithPoints(points:[Double], step:CGFloat, globalOffset: Double? = nil) -> Path {
        var path = Path()
        if (points.count < 2){
            return path
        }

        let p1 = CGPoint(x: 0, y: points[0])
        path.move(to: p1)
        for pointIndex in 1..<points.count {
            let p2 = CGPoint(x: step * CGFloat(pointIndex), y: CGFloat(points[pointIndex]))
            path.addLine(to: p2)
//            let midPoint = midPointForPoints(p1: p1, p2: p2)
//            path.addQuadCurve(to: midPoint, control: controlPointForPoints(p1: midPoint, p2: p1))
//            path.addQuadCurve(to: p2, control: controlPointForPoints(p1: midPoint, p2: p2))
//            p1 = p2
        }
        return path
    }
    
//    var path: Path {
//        let points = [100.0, 180.0, 15.0, 30.0, 18.0, 80.0, 12.0]
//        return quadCurvedPathWithPoints(points: points, step: 20, globalOffset: 0.0)
//    }
    
    public var body: some View {
        ZStack(alignment: .center, content: {
            ZStack(alignment: .center, content: {
                Path(){ path in
                    path.move(to: CGPoint(x: 20, y: 60))
                    path.addLine(to: CGPoint(x: 40, y: 60))
                    path.addLine(to: CGPoint(x: 60, y: 30))
                    path.addLine(to: CGPoint(x: 80, y: 160))
                    path.addLine(to: CGPoint(x: 100, y: 20))
                    path.addLine(to: CGPoint(x: 120, y: 100))
                    path.addLine(to: CGPoint(x: 140, y: 120))
                    path.addLine(to: CGPoint(x: 160, y: 70))
                    path.addLine(to: CGPoint(x: 180, y: 10))
                }
                .stroke(Color.blue, lineWidth: 10)
            })
        })
    }
}
