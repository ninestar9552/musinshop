//
//  BsLog.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/5/24.
//

import Foundation
import UIKit

/// :nodoc: 로그레벨입니다.
/// - verbose: Log type verbose
/// - info: Log type info
/// - debug: Log type debug
/// - warning: Log type warning
/// - error: Log type error
public enum LogEvent: String {
    case v = "[🔬]" // verbose
    case d = "[💬]" // debug
    case i = "[ℹ️]" // info
    case w = "[⚠️]" // warning
    case e = "[‼️]" // error
}

/// :nodoc: 로그레벨입니다.
public enum LogLevel : Int {
    case v = 0
    case d = 1
    case i = 2
    case w = 3
    case e = 4
}

/// :nodoc: BsLog 클래스 입니다.
open class BsLog {
    public static let shared = BsLog()
    
    public let maxLogs = 10
    
    var _debugLogs = [String]()
    public var debugLogs : [String] {
        get {
            return _debugLogs
        }
    }
    
    public var debugLog : String {
        get {
            if let appVersion = Foundation.Bundle.main.object(forInfoDictionaryKey:"CFBundleShortVersionString") as? String {
                return "\("==== app version: \(appVersion)\n\n\n")\(_debugLogs.joined(separator: "\n"))"
            }
            else {
                return _debugLogs.joined(separator: "\n")
            }
        }
    }
    
    public let developLoglevel : LogLevel
    public let releaseLogLevel : LogLevel
    
    public init(developLogLevel : LogLevel = LogLevel.d, releaseLogLevel: LogLevel = LogLevel.i) {
        self.developLoglevel = developLogLevel
        self.releaseLogLevel = releaseLogLevel
    }

    class var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    class var simpleDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd hh:mm:ssSSS"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    public func clearLog() {
        _debugLogs.removeAll()
    }

    public class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    class func logprint(_ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function, logEvent:LogEvent = LogEvent.e, printLogLevel: LogLevel = LogLevel.e) {
        // Only allowing in DEBUG mode
        #if DEBUG
        if (printLogLevel.rawValue >= BsLog.shared.developLoglevel.rawValue) {
            Swift.print("\(Date().toString()) \(logEvent.rawValue)[\(BsLog.sourceFileName(filePath: filename)) \(line):\(column)] \(funcName) -> \(object)")
//            let app = UIApplication.shared.delegate as! AppDelegate
//            app.logprint(log: "\(Date().toString()) \(logEvent.rawValue)[\(BsLog.sourceFileName(filePath: filename)) \(line):\(column)] -> \(object)")
        }
        #endif
        
        if MsApp.shared.isLoggingEnable {
            if (printLogLevel.rawValue >= BsLog.shared.releaseLogLevel.rawValue) {
                if (BsLog.shared._debugLogs.count >= BsLog.shared.maxLogs) {
                    BsLog.shared._debugLogs.removeFirst()
                }
                
                BsLog.shared._debugLogs.append("\(Date().toSimpleString()) \(logEvent.rawValue) -> \(object)")
            }
        }
    }
    
    public class func v( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logprint(object, filename: filename, line: line, column: column, funcName: funcName, logEvent: LogEvent.v, printLogLevel: LogLevel.v)
    }
    
    public class func d( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logprint(object, filename: filename, line: line, column: column, funcName: funcName, logEvent: LogEvent.d, printLogLevel: LogLevel.d)
    }
    
    public class func i( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logprint(object, filename: filename, line: line, column: column, funcName: funcName, logEvent: LogEvent.i, printLogLevel: LogLevel.i)
    }
    
    public class func w( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logprint(object, filename: filename, line: line, column: column, funcName: funcName, logEvent: LogEvent.w, printLogLevel: LogLevel.w)
    }
    
    public class func e( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        logprint(object, filename: filename, line: line, column: column, funcName: funcName, logEvent: LogEvent.e, printLogLevel: LogLevel.e)
    }
}

extension Date {
    public func toString() -> String {
        return BsLog.dateFormatter.string(from: self as Date)
    }
    
    public func toSimpleString() -> String {
        return BsLog.simpleDateFormatter.string(from: self as Date)
    }
}


