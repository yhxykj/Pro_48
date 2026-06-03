//
//  MessageFriendCell.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

final class MessageFriendCell: UITableViewCell {

    static let reuseIdentifier = "MessageFriendCell"

    private let avatarView = UIImageView()
    private let avatarLabel = UILabel()
    private let nameLabel = UILabel()
    private let messageLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with friend: MessageFriend) {
        avatarView.backgroundColor = friend.avatarColor
        avatarView.image = friend.avatarImageName.flatMap { UIImage(named: $0) }
        avatarLabel.isHidden = avatarView.image != nil
        avatarLabel.text = String(friend.name.prefix(1))
        nameLabel.text = friend.name
        messageLabel.text = friend.message
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8
        cardView.layer.masksToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        avatarView.layer.cornerRadius = 25
        avatarView.layer.borderWidth = 1
        avatarView.layer.borderColor = UIColor(red: 0.41, green: 0.65, blue: 1.00, alpha: 1).cgColor
        avatarView.layer.masksToBounds = true
        avatarView.contentMode = .scaleAspectFill
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(avatarView)

        avatarLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        avatarLabel.textColor = .white
        avatarLabel.textAlignment = .center
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(avatarLabel)

        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.22, alpha: 1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(nameLabel)

        messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        messageLabel.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            avatarView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14),
            avatarView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 50),
            avatarView.heightAnchor.constraint(equalToConstant: 50),

            avatarLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 22),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -18),

            messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 11),
            messageLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }

}
