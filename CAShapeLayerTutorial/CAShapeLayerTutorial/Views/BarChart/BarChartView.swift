//
//  BarChartView.swift
//  CAShapeLayerTutorial
//
//  Created by shenjie on 2021/11/3.
//

import SwiftUI

struct BarChartView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    private var data: ChartData
    public var title: String
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    public var formSize: CGSize
    public var dropShadow: Bool
    public var cornerImage: Image
    public var valueSpecifier: String
    
//    @State private var touchLocation: CGFloat = -1.0
//    @State private var showValue: Bool = false
//    @State private var showLabelValue: Bool = false
//    @State private var currentValue: Double = 0 {
//        didSet {
//            if (oldValue != self.currentValue && self.showValue){
//                
//            }
//        }
//    }
    
    var isFullWidth: Bool {
        return self.formSize == ChartForm.large
    }
    
    public init(data:ChartData, title: String, style: ChartStyle = Styles.barChartStyleOrangeLight, form: CGSize? = ChartForm.medium, dropShadow: Bool? = true, cornerImage:Image? = Image(systemName: "waveform.path.ecg"), valueSpecifier: String? = "%.1f"){
        self.data = data
        self.title = title
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.barChartStyleOrangeDark
        self.formSize = form!
        self.dropShadow = dropShadow!
        self.cornerImage = cornerImage!
        self.valueSpecifier = valueSpecifier!
    }

    public var body: some View {
        ZStack{
            Rectangle()
            VStack(alignment: .leading) {
                HStack{
                    
                }
                
            }
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(data: TestData.values, title: "Test")
    }
}
