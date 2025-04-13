//
//  Profile.swift
//  ProfileApp
//
//  Created by Phil Wright on 4/13/25.
//

import UIKit

struct Profile: Codable {
    var firstName: String
    var lastName: String
    var email: String
    
    // UIImage is not Codable by default, so we'll store the image data
    var profileImageData: Data?
    
    // Helper computed property to convert between Data and UIImage
    var profileImage: UIImage? {
        get {
            if let imageData = profileImageData {
                return UIImage(data: imageData)
            }
            return nil
        }
        set {
            profileImageData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
}
