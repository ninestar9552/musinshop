//
//  CommonTextStyle.swift
//  musinshop
//
//  Created by cha on 2/5/25.
//

import SwiftUI

struct DiscountLabelView: View {
    var price: Int
    var discountRate: Double?    
    var textSize: CGFloat = 13
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // 할인률
            if let discountRate = discountRate, discountRate != 0 {
                
                Text("\(discountRate.toPercentageString())")
                    .font(.system(size: textSize, weight: .bold))
                    .foregroundColor(Color(hex: "F31110"))
                    .padding(.trailing, 2)
            }
            
            let discountedPrice = Int(Double(price)*Double(1-(discountRate ?? 0)))
            Text(
                "\(discountedPrice.stringWithComma)원"
            )
            .font(.system(size: textSize, weight: .bold))
            .foregroundColor(.black)
        }
    }
}

#Preview {
    DiscountLabelView(price: 239100, discountRate: 0.32)
}
