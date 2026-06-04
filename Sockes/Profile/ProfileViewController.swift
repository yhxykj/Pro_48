//
//  ProfileViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

final class ProfileViewController: UIViewController {

    private enum Asset {
        static let headerBackground = "Profile/profile_header_background"
        static let settingsIcon = "Profile/profile_settings_icon"
        static let avatarEditIcon = "Profile/profile_avatar_edit_icon"
        static let walletBanner = "Profile/profile_wallet_banner"
        static let friendTitle = "Profile/profile_friend_title"
    }

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let fansCountLabel = UILabel()
    private let followingCountLabel = UILabel()
    private let profileNameLabel = UILabel()
    private let profileAvatarView = UIImageView()
    private let profileAvatarInitialLabel = UILabel()
    private let sloganLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        updateSocialCounts()
        updateProfileInfo()
        tableView.reloadData()
    }

    private func setupContent() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let headerBackgroundView = UIImageView(image: UIImage(named: Asset.headerBackground))
        headerBackgroundView.contentMode = .scaleToFill
        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerBackgroundView)

        let settingsButton = UIButton(type: .custom)
        settingsButton.setImage(UIImage(named: Asset.settingsIcon), for: .normal)
        settingsButton.imageView?.contentMode = .scaleAspectFit
        settingsButton.addTarget(self, action: #selector(showSettingPage), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)

        let nameLabel = profileNameLabel
        nameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        sloganLabel.numberOfLines = 2
        sloganLabel.font = .systemFont(ofSize: 17, weight: .regular)
        sloganLabel.textColor = UIColor(red: 0.39, green: 0.39, blue: 0.40, alpha: 1)
        sloganLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sloganLabel)

        let avatarView = makeProfileAvatarView()
        avatarView.isUserInteractionEnabled = true
        avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showEditProfilePage)))
        view.addSubview(avatarView)

        let editBadgeView = makeEditBadgeView()
        view.addSubview(editBadgeView)

        let fansLabel = makeStatsTitleLabel("Fans")
        view.addSubview(fansLabel)

        configureStatsCountLabel(fansCountLabel)
        view.addSubview(fansCountLabel)
        [fansLabel, fansCountLabel].forEach { label in
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFansPage)))
        }

        let followingLabel = makeStatsTitleLabel("Following")
        view.addSubview(followingLabel)

        configureStatsCountLabel(followingCountLabel)
        view.addSubview(followingCountLabel)
        [followingLabel, followingCountLabel].forEach { label in
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFollowingPage)))
        }

        let walletImageView = UIImageView(image: UIImage(named: Asset.walletBanner))
        walletImageView.contentMode = .scaleToFill
        walletImageView.isUserInteractionEnabled = true
        walletImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showRechargePage)))
        walletImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(walletImageView)

        let friendTitleImageView = UIImageView(image: UIImage(named: Asset.friendTitle))
        friendTitleImageView.contentMode = .scaleAspectFit
        friendTitleImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(friendTitleImageView)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 254
        tableView.register(ProfilePostCell.self, forCellReuseIdentifier: ProfilePostCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            headerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerBackgroundView.heightAnchor.constraint(equalToConstant: 471),

            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            settingsButton.widthAnchor.constraint(equalToConstant: 44),
            settingsButton.heightAnchor.constraint(equalToConstant: 44),

            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),

            sloganLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            sloganLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            sloganLabel.trailingAnchor.constraint(equalTo: avatarView.leadingAnchor, constant: -25),

            avatarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 76),
            avatarView.widthAnchor.constraint(equalToConstant: 78),
            avatarView.heightAnchor.constraint(equalToConstant: 78),

            editBadgeView.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: -4),
            editBadgeView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: -1),
            editBadgeView.widthAnchor.constraint(equalToConstant: 24),
            editBadgeView.heightAnchor.constraint(equalToConstant: 24),

            fansLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            fansLabel.topAnchor.constraint(equalTo: sloganLabel.bottomAnchor, constant: 24),

            fansCountLabel.leadingAnchor.constraint(equalTo: fansLabel.trailingAnchor, constant: 16),
            fansCountLabel.centerYAnchor.constraint(equalTo: fansLabel.centerYAnchor),

            followingLabel.leadingAnchor.constraint(equalTo: fansCountLabel.trailingAnchor, constant: 39),
            followingLabel.centerYAnchor.constraint(equalTo: fansLabel.centerYAnchor),

            followingCountLabel.leadingAnchor.constraint(equalTo: followingLabel.trailingAnchor, constant: 16),
            followingCountLabel.centerYAnchor.constraint(equalTo: fansLabel.centerYAnchor),

            walletImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            walletImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            walletImageView.topAnchor.constraint(equalTo: fansCountLabel.bottomAnchor, constant: 32),
            walletImageView.heightAnchor.constraint(equalToConstant: 80),

            friendTitleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            friendTitleImageView.topAnchor.constraint(equalTo: walletImageView.bottomAnchor, constant: 20),
            friendTitleImageView.widthAnchor.constraint(equalToConstant: 102),
            friendTitleImageView.heightAnchor.constraint(equalToConstant: 57),

            tableView.topAnchor.constraint(equalTo: friendTitleImageView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        updateSocialCounts()
        updateProfileInfo()
    }

    private func makeProfileAvatarView() -> UIImageView {
        let avatarView = profileAvatarView
        avatarView.backgroundColor = UIColor(red: 0.96, green: 0.75, blue: 0.42, alpha: 1)
        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.cornerRadius = 39
        avatarView.layer.borderWidth = 3
        avatarView.layer.borderColor = UIColor.white.cgColor
        avatarView.layer.masksToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false

        let label = profileAvatarInitialLabel
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor)
        ])

        return avatarView
    }

    private func makeEditBadgeView() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: Asset.avatarEditIcon), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showEditProfilePage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func makeStatsTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func configureStatsCountLabel(_ label: UILabel) {
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(red: 0.12, green: 0.14, blue: 0.15, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func updateSocialCounts() {
        fansCountLabel.text = formattedCount(ProfileSocialData.visibleFans.count)
        followingCountLabel.text = formattedCount(ProfileSocialData.visibleFollowing.count)
    }

    private func updateProfileInfo() {
        profileNameLabel.text = ProfileStore.displayName
        profileAvatarView.image = ProfileStore.avatarImage
        profileAvatarInitialLabel.text = ProfileStore.avatarInitial()
        profileAvatarInitialLabel.isHidden = profileAvatarView.image != nil
        sloganLabel.text = ProfileStore.slogan
    }

    private func formattedCount(_ count: Int) -> String {
        NumberFormatter.localizedString(from: NSNumber(value: count), number: .decimal)
    }

    @objc private func showSettingPage() {
        let viewController = SettingViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @objc private func showEditProfilePage() {
        let viewController = EditProfileViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @objc private func showFansPage() {
        let viewController = ProfileUserListViewController(mode: .fans)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @objc private func showFollowingPage() {
        let viewController = ProfileUserListViewController(mode: .following)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @objc private func showRechargePage() {
        let viewController = RechargeViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    private func showDeletePostConfirmation(for post: ProfilePost) {
        let alertController = UIAlertController(
            title: "Delete this post?",
            message: "This post will be removed from your profile.",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            ProfileStore.deletePost(post)
            self?.tableView.reloadData()
        })
        present(alertController, animated: true)
    }

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ProfileStore.profilePosts.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let post = ProfileStore.profilePosts[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfilePostCell.reuseIdentifier,
            for: indexPath
        ) as? ProfilePostCell
        cell?.configure(with: post)
        cell?.onDeleteTap = { [weak self] in
            self?.showDeletePostConfirmation(for: post)
        }
        return cell ?? UITableViewCell()
    }

}
