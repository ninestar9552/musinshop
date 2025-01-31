//
//  DateFormatterManager.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/25/24.
//

import Foundation

final class DateFormatterManager {
    static let shared = DateFormatterManager()
    
    private init() {}
    
    private let cache = NSCache<NSString, DateFormatter>() // 스레드 안전한 캐시
    
    public let serverFormat: String = "yyyy-MM-dd HH:mm:ss.SSSSSS"
    public let clientFormat: String = "yyyy년 MM월 dd일 HH:mm"
    public let simpleFormat: String = "yyyy.MM.dd"
    
    func formatter(withFormat format: String) -> DateFormatter {
        if let cachedFormatter = cache.object(forKey: format as NSString) {
            return cachedFormatter
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = format
        
        cache.setObject(formatter, forKey: format as NSString)
        return formatter
    }
    
    func format(_ date: Date, withFormat format: String) -> String {
        formatter(withFormat: format).string(from: date)
    }
    
    func clientFormatted(_ date: Date) -> String {
        format(date, withFormat: clientFormat)
    }
    
    func simpleFormatted(_ date: Date) -> String {
        format(date, withFormat: simpleFormat)
    }
}

extension Date {
    
    func formatted(_ format: String) -> String {
        DateFormatterManager.shared.format(self, withFormat: format)
    }
    
    var clientFormatted: String {
        DateFormatterManager.shared.clientFormatted(self)
    }
    
    var simpleFormatted: String {
        DateFormatterManager.shared.simpleFormatted(self)
    }
}
