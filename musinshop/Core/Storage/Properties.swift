//
//  Properties.swift
//  musinshop
//
//  Created by cha on 11/5/24.
//

import Foundation

public class Properties {
    
    public static func saveCodable<T: Codable>(key: String, data:T?) {
        if let encoded = try? JSONEncoder().encode(data) {
            BsLog.d("save-plain : \(encoded as NSData)")
            guard let crypted = BsCrypto.shared.encrypt(data: encoded) else { return }
            BsLog.d("save-crypted : \(crypted as NSData)")
            UserDefaults.standard.set(crypted, forKey:key)
            UserDefaults.standard.synchronize()
        }
    }
    
    public static func loadCodable<T: Codable>(key: String) -> T? {
        if let data = UserDefaults.standard.data(forKey: key) {
            BsLog.d("load-crypted : \(data as NSData)")
            guard let plain = BsCrypto.shared.decrypt(data: data) else { return nil }
            BsLog.d("load-plain : \(plain as NSData)")
            return try? JSONDecoder().decode(T.self, from:plain)
        }
        return nil
    }
    
    public static func delete(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func save(key: String, string:String?) {
        UserDefaults.standard.set(string, forKey:key)
        UserDefaults.standard.synchronize()
    }
    
    static func load(key: String) -> String? {
        UserDefaults.standard.string(forKey:key)
    }
}
