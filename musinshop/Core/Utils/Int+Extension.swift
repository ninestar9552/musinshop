//
//  Int+Extension.swift
//  musinshop
//
//  Created by cha on 2/5/25.
//

import Foundation

extension Int {
    // 쉼표 없이 숫자를 문자열로 변환
    var stringWithoutComma: String {
        return String(self)
    }
    
    // 3자리마다 쉼표를 찍어 문자열로 변환 (한국 원화 표시 방식)
    var stringWithComma: String {
        print("얼마에요? 0: \(self)")
        let number = NSNumber(value: self)
        print("얼마에요? 1: \(number)")
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "," // 쉼표로 구분
        formatter.groupingSize = 3 // 3자리마다 구분
        formatter.locale = Locale(identifier: "ko_KR")
        let result = formatter.string(from: number) ?? String(self)
        print("얼마에요? 2: \(result)")
        return result
    }
}
