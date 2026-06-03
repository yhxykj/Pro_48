//
//  ProfileUserListViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

enum ProfileUserListMode {
    case fans
    case following
    case blacklist
}

struct ProfileListUser {
    let name: String
    let avatarColor: UIColor
}

final class ProfileUserListViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let topBackground = "EmotionSync/ShareEmotions/share_emotions_background"
    }

    private let mode: ProfileUserListMode
    private let users: [ProfileListUser] = [
        ProfileListUser(name: "awanda", avatarColor: UIColor(red: 0.96, green: 0.75, blue: 0.42, alpha: 1)),
        ProfileListUser(name: "Greer", avatarColor: UIColor(red: 0.92, green: 0.61, blue: 0.38, alpha: 1)),
        ProfileListUser(name: "Mianon", avatarColor: UIColor(red: 0.72, green: 0.44, blue: 0.75, alpha: 1)),
        ProfileListUser(name: "Arlan", avatarColor: UIColor(red: 0.56, green: 0.42, blue: 0.78, alpha: 1)),
        ProfileListUser(name: "Perla", avatarColor: UIColor(red: 0.98, green: 0.67, blue: 0.48, alpha: 1)),
        ProfileListUser(name: "Simo", avatarColor: UIColor(red: 0.72, green: 0.65, blue: 0.95, alpha: 1))
    ]

    private let tableView = UITableView(frame: .zero, style: .plain)

    init(mode: ProfileUserListMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        titleLabel.text = titleText
        titleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 66
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileUserListCell.self, forCellReuseIdentifier: ProfileUserListCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            topBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundImageView.heightAnchor.constraint(equalToConstant: 180),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 92),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func showChatPage(for user: ProfileListUser) {
        let viewController = MessageChatViewController(
            friend: MessageFriend(
                name: user.name,
                message: "Smart and handsome sunshine boy.",
                avatarColor: user.avatarColor
            )
        )
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    private func showVideoCallPage(for user: ProfileListUser) {
        let viewController = MessageVideoCallViewController(
            friend: MessageFriend(
                name: user.name,
                message: "Smart and handsome sunshine boy.",
                avatarColor: user.avatarColor
            )
        )
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

    private var titleText: String {
        switch mode {
        case .fans:
            return "Fans"
        case .following:
            return "Following"
        case .blacklist:
            return "Blacklist"
        }
    }

}

extension ProfileUserListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileUserListCell.reuseIdentifier,
            for: indexPath
        ) as? ProfileUserListCell
        let user = users[indexPath.row]

        cell?.configure(with: user, mode: mode)
        cell?.onVideoTap = { [weak self] in
            self?.showVideoCallPage(for: user)
        }
        cell?.onMailTap = { [weak self] in
            self?.showChatPage(for: user)
        }
        return cell ?? UITableViewCell()
    }

}
