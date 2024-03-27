//
//  SupabaseConfig.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import Foundation

class SupabaseConfig {
    static var supabaseAPIKey: String {
        return get(filename: "Supabase-Secret", key: "SUPABASE_API_KEY")
    }

    static var supabaseUrl: String {
        return get(filename: "Supabase-Secret", key: "SUPABASE_URL")
    }
    
    init() {}
    
    static private func get(filename: String, key: String) -> String {
        guard let filePath = Bundle.main.path(forResource: filename, ofType: "plist") else {
              fatalError("Couldn't find file \(filename)")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: key) as? String else {
            fatalError("Couldn't find key '\(key)' in 'Supabase-Secret.plist'.")
        }
        
        return value
    }
}
