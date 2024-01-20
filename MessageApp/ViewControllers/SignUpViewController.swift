//
//  SignUpViewController.swift
//  MessageApp
//
//  Created by Ерасыл Еркин on 15.01.2024.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.alwaysBounceVertical = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let fullNameField: UITextField = {
        let text = UITextField()
        text.placeholder = "FullName"
        text.borderStyle = .none
        text.keyboardType = .emailAddress
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.returnKeyType = .continue
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        text.leftViewMode = .always
        text.backgroundColor = .white
        text.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        text.layer.cornerRadius = 8.0 // Adjust the corner radius as needed
        text.layer.borderWidth = 1.0
        text.layer.borderColor = UIColor.white.cgColor
        
        // Add shadow
        text.layer.shadowColor = UIColor.lightGray.cgColor
        text.layer.shadowOpacity = 0.5
        text.layer.shadowOffset = CGSize(width: 0, height: 2)
        text.layer.shadowRadius = 6.0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let emailField: UITextField = {
        let text = UITextField()
        text.placeholder = "Email"
        text.borderStyle = .none
        text.keyboardType = .emailAddress
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.returnKeyType = .continue
        text.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private let passwordField: UITextField = {
        let text = UITextField()
        text.placeholder = "Password"
        text.borderStyle = .none
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.returnKeyType = .continue
        text.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        text.leftViewMode = .always
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private let confirmPasswordField: UITextField = {
        let text = UITextField()
        text.placeholder = "Confirm password"
        text.borderStyle = .none
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        text.returnKeyType = .continue
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        text.leftViewMode = .always
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let signUpText: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sing Up", for: .normal)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemOrange
        button.titleLabel?.textAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signInText: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor.lightGray
        label.isUserInteractionEnabled = true
        let attributedText = NSMutableAttributedString(string: "Already have a account? Sign in")
        let range = (attributedText.string as NSString).range(of: "Sign in")
        attributedText.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: range)
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupViews()
    }
    
    func setupViews() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let fieldWidth = screenWidth * 0.8
        let fieldHeight = screenHeight * 0.06
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        stackView.addArrangedSubview(signUpText)
        stackView.addArrangedSubview(fullNameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(confirmPasswordField)
        stackView.addArrangedSubview(signUpButton)
        stackView.addArrangedSubview(signInText)
        NSLayoutConstraint.activate([
            signUpText.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 100),
            signUpText.heightAnchor.constraint(equalToConstant: 80),
            signUpText.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 30),
            
            fullNameField.heightAnchor.constraint(equalToConstant: fieldHeight),
            fullNameField.widthAnchor.constraint(equalToConstant: fieldWidth),
            fullNameField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: (screenWidth - fieldWidth)/2),
            
            emailField.heightAnchor.constraint(equalToConstant: fieldHeight),
            emailField.widthAnchor.constraint(equalToConstant: fieldWidth),
            emailField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: (screenWidth - fieldWidth)/2),
            
            passwordField.heightAnchor.constraint(equalToConstant: fieldHeight),
            passwordField.widthAnchor.constraint(equalToConstant: fieldWidth),
            passwordField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: (screenWidth - fieldWidth)/2),
            
            confirmPasswordField.heightAnchor.constraint(equalToConstant: fieldHeight),
            confirmPasswordField.widthAnchor.constraint(equalToConstant: fieldWidth),
            confirmPasswordField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: (screenWidth - fieldWidth)/2),
            
            signUpButton.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: (screenWidth * 0.9) - 150),
            signUpButton.heightAnchor.constraint(equalToConstant: fieldHeight),
            signUpButton.widthAnchor.constraint(equalToConstant: 150),
        ])
        
        view.addSubview(signInText)
        NSLayoutConstraint.activate([
            signInText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
        
        let underlinePassword = CALayer()
        underlinePassword.backgroundColor = UIColor.lightGray.cgColor
        passwordField.layer.addSublayer(underlinePassword)
        underlinePassword.frame = CGRect(x: 0, y: fieldHeight - 1, width: fieldWidth, height: 1)
        
        let underlinePasswordConfirm = CALayer()
        underlinePasswordConfirm.backgroundColor = UIColor.lightGray.cgColor
        confirmPasswordField.layer.addSublayer(underlinePasswordConfirm)
        underlinePasswordConfirm.frame = CGRect(x: 0, y: fieldHeight - 1, width: fieldWidth, height: 1)
        
        let underlineEmail = CALayer()
        underlineEmail.backgroundColor = UIColor.lightGray.cgColor
        emailField.layer.addSublayer(underlineEmail)
        underlineEmail.frame = CGRect(x: 0, y: fieldHeight - 1, width: fieldWidth, height: 1)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signInTapped))
        signInText.addGestureRecognizer(tapGesture)
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func signUpButtonTapped() {
        fullNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, let confirmPassword = confirmPasswordField.text , let fullName = fullNameField.text, !fullName.isEmpty , !email.isEmpty, !password.isEmpty, password.count >= 6, password == confirmPassword else {
            alertUserErrorAction()
            return
        }
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error  in
            guard let result = authResult, error == nil else {
                print("Error curenting user")
                return
            }
            let user = result.user
            print(user)
        })
    }
    
    func alertUserErrorAction() {
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to create a new account", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc func signInTapped() {
        LoginViewController().modalPresentationStyle = .fullScreen
            dismiss(animated: false)
    }
}
