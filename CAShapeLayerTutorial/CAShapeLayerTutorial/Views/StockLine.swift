//
//  StockLine.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/9/18.
//

import SwiftUI

struct StockLine: View {
    var data: [Double]
    var title: String?
    var price: String?
    
    init(data: [Double], title: String? = nil, price: String? = nil) {
        self.data = data
        self.title = title
        self.price = price
    }
    
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Group{
                    
                }
            })
        }
        
    }
}

//struct Line: View {
//
//}

//struct StockLine_Previews: PreviewProvider {
//    static var previews: some View {
////        StockLine()
//    }
//}
