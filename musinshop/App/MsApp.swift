//
//  BsApp.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/5/24.
//

import Foundation


final public class MsApp {
    
    public static let shared = MsApp()
    
    private static var isDevelop: Bool = false
    public static var isRelease: Bool {
        get {
            #if DEBUG
            print("isRelease 전처리문 DEBUG & isDevelop = \(isDevelop) // isRelease = \(!isDevelop)")
            return !isDevelop
            #else
            print("isRelease 전처리문 NOT DEBUG // isRelease = true")
            return true
            #endif
        }
    }
    
    private var _loggingEnable : Bool = !isRelease
    private var _hosts : Hosts? = nil
    
    private init() {
        _loggingEnable = !MsApp.isRelease
        _hosts = MsApp.isRelease ? Hosts.shared : HostsDev.sharedDev
    }
    
    
    /// 초기화 시 지정한 loggingEnable
    /// - seealso: `PodLog`
    public var isLoggingEnable: Bool {
        get {
            _loggingEnable
        }
    }
    
    public var hosts: Hosts {
        get {
            _hosts != nil ? _hosts! : (MsApp.isRelease ? Hosts.shared : HostsDev.sharedDev)
        }
    }
}
