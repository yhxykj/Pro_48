//
//  SignUpViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/1.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    private enum Asset {
        static let background = "Auth/login_background"
        static let backIcon = "Common/common_back_icon"
        static let nameIcon = "Auth/sign_up_name_icon"
        static let emailIcon = "Auth/login_email_icon"
        static let passwordIcon = "Auth/login_password_icon"
    }

    private let nameField = UITextField()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private weak var activeTextField: UITextField?
    private var currentKeyboardFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()

        buildSignUpPage()
        setupKeyboardDismissal()
        setupKeyboardObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
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

        configureInputField(
            nameField,
            placeholder: "Please enter yourn name",
            imageName: Asset.nameIcon,
            keyboardType: .default,
            isSecure: false
        )
        nameField.returnKeyType = .next
        view.addSubview(nameField)

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

        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("✦   Sing up   ✦", for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        signUpButton.tintColor = .white
        signUpButton.backgroundColor = UIColor(red: 0.07, green: 0.09, blue: 0.08, alpha: 1)
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
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

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func handleKeyboardWillChangeFrame(_ notification: Notification) {
        guard let activeTextField,
              let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: nil)
        currentKeyboardFrame = keyboardFrame
        updateKeyboardAvoidance(for: activeTextField, keyboardFrame: keyboardFrame, notification: notification)
    }

    @objc private func handleKeyboardWillHide(_ notification: Notification) {
        currentKeyboardFrame = nil
        animateKeyboardAvoidance(offset: 0, notification: notification)
    }

    private func updateKeyboardAvoidance(
        for textField: UITextField,
        keyboardFrame: CGRect,
        notification: Notification?
    ) {
        let fieldFrame = textField.convert(textField.bounds, to: view)
        let overlap = max(0, fieldFrame.maxY + 24 - keyboardFrame.minY)
        animateKeyboardAvoidance(offset: -overlap, notification: notification)
    }

    private func animateKeyboardAvoidance(offset: CGFloat, notification: Notification?) {
        let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let curveRawValue = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 7
        let options = UIView.AnimationOptions(rawValue: curveRawValue << 16)

        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.view.transform = CGAffineTransform(translationX: 0, y: offset)
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField

        if let currentKeyboardFrame {
            updateKeyboardAvoidance(for: textField, keyboardFrame: currentKeyboardFrame, notification: nil)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if activeTextField === textField {
            activeTextField = nil
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }

        return true
    }

    @objc private func backToLoginPage() {
        dismiss(animated: true)
    }

    @objc private func signUp() {
        guard validateSignUpInput() else { return }

        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        AuthSession.markLoggedIn(email: email)

        let tabBarController = MainTabBarController()
        view.window?.rootViewController = tabBarController
        view.window?.makeKeyAndVisible()
    }

    private func validateSignUpInput() -> Bool {
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordField.text ?? ""

        guard !name.isEmpty else {
            showSignUpMessage("Please enter your name.")
            return false
        }

        guard !email.isEmpty else {
            showSignUpMessage("Please enter your email.")
            return false
        }

        guard isValidEmail(email) else {
            showSignUpMessage("Please enter a valid email.")
            return false
        }

        guard !password.isEmpty else {
            showSignUpMessage("Please enter your password.")
            return false
        }

        return true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }

    private func showSignUpMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

}
