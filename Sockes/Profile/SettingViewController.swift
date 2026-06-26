//
//  SettingViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

final class SettingViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let topBackground = "EmotionSync/ShareEmotions/share_emotions_background"
    }

    private enum AgreementURL {
        static let privacy = "https://docs.google.com/document/d/16TibexJK3S2gIBSH2kmmhZJmiFa3g9NidoLbcMbS9uU/edit?usp=sharing"
        static let user = "https://docs.google.com/document/d/1tWDtDIcVpPiBa4yzI8nUohdnhzvMGbwqJ2pgWG4410E/edit?usp=sharing"
        static let community = "https://docs.google.com/document/d/15k0CgQCWHEFm2FKcYS6KkBTdkA0YQV8PqyfTygkXtdM/edit?usp=sharing"
    }

    private enum Contact {
        static let email = "MootCallsfeedback@gmail.com"
    }

    private let items = [
        "Blacklist",
        "Privacy agreement",
        "User agreement",
        "Contact Us",
        "Community Guidelines",
        "Log out",
        "Deletion of account"
    ]
    private weak var contactOverlayView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
    }

    private func setupContent() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.97, alpha: 1)

        let topBackgroundImageView = UIImageView(image: UIImage(named: Asset.topBackground))
        topBackgroundImageView.contentMode = .scaleToFill
        topBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBackgroundImageView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Setting"
        titleLabel.font = .systemFont(ofSize: 22, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 13
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        items.forEach { item in
            stackView.addArrangedSubview(makeSettingRow(title: item, action: action(for: item)))
        }

        NSLayoutConstraint.activate([
            topBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundImageView.heightAnchor.constraint(equalToConstant: 200),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            scrollView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 37),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 13),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -13),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -30),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -26)
        ])
    }

    private func makeSettingRow(title: String, action: Selector?) -> UIControl {
        let rowView = UIControl()
        rowView.backgroundColor = .white
        rowView.layer.cornerRadius = 9
        rowView.layer.masksToBounds = true
        rowView.translatesAutoresizingMaskIntoConstraints = false
        if let action {
            rowView.addTarget(self, action: action, for: .touchUpInside)
        }

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "LexendDeca-Regular", size: 16) ?? .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        rowView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            rowView.heightAnchor.constraint(equalToConstant: 70),
            titleLabel.leadingAnchor.constraint(equalTo: rowView.leadingAnchor, constant: 32),
            titleLabel.centerYAnchor.constraint(equalTo: rowView.centerYAnchor)
        ])

        return rowView
    }

    private func action(for title: String) -> Selector? {
        switch title {
        case "Blacklist":
            return #selector(showBlacklistPage)
        case "Privacy agreement":
            return #selector(showPrivacyAgreementPage)
        case "User agreement":
            return #selector(showUserAgreementPage)
        case "Contact Us":
            return #selector(showContactUsPage)
        case "Community Guidelines":
            return #selector(showCommunityGuidelinesPage)
        case "Log out":
            return #selector(logOut)
        case "Deletion of account":
            return #selector(deleteAccount)
        default:
            return nil
        }
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

    @objc private func showBlacklistPage() {
        let viewController = ProfileUserListViewController(mode: .blacklist)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @objc private func showPrivacyAgreementPage() {
        showWebPage(title: "Privacy agreement", urlString: AgreementURL.privacy)
    }

    @objc private func showUserAgreementPage() {
        showWebPage(title: "User agreement", urlString: AgreementURL.user)
    }

    @objc private func showContactUsPage() {
        showContactCard()
    }

    @objc private func showCommunityGuidelinesPage() {
        showWebPage(title: "Community Guidelines", urlString: AgreementURL.community)
    }

    private func showWebPage(title: String, urlString: String) {
        guard let url = URL(string: urlString) else {
            showSimpleAlert(title: "Unable to open this page.")
            return
        }

        let viewController = SettingWebViewController(title: title, url: url)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    private func showContactCard() {
        guard contactOverlayView == nil else { return }

        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.34)
        overlayView.alpha = 0
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        contactOverlayView = overlayView

        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 18
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.14
        cardView.layer.shadowRadius = 18
        cardView.layer.shadowOffset = CGSize(width: 0, height: 10)
        cardView.alpha = 0
        cardView.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(cardView)

        let titleLabel = UILabel()
        titleLabel.text = "Contact Us"
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(titleLabel)

        let messageLabel = UILabel()
        messageLabel.text = "Tap the email to copy it."
        messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        messageLabel.textColor = UIColor(red: 0.48, green: 0.48, blue: 0.50, alpha: 1)
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(messageLabel)

        let emailButton = UIButton(type: .custom)
        emailButton.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
        emailButton.layer.cornerRadius = 12
        emailButton.layer.masksToBounds = true
        emailButton.setTitle(Contact.email, for: .normal)
        emailButton.setTitleColor(UIColor(red: 0.08, green: 0.10, blue: 0.08, alpha: 1), for: .normal)
        emailButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        emailButton.titleLabel?.adjustsFontSizeToFitWidth = true
        emailButton.titleLabel?.minimumScaleFactor = 0.72
        emailButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        emailButton.addTarget(self, action: #selector(copyContactEmail(_:)), for: .touchUpInside)
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(emailButton)

        let copyButton = UIButton(type: .custom)
        copyButton.backgroundColor = UIColor(red: 0.07, green: 0.09, blue: 0.07, alpha: 1)
        copyButton.layer.cornerRadius = 13
        copyButton.layer.masksToBounds = true
        copyButton.setTitle("Copy Email", for: .normal)
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        copyButton.addTarget(self, action: #selector(copyContactEmail(_:)), for: .touchUpInside)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(copyButton)

        let closeButton = UIButton(type: .custom)
        closeButton.setTitle("Cancel", for: .normal)
        closeButton.setTitleColor(UIColor(red: 0.50, green: 0.50, blue: 0.52, alpha: 1), for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        closeButton.addTarget(self, action: #selector(closeContactCard), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(closeButton)

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            cardView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 34),
            cardView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -34),

            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            emailButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 22),
            emailButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 26),
            emailButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -26),
            emailButton.heightAnchor.constraint(equalToConstant: 48),

            copyButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 18),
            copyButton.leadingAnchor.constraint(equalTo: emailButton.leadingAnchor),
            copyButton.trailingAnchor.constraint(equalTo: emailButton.trailingAnchor),
            copyButton.heightAnchor.constraint(equalToConstant: 46),

            closeButton.topAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 8),
            closeButton.leadingAnchor.constraint(equalTo: copyButton.leadingAnchor),
            closeButton.trailingAnchor.constraint(equalTo: copyButton.trailingAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 42),
            closeButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20)
        ])

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut]) {
            overlayView.alpha = 1
            cardView.alpha = 1
            cardView.transform = .identity
        }
    }

    @objc private func copyContactEmail(_ sender: UIButton) {
        UIPasteboard.general.string = Contact.email

        let originalTitle = sender.currentTitle
        sender.setTitle("Copied", for: .normal)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            sender.setTitle(originalTitle, for: .normal)
        }
    }

    @objc private func closeContactCard() {
        guard let contactOverlayView else { return }

        UIView.animate(withDuration: 0.16) {
            contactOverlayView.alpha = 0
        } completion: { _ in
            contactOverlayView.removeFromSuperview()
        }
    }

    @objc private func logOut() {
        let alertController = UIAlertController(
            title: "Log out?",
            message: "Are you sure you want to log out of this account?",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Log out", style: .destructive) { [weak self] _ in
            self?.confirmLogOut()
        })
        present(alertController, animated: true)
    }

    private func confirmLogOut() {
        AuthSession.markLoggedOut()
        showLoginPage()
    }

    @objc private func deleteAccount() {
        let alertController = UIAlertController(
            title: "Delete account?",
            message: "This will clear your account data and cached content. This action cannot be undone.",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.confirmDeleteAccount()
        })
        present(alertController, animated: true)
    }

    private func confirmDeleteAccount() {
        AppCacheCleaner.clearAll { [weak self] in
            self?.showLoginPage()
        }
    }

    private func showLoginPage() {
        let loginViewController = LoginViewController()
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }

}
