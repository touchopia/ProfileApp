//
//  ProfileViewController.swift
//  ProfileApp
//
//  Created by Phil Wright on 4/13/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Photo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let firstNameLabel = UILabel()
    private let firstNameTextField = UITextField()
    private let lastNameLabel = UILabel()
    private let lastNameTextField = UITextField()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let saveButton = UIButton(type: .system)
    
    private var profile: Profile
    private let imagePicker = UIImagePickerController()
    
    init() {
        // Initialize with existing profile or create new one
        if let savedProfile = ProfileManager.shared.loadProfile() {
            profile = savedProfile
        } else {
            profile = Profile(firstName: "", lastName: "", email: "", profileImageData: nil)
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .white
        setupScrollView()
        setupUI()
        populateUI()
        setupActions()
        setupImagePicker()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupUI() {
        // Profile Image
        contentView.addSubview(profileImageView)
        contentView.addSubview(changePhotoButton)
        
        // Setup labels and text fields
        [firstNameLabel, firstNameTextField, lastNameLabel, lastNameTextField, emailLabel, emailTextField, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        // Configure labels
        firstNameLabel.text = "First Name"
        lastNameLabel.text = "Last Name"
        emailLabel.text = "Email"
        
        // Configure text fields
        [firstNameTextField, lastNameTextField, emailTextField].forEach {
            $0.borderStyle = .roundedRect
            $0.backgroundColor = .systemGray6
        }
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        
        // Configure save button
        saveButton.setTitle("Save Profile", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        
        // Setup constraints
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            changePhotoButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            changePhotoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            firstNameLabel.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: 24),
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            firstNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 8),
            firstNameTextField.leadingAnchor.constraint(equalTo: firstNameLabel.leadingAnchor),
            firstNameTextField.trailingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            lastNameLabel.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 16),
            lastNameLabel.leadingAnchor.constraint(equalTo: firstNameLabel.leadingAnchor),
            lastNameLabel.trailingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor),
            
            lastNameTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8),
            lastNameTextField.leadingAnchor.constraint(equalTo: firstNameLabel.leadingAnchor),
            lastNameTextField.trailingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            emailLabel.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: firstNameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: firstNameLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: firstNameLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            
            saveButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
    
    private func populateUI() {
        // Populate fields with current profile data
        firstNameTextField.text = profile.firstName
        lastNameTextField.text = profile.lastName
        emailTextField.text = profile.email
        
        if let image = profile.profileImage {
            profileImageView.image = image
        } else {
            // Set default profile image
            profileImageView.image = UIImage(systemName: "person.circle.fill")
            profileImageView.tintColor = .gray
        }
    }
    
    private func setupActions() {
        changePhotoButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    @objc private func changePhotoTapped() {
        let actionSheet = UIAlertController(title: "Select Photo", message: "Choose a source", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
                self?.imagePicker.sourceType = .camera
                self?.present(self!.imagePicker, animated: true)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { [weak self] _ in
            self?.imagePicker.sourceType = .photoLibrary
            self?.present(self!.imagePicker, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        // Update profile with current field values
        profile.firstName = firstNameTextField.text ?? ""
        profile.lastName = lastNameTextField.text ?? ""
        profile.email = emailTextField.text ?? ""
        
        // Save profile
        ProfileManager.shared.saveProfile(profile)
        
        // Show confirmation
        let alert = UIAlertController(title: "Success", message: "Profile saved successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileImageView.image = editedImage
            profile.profileImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImageView.image = originalImage
            profile.profileImage = originalImage
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
