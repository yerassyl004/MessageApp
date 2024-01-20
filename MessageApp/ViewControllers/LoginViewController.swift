//
//  LoginViewController.swift
//  MessageApp
//
//  Created by Ерасыл Еркин on 15.01.2024.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
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
    
    private let emailField: UITextField = {
        let text = UITextField()
        text.placeholder = "Email"
        text.borderStyle = .none
        text.keyboardType = .emailAddress
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        text.returnKeyType = .continue
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
        text.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        text.returnKeyType = .continue
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        text.leftViewMode = .always
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let loginText: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let informationText: UILabel = {
        let label = UILabel()
        label.text = "Please sign in to continue."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemOrange
        button.titleLabel?.textAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let forgotPasswordText: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor.lightGray
        label.isUserInteractionEnabled = true
        let attributedText = NSMutableAttributedString(string: "Don't have an account? Sign up")
        let range = (attributedText.string as NSString).range(of: "Sign up")
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
        
        stackView.addArrangedSubview(loginText)
        NSLayoutConstraint.activate([
            loginText.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 150),
            loginText.heightAnchor.constraint(equalToConstant: 50),
            loginText.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 30),
        ])
        
        stackView.addArrangedSubview(informationText)
        NSLayoutConstraint.activate([
            informationText.heightAnchor.constraint(equalToConstant: 25),
            informationText.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 30),
        ])
        
        stackView.addArrangedSubview(emailField)
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: fieldHeight),
            emailField.widthAnchor.constraint(equalToConstant: fieldWidth),
            emailField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: (screenWidth - fieldWidth)/2),
        ])
        stackView.addArrangedSubview(passwordField)
        NSLayoutConstraint.activate([
            passwordField.heightAnchor.constraint(equalToConstant: fieldHeight),
            passwordField.widthAnchor.constraint(equalToConstant: fieldWidth),
            passwordField.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: (screenWidth - fieldWidth)/2),
        ])
        stackView.addArrangedSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: fieldHeight),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: (screenWidth * 0.9) - 150),
        ])
        
        view.addSubview(forgotPasswordText)
        NSLayoutConstraint.activate([
            forgotPasswordText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            forgotPasswordText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: screenWidth * 0.2),
        ])
        
        let underlinePassword = CALayer()
        underlinePassword.backgroundColor = UIColor.lightGray.cgColor
        passwordField.layer.addSublayer(underlinePassword)
        underlinePassword.frame = CGRect(x: 0, y: fieldHeight - 1, width: fieldWidth, height: 1)
        
        let underlineEmail = CALayer()
        underlineEmail.backgroundColor = UIColor.lightGray.cgColor
        emailField.layer.addSublayer(underlineEmail)
        underlineEmail.frame = CGRect(x: 0, y: fieldHeight - 1, width: fieldWidth, height: 1)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signInTapped))
        forgotPasswordText.addGestureRecognizer(tapGesture)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty else {
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { AuthDataResult, error in
            guard let result = AuthDataResult, error == nil else {
                print("Error email or password")
                self.alertUserErrorAction()
                return
            }
            
            print(result)
            print("Logged")
            self.dismiss(animated: false)
        })
    }
    
    func alertUserErrorAction() {
        let alert = UIAlertController(title: "Woops",
                                      message: "Please enter all information to log in",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    @objc func signInTapped() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}
