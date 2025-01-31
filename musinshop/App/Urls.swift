//
//  Urls.swift
//  BaeknyeonSamgyetang
//
//  Created by cha on 11/5/24.
//

import Foundation

public class Hosts {
    public static let shared = Hosts()
    
    public let api: String
    
    public init(
        api: String = "http://10.112.60.173:8081"
    ) {
        self.api = api
    }
}

public class HostsDev: Hosts {
    public static let sharedDev = HostsDev()
    
    public override init(
        api: String = "http://10.112.60.173:8081"
    ) {
        super.init(api: api)
    }
}

public class Urls {
    public static var baseUrl: String {
        get {
            MsApp.shared.hosts.api
        }
    }
    
    //product
    public static let getCategoryList = "/api/user/me"
    
}
