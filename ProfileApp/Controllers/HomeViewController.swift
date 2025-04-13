//
//  HomeViewController.swift
//  ProfileApp
//
//  Created by Phil Wright on 4/13/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    var label: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
    }
    
    private func setupUI() {
        
        label.removeFromSuperview()
        
        // start with new user
        var profile = Profile(firstName: "New", lastName: "User", email: "", profileImageData: nil)
    
        // Initialize with existing profile or create new one
        if let savedProfile = ProfileManager.shared.loadProfile() {
            profile = savedProfile
        } else {
            profile = Profile(firstName: "", lastName: "", email: "", profileImageData: nil)
        }
        
        label.frame.origin = CGPoint(x: 20, y: 100)
        
        label.text = "Welcome \(profile.firstName) \(profile.lastName)"
        
        label.textAlignment = .center

        view.addSubview(label)
        
        label.sizeToFit()
    }
    
    
}


