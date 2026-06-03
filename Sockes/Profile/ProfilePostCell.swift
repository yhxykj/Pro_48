//
//  ProfilePostCell.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

final class ProfilePostCell: UITableViewCell {

    static let reuseIdentifier = "ProfilePostCell"

    private enum Asset {
        static let cardBackground = "Profile/profile_post_card_background"
        static let avatarRing = "EmotionSync/emotion_sync_avatar_ring"
        static let deleteIcon = "Profile/profile_post_delete_icon"
    }

    private let avatarView = UIView()
    private let avatarLabel = UILabel()
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let contentLabel = UILabel()
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
    }

    func configure(with post: ProfilePost) {
        avatarView.backgroundColor = post.avatarColor
        avatarLabel.text = String(post.name.prefix(1))
        nameLabel.text = post.name
        timeLabel.text = post.time
        contentLabel.text = post.content

        post.photoColors.prefix(2).forEach { color in
            photoStackView.addArrangedSubview(makePostPhotoView(color: color))
        }
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowColor = UIColor(red: 0.53, green: 0.71, blue: 0.95, alpha: 1).cgColor
        cardView.layer.shadowOpacity = 0.22
        cardView.layer.shadowRadius = 0
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        let cardBackgroundView = UIImageView(image: UIImage(named: Asset.cardBackground))
        cardBackgroundView.contentMode = .scaleToFill
        cardBackgroundView.clipsToBounds = true
        cardBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(cardBackgroundView)

        avatarView.layer.cornerRadius = 26
        avatarView.layer.masksToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(avatarView)

        avatarLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        avatarLabel.textColor = .white
        avatarLabel.textAlignment = .center
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(avatarLabel)

        let avatarRingView = UIImageView(image: UIImage(named: Asset.avatarRing))
        avatarRingView.contentMode = .scaleAspectFit
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

        let deleteButton = UIButton(type: .custom)
        deleteButton.setImage(UIImage(named: Asset.deleteIcon), for: .normal)
        deleteButton.imageView?.contentMode = .scaleAspectFit
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(deleteButton)

        contentLabel.numberOfLines = 2
        contentLabel.font = .systemFont(ofSize: 13, weight: .regular)
        contentLabel.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(contentLabel)

        photoStackView.axis = .horizontal
        photoStackView.spacing = 8
        photoStackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(photoStackView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
            cardView.heightAnchor.constraint(equalToConstant: 230),

            cardBackgroundView.topAnchor.constraint(equalTo: cardView.topAnchor),
            cardBackgroundView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            cardBackgroundView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            cardBackgroundView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),

            avatarView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 26),
            avatarView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 21),
            avatarView.widthAnchor.constraint(equalToConstant: 52),
            avatarView.heightAnchor.constraint(equalToConstant: 52),

            avatarLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),

            avatarRingView.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarRingView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarRingView.widthAnchor.constraint(equalToConstant: 70),
            avatarRingView.heightAnchor.constraint(equalToConstant: 70),

            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 95),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 31),

            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),

            deleteButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -17),
            deleteButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 45),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24),

            contentLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 26),
            contentLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -22),
            contentLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 92),

            photoStackView.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
            photoStackView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
            photoStackView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func makePostPhotoView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "AI"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor.white.withAlphaComponent(0.82)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 83),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

}
