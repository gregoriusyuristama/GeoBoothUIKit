//
//  SupabaseSingleton.swift
//  GeoBoothUIKit
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import Foundation
import Supabase

struct SupabaseSingleton {
    static let shared = SupabaseSingleton()
    
    var client: SupabaseClient
    
    private init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: SupabaseConfig.supabaseUrl)!,
            supabaseKey: SupabaseConfig.supabaseAPIKey
        )
    }
}
