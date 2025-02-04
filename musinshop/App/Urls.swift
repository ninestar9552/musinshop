//
//  Urls.swift
//  musinshop
//
//  Created by cha on 11/5/24.
//

import Foundation

public class Hosts {
    public static let shared = Hosts()
    
    public let api: String
    
    public init(
        api: String = "http://10.112.58.113:8000"
    ) {
        self.api = api
    }
}

public class HostsDev: Hosts {
    public static let sharedDev = HostsDev()
    
    public override init(
        api: String = "http://10.112.58.113:8000"
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
    public static let getCategoryList = "/api/category/list"
    public static let getProductList = "/api/item/list"
    public static let getProductDetail = "/api/item/get"
    
}
