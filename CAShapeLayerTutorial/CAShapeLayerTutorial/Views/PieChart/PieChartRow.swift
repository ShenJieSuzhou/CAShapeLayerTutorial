//
//  PieChartRow.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/11/5.
//

import SwiftUI

struct PieChartRow: View {
    
    var data: [Double]
    var backgroundColor: Color
    var accentColor: Color
    var slices: [PieSlice] {
        var tempSlices:[PieSlice] = []
        var lastEndDeg: Double = 0
        let maxValue = data.reduce(0, +)
        for slice in data {
            let normalized: Double = Double(slice) / Double(maxValue)
            let startDeg = lastEndDeg
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            tempSlices.append(PieSlice(startDeg: startDeg, endDeg: endDeg, value: slice, normalizedValue: normalized))
        }
        return tempSlices
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<self.slices.count) { i in
                    PieChartCell(rect: geometry.frame(in: .local), startDeg: self.slices[i].startDeg, endDeg: self.slices[i].endDeg, index: i, backgroundColor: self.backgroundColor, accentColor: self.accentColor)
                }
            }
        }
    }
}

struct PieChartRow_Previews: PreviewProvider {
    static var previews: some View {
        PieChartRow(data: [1,2,3], backgroundColor: Color.blue, accentColor: Color.white)
    }
}
