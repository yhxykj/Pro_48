//
//  SignUpViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/1.
//

import UIKit

class SignUpViewController: UIViewController {

    private enum Asset {
        static let background = "Auth/login_background"
        static let backIcon = "Common/common_back_icon"
        static let nameIcon = "Auth/sign_up_name_icon"
        static let emailIcon = "Auth/login_email_icon"
        static let passwordIcon = "Auth/login_password_icon"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildSignUpPage()
    }

    private func buildSignUpPage() {
        view.backgroundColor = .white

        let backgroundView = UIImageView(image: UIImage(named: Asset.background))
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(backToLoginPage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let taglineLabel = UILabel()
        taglineLabel.text = "Community we all need"
        taglineLabel.font = .systemFont(ofSize: 12, weight: .regular)
        taglineLabel.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        taglineLabel.textAlignment = .center
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(taglineLabel)

        let titleLabel = UILabel()
        titleLabel.text = "Sing Up"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Enter your email and name"
        subtitleLabel.font = .systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)

        let nameField = makeInputField(
            placeholder: "Please enter yourn name",
            imageName: Asset.nameIcon,
            keyboardType: .default,
            isSecure: false
        )
        view.addSubview(nameField)

        let emailField = makeInputField(
            placeholder: "Please enter your email",
            imageName: Asset.emailIcon,
            keyboardType: .emailAddress,
            isSecure: false
        )
        view.addSubview(emailField)

        let passwordField = makeInputField(
            placeholder: "Please enter your Password",
            imageName: Asset.passwordIcon,
            keyboardType: .default,
            isSecure: true
        )
        view.addSubview(passwordField)

        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("✦   Sing up   ✦", for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        signUpButton.tintColor = .white
        signUpButton.backgroundColor = UIColor(red: 0.07, green: 0.09, blue: 0.08, alpha: 1)
        signUpButton.layer.cornerRadius = 10
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)

        let loginPromptLabel = UILabel()
        loginPromptLabel.text = "Already have an account?"
        loginPromptLabel.font = .systemFont(ofSize: 12, weight: .regular)
        loginPromptLabel.textColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1)
        loginPromptLabel.translatesAutoresizingMaskIntoConstraints = false

        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Log in ▶", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        loginButton.tintColor = UIColor(red: 0.73, green: 0.84, blue: 1, alpha: 1)
        loginButton.addTarget(self, action: #selector(backToLoginPage), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        let loginStack = UIStackView(arrangedSubviews: [loginPromptLabel, loginButton])
        loginStack.axis = .horizontal
        loginStack.spacing = 14
        loginStack.alignment = .center
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginStack)

        let contentGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            backButton.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: contentGuide.topAnchor, constant: 14),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            taglineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taglineLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 241),

            titleLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 23),
            titleLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 49),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),

            nameField.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor, constant: 23),
            nameField.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor, constant: -23),
            nameField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            nameField.heightAnchor.constraint(equalToConstant: 58),

            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.heightAnchor.constraint(equalTo: nameField.heightAnchor),

            passwordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.heightAnchor.constraint(equalTo: nameField.heightAnchor),

            signUpButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24),
            signUpButton.heightAnchor.constraint(equalToConstant: 58),

            loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginStack.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30)
        ])
    }

    private func makeInputField(
        placeholder: String,
        imageName: String,
        keyboardType: UIKeyboardType,
        isSecure: Bool
    ) -> UITextField {
        let field = UITextField()
        field.borderStyle = .none
        field.backgroundColor = .white
        field.keyboardType = keyboardType
        field.isSecureTextEntry = isSecure
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

        return field
    }

    @objc private func backToLoginPage() {
        dismiss(animated: true)
    }

}
