//
//  MutualFollowCardPresenter.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/4.
//

import UIKit

extension UIViewController {

    func showMutualFollowCard(message: String, completion: (() -> Void)? = nil) {
        let cardView = MutualFollowCardView(
            title: "Mutual follow required",
            message: message,
            actionTitle: "OK",
            completion: completion
        )
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.layoutIfNeeded()
        cardView.present()
    }

}

private final class MutualFollowCardView: UIView {

    private let dimView = UIView()
    private let cardView = UIView()
    private let completion: (() -> Void)?

    init(title: String, message: String, actionTitle: String, completion: (() -> Void)?) {
        self.completion = completion
        super.init(frame: .zero)

        setupContent(title: title, message: message, actionTitle: actionTitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func present() {
        alpha = 0
        cardView.transform = CGAffineTransform(scaleX: 0.92, y: 0.92).translatedBy(x: 0, y: 18)

        UIView.animate(withDuration: 0.24, delay: 0, options: [.curveEaseOut]) {
            self.alpha = 1
            self.cardView.transform = .identity
        }
    }

    private func setupContent(title: String, message: String, actionTitle: String) {
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.28)
        dimView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dimView)

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 18
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.14
        cardView.layer.shadowRadius = 20
        cardView.layer.shadowOffset = CGSize(width: 0, height: 10)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cardView)

        let iconView = UIView()
        iconView.backgroundColor = UIColor(red: 0.82, green: 0.91, blue: 1.00, alpha: 1)
        iconView.layer.cornerRadius = 28
        iconView.layer.masksToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(iconView)

        let iconImageView = UIImageView(image: UIImage(systemName: "person.2.fill"))
        iconImageView.tintColor = UIColor(red: 0.36, green: 0.60, blue: 0.98, alpha: 1)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconView.addSubview(iconImageView)

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 21, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.08, green: 0.10, blue: 0.09, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(titleLabel)

        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.font = .systemFont(ofSize: 15, weight: .regular)
        messageLabel.textColor = UIColor(red: 0.34, green: 0.34, blue: 0.36, alpha: 1)
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(messageLabel)

        let actionButton = UIButton(type: .custom)
        actionButton.backgroundColor = UIColor(red: 0.08, green: 0.10, blue: 0.08, alpha: 1)
        actionButton.layer.cornerRadius = 13
        actionButton.layer.masksToBounds = true
        actionButton.setTitle(actionTitle, for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        actionButton.addTarget(self, action: #selector(dismissCard), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(actionButton)

        let preferredCardWidthConstraint = cardView.widthAnchor.constraint(equalToConstant: 322)
        preferredCardWidthConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: topAnchor),
            dimView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimView.bottomAnchor.constraint(equalTo: bottomAnchor),

            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 36),
            cardView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -36),
            cardView.widthAnchor.constraint(lessThanOrEqualToConstant: 322),
            preferredCardWidthConstraint,

            iconView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 26),
            iconView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 56),
            iconView.heightAnchor.constraint(equalToConstant: 56),

            iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),

            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 28),
            messageLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -28),

            actionButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            actionButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 42),
            actionButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -42),
            actionButton.heightAnchor.constraint(equalToConstant: 46),
            actionButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -26)
        ])
    }

    @objc private func dismissCard() {
        UIView.animate(withDuration: 0.18, delay: 0, options: [.curveEaseIn]) {
            self.alpha = 0
            self.cardView.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        } completion: { _ in
            self.removeFromSuperview()
            self.completion?()
        }
    }

}
