//
//  ProfileUserListCell.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

final class ProfileUserListCell: UITableViewCell {

    static let reuseIdentifier = "ProfileUserListCell"

    private enum Asset {
        static let videoButton = "EmotionSync/emotion_sync_video_button"
        static let mailButton = "EmotionSync/emotion_sync_mail_button"
        static let deleteButton = "Profile/profile_blacklist_delete_icon"
    }

    var onVideoTap: (() -> Void)?
    var onMailTap: (() -> Void)?
    var onDeleteTap: (() -> Void)?

    private let avatarView = UIView()
    private let avatarLabel = UILabel()
    private let nameLabel = UILabel()
    private let videoButton = UIButton(type: .custom)
    private let mailButton = UIButton(type: .custom)
    private let deleteButton = UIButton(type: .custom)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        onVideoTap = nil
        onMailTap = nil
        onDeleteTap = nil
    }

    func configure(with user: ProfileListUser, mode: ProfileUserListMode) {
        avatarView.backgroundColor = user.avatarColor
        avatarLabel.text = String(user.name.prefix(1))
        nameLabel.text = user.name

        videoButton.isHidden = mode != .fans
        mailButton.isHidden = mode == .blacklist
        deleteButton.isHidden = mode != .blacklist
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        avatarView.layer.cornerRadius = 25
        avatarView.layer.borderWidth = 1
        avatarView.layer.borderColor = UIColor(red: 0.41, green: 0.65, blue: 1.00, alpha: 1).cgColor
        avatarView.layer.masksToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarView)

        avatarLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        avatarLabel.textColor = .white
        avatarLabel.textAlignment = .center
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(avatarLabel)

        nameLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        nameLabel.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.20, alpha: 1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        videoButton.setImage(UIImage(named: Asset.videoButton), for: .normal)
        videoButton.addTarget(self, action: #selector(handleVideoTap), for: .touchUpInside)
        videoButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(videoButton)

        mailButton.setImage(UIImage(named: Asset.mailButton), for: .normal)
        mailButton.addTarget(self, action: #selector(handleMailTap), for: .touchUpInside)
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mailButton)

        deleteButton.setImage(UIImage(named: Asset.deleteButton), for: .normal)
        deleteButton.addTarget(self, action: #selector(handleDeleteTap), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            avatarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 50),
            avatarView.heightAnchor.constraint(equalToConstant: 50),

            avatarLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),

            mailButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            mailButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            mailButton.widthAnchor.constraint(equalToConstant: 42),
            mailButton.heightAnchor.constraint(equalToConstant: 42),

            videoButton.trailingAnchor.constraint(equalTo: mailButton.leadingAnchor, constant: -18),
            videoButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            videoButton.widthAnchor.constraint(equalToConstant: 42),
            videoButton.heightAnchor.constraint(equalToConstant: 42),

            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            deleteButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 42),
            deleteButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }

    @objc private func handleVideoTap() {
        onVideoTap?()
    }

    @objc private func handleMailTap() {
        onMailTap?()
    }

    @objc private func handleDeleteTap() {
        onDeleteTap?()
    }

}
