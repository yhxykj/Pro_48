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
        static let privacy = "https://example.com/privacy"
        static let user = "https://example.com/terms"
        static let contact = "https://example.com/contact"
        static let community = "https://example.com/community-guidelines"
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
        showWebPage(title: "Contact Us", urlString: AgreementURL.contact)
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
