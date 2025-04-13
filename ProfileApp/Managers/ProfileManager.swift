//
//  ProfileManager.swift
//  ProfileApp
//
//  Created by Phil Wright on 4/13/25.
//

import UIKit

class ProfileManager {
    
    static let shared = ProfileManager()
    
    private let profileKey = "userProfile"
    
    private init() {}
    
    func saveProfile(_ profile: Profile) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(profile)
            UserDefaults.standard.set(data, forKey: profileKey)
        } catch {
            print("Failed to save profile: \(error)")
        }
    }
    
    func loadProfile() -> Profile? {
        guard let data = UserDefaults.standard.data(forKey: profileKey) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Profile.self, from: data)
        } catch {
            print("Failed to load profile: \(error)")
            return nil
        }
    }
}
