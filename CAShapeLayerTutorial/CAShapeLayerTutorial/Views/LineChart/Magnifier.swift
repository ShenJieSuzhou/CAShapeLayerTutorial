//
//  Magnifier.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/11/9.
//

import SwiftUI

struct Magnifier: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var currentNumer: Double
    var valueSpecifer: String
    
    var body: some View {
        ZStack {
            Text("\(self.currentNumer, specifier: valueSpecifer)")
                .font(.system(size: 18, weight: .bold, design: .default))
                .offset(x: 0, y: -110)
                .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
            if self.colorScheme == .dark {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: self.colorScheme == .dark ? 2 : 0)
                    .frame(width: 60, height: 260, alignment: .center)
            }else {
                RoundedRectangle(cornerRadius: 16)
                    .shadow(color: Colors.LegendText, radius: 12, x: 0, y: 6)
                    .foregroundColor(Color.white)
                    .blendMode(.multiply)
                    .frame(width: 60, height: 260, alignment: .center)
            }
        }
    }
}


