//
//  LoginViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/1.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    private enum Asset {
        static let background = "Auth/login_background"
        static let emailIcon = "Auth/login_email_icon"
        static let passwordIcon = "Auth/login_password_icon"
        static let rememberSwitch = "Auth/login_remember_switch"
    }

    private enum TestAccount {
        static let email = "sockes333@gmail.com"
        static let password = "333333"
    }

    private let emailField = UITextField()
    private let passwordField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        buildLoginPage()
        setupKeyboardDismissal()
    }

    private func buildLoginPage() {
        view.backgroundColor = .white

        let backgroundView = UIImageView(image: UIImage(named: Asset.background))
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)

        let taglineLabel = UILabel()
        taglineLabel.text = "Community we all need"
        taglineLabel.font = .systemFont(ofSize: 12, weight: .regular)
        taglineLabel.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        taglineLabel.textAlignment = .center
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(taglineLabel)

        let titleLabel = UILabel()
        titleLabel.text = "Login"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Enter your email and password"
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)

        configureInputField(
            emailField,
            placeholder: "Please enter your email",
            imageName: Asset.emailIcon,
            keyboardType: .emailAddress,
            isSecure: false
        )
        emailField.returnKeyType = .next
        view.addSubview(emailField)

        configureInputField(
            passwordField,
            placeholder: "Please enter your Password",
            imageName: Asset.passwordIcon,
            keyboardType: .default,
            isSecure: true
        )
        passwordField.returnKeyType = .done
        view.addSubview(passwordField)

        let rememberButton = UIButton(type: .custom)
        rememberButton.setImage(UIImage(named: Asset.rememberSwitch), for: .normal)
        rememberButton.imageView?.contentMode = .scaleAspectFit
        rememberButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rememberButton)

        let rememberLabel = UILabel()
        rememberLabel.text = "Remember"
        rememberLabel.font = .systemFont(ofSize: 12, weight: .regular)
        rememberLabel.textColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1)
        rememberLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rememberLabel)

        let loginButton = UIButton(type: .system)
        loginButton.setTitle("✦   Log in   ✦", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        loginButton.tintColor = .white
        loginButton.backgroundColor = UIColor(red: 0.07, green: 0.09, blue: 0.08, alpha: 1)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(showMainTabBar), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)

        let signupPromptLabel = UILabel()
        signupPromptLabel.text = "Don't have an account?"
        signupPromptLabel.font = .systemFont(ofSize: 12, weight: .regular)
        signupPromptLabel.textColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1)
        signupPromptLabel.translatesAutoresizingMaskIntoConstraints = false

        let signupButton = UIButton(type: .system)
        signupButton.setTitle("Signup", for: .normal)
        signupButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        signupButton.tintColor = UIColor(red: 0.73, green: 0.84, blue: 1, alpha: 1)
        signupButton.addTarget(self, action: #selector(showSignUpPage), for: .touchUpInside)
        signupButton.translatesAutoresizingMaskIntoConstraints = false

        let signupStack = UIStackView(arrangedSubviews: [signupPromptLabel, signupButton])
        signupStack.axis = .horizontal
        signupStack.spacing = 14
        signupStack.alignment = .center
        signupStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupStack)

        let contentGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            taglineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taglineLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 241),

            titleLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 23),
            titleLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 49),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),

            emailField.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 23),
            emailField.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor, constant: -23),
            emailField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            emailField.heightAnchor.constraint(equalToConstant: 58),

            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor),

            rememberButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            rememberButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 14),
            rememberButton.widthAnchor.constraint(equalToConstant: 48),
            rememberButton.heightAnchor.constraint(equalToConstant: 24),

            rememberLabel.leadingAnchor.constraint(equalTo: rememberButton.trailingAnchor, constant: 10),
            rememberLabel.centerYAnchor.constraint(equalTo: rememberButton.centerYAnchor),

            loginButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            loginButton.topAnchor.constraint(equalTo: rememberButton.bottomAnchor, constant: 24),
            loginButton.heightAnchor.constraint(equalToConstant: 58),

            signupStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupStack.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30)
        ])
    }

    private func configureInputField(
        _ field: UITextField,
        placeholder: String,
        imageName: String,
        keyboardType: UIKeyboardType,
        isSecure: Bool
    ) {
        field.borderStyle = .none
        field.backgroundColor = .white
        field.keyboardType = keyboardType
        field.isSecureTextEntry = isSecure
        field.delegate = self
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.font = .systemFont(ofSize: 14, weight: .regular)
        field.textColor = .black
        field.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1),
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
        )
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1).cgColor
        field.translatesAutoresizingMaskIntoConstraints = false

        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: 71, height: 58))
        let iconView = UIImageView(image: UIImage(named: imageName))
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 23, y: 14, width: 30, height: 30)
        iconContainer.addSubview(iconView)
        field.leftView = iconContainer
        field.leftViewMode = .always
    }

    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }

    @objc private func showSignUpPage() {
        let signUpViewController = SignUpViewController()
        signUpViewController.modalPresentationStyle = .fullScreen
        present(signUpViewController, animated: true)
    }

    @objc private func showMainTabBar() {
        guard validateLoginInput() else { return }

        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        AuthSession.markLoggedIn(email: email)

        let tabBarController = MainTabBarController()
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }

    private func validateLoginInput() -> Bool {
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordField.text ?? ""

        guard !email.isEmpty else {
            showLoginMessage("Please enter your email.")
            return false
        }

        guard isValidEmail(email) else {
            showLoginMessage("Please enter a valid email.")
            return false
        }

        guard !password.isEmpty else {
            showLoginMessage("Please enter your password.")
            return false
        }

        return true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }

    private func showLoginMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

}
