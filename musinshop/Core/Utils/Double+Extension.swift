//
//  Double+Extension.swift
//  musinshop
//
//  Created by cha on 2/4/25.
//

extension Double {
    /// Double 값을 100을 곱한 뒤 정수로 반올림하고, 뒤에 %를 붙여 String으로 반환합니다.
    func toPercentageString() -> String {
        let multipliedValue = self * 100 // 100을 곱함
        let roundedValue = multipliedValue.rounded() // 반올림
        let integerValue = Int(roundedValue) // 정수로 변환
        return "\(integerValue)%" // %를 붙여 String으로 반환
    }
}
