//
//  UserDefaultHelper.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import Foundation

class UserDefaultHelper {
    static func saveWithJson<T: Encodable>(_ object: T, with key: String) {
        UserDefaults.standard.set(try? JSONEncoder().encode(object), forKey: key)
    }
}
