//
//  EmotionPostCell.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/2.
//

import UIKit

final class EmotionPostCell: UITableViewCell {

    static let reuseIdentifier = "EmotionPostCell"
    var onAvatarTap: (() -> Void)?
    var onAlertTap: ((UIView) -> Void)?

    private enum Asset {
        static let cardBackground = "EmotionSync/emotion_sync_post_card_background"
        static let avatarRing = "EmotionSync/emotion_sync_avatar_ring"
        static let alertIcon = "EmotionSync/emotion_sync_alert_icon"
        static let mailButton = "EmotionSync/emotion_sync_mail_button"
        static let videoButton = "EmotionSync/emotion_sync_video_button"
    }

    private let cardView = UIView()
    private let cardBackgroundView = UIImageView()
    private let avatarContainerView = UIView()
    private let avatarInitialLabel = UILabel()
    private let avatarRingView = UIImageView()
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let contentLabel = UILabel()
    private let videoButton = UIButton(type: .custom)
    private let mailButton = UIButton(type: .custom)
    private let alertImageView = UIImageView()
    private let photoStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        photoStackView.arrangedSubviews.forEach { view in
            photoStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        onAvatarTap = nil
        onAlertTap = nil
    }

    func configure(with post: EmotionPost) {
        nameLabel.text = post.name
        timeLabel.text = post.time
        contentLabel.text = post.content
        avatarContainerView.backgroundColor = post.avatarColor
        avatarInitialLabel.text = String(post.name.prefix(1))

        post.photoColors.forEach { color in
            photoStackView.addArrangedSubview(makePhotoView(color: color))
        }
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowColor = UIColor(red: 0.53, green: 0.71, blue: 0.95, alpha: 1).cgColor
        cardView.layer.shadowOpacity = 0.22
        cardView.layer.shadowRadius = 0
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        cardBackgroundView.image = UIImage(named: Asset.cardBackground)
        cardBackgroundView.contentMode = .scaleAspectFill
        cardBackgroundView.clipsToBounds = true
        cardBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(cardBackgroundView)

        avatarContainerView.layer.cornerRadius = 26
        avatarContainerView.clipsToBounds = true
        avatarContainerView.isUserInteractionEnabled = true
        avatarContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAvatarTap)))
        avatarContainerView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(avatarContainerView)

        avatarInitialLabel.font = .systemFont(ofSize: 24, weight: .bold)
        avatarInitialLabel.textColor = .white
        avatarInitialLabel.textAlignment = .center
        avatarInitialLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarContainerView.addSubview(avatarInitialLabel)

        avatarRingView.image = UIImage(named: Asset.avatarRing)
        avatarRingView.contentMode = .scaleAspectFit
        avatarRingView.isUserInteractionEnabled = true
        avatarRingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAvatarTap)))
        avatarRingView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(avatarRingView)

        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.22, alpha: 1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(nameLabel)

        timeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        timeLabel.textColor = UIColor(red: 0.45, green: 0.45, blue: 0.46, alpha: 1)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(timeLabel)

        contentLabel.numberOfLines = 2
        contentLabel.font = .systemFont(ofSize: 13, weight: .regular)
        contentLabel.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(contentLabel)

        videoButton.setImage(UIImage(named: Asset.videoButton), for: .normal)
        videoButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(videoButton)

        mailButton.setImage(UIImage(named: Asset.mailButton), for: .normal)
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(mailButton)

        alertImageView.image = UIImage(named: Asset.alertIcon)
        alertImageView.contentMode = .scaleAspectFit
        alertImageView.isUserInteractionEnabled = true
        alertImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAlertTap)))
        alertImageView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(alertImageView)

        photoStackView.axis = .horizontal
        photoStackView.spacing = 8
        photoStackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(photoStackView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 230),

            cardBackgroundView.topAnchor.constraint(equalTo: cardView.topAnchor),
            cardBackgroundView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            cardBackgroundView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            cardBackgroundView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),

            avatarContainerView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 28),
            avatarContainerView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 25),
            avatarContainerView.widthAnchor.constraint(equalToConstant: 52),
            avatarContainerView.heightAnchor.constraint(equalToConstant: 52),

            avatarInitialLabel.centerXAnchor.constraint(equalTo: avatarContainerView.centerXAnchor),
            avatarInitialLabel.centerYAnchor.constraint(equalTo: avatarContainerView.centerYAnchor),

            avatarRingView.centerXAnchor.constraint(equalTo: avatarContainerView.centerXAnchor),
            avatarRingView.centerYAnchor.constraint(equalTo: avatarContainerView.centerYAnchor),
            avatarRingView.widthAnchor.constraint(equalToConstant: 70),
            avatarRingView.heightAnchor.constraint(equalToConstant: 70),

            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 105),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 53),

            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),

            mailButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -25),
            mailButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 23),
            mailButton.widthAnchor.constraint(equalToConstant: 42),
            mailButton.heightAnchor.constraint(equalToConstant: 42),

            videoButton.trailingAnchor.constraint(equalTo: mailButton.leadingAnchor, constant: -15),
            videoButton.topAnchor.constraint(equalTo: mailButton.topAnchor),
            videoButton.widthAnchor.constraint(equalToConstant: 42),
            videoButton.heightAnchor.constraint(equalToConstant: 42),

            alertImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -25),
            alertImageView.topAnchor.constraint(equalTo: mailButton.bottomAnchor, constant: 11),
            alertImageView.widthAnchor.constraint(equalToConstant: 24),
            alertImageView.heightAnchor.constraint(equalToConstant: 24),

            contentLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 26),
            contentLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -22),
            contentLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 106),

            photoStackView.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
            photoStackView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 16),
            photoStackView.heightAnchor.constraint(equalToConstant: 63)
        ])
    }

    private func makePhotoView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "AI"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor.white.withAlphaComponent(0.82)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 84),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    @objc private func handleAvatarTap() {
        onAvatarTap?()
    }

    @objc private func handleAlertTap() {
        onAlertTap?(alertImageView)
    }

}
