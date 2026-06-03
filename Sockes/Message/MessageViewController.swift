//
//  MessageViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

struct MessageFriend {
    let name: String
    let message: String
    let avatarColor: UIColor
    let avatarImageName: String?
    let profileVideoFileName: String?

    init(
        name: String,
        message: String,
        avatarColor: UIColor,
        avatarImageName: String? = nil,
        profileVideoFileName: String? = nil
    ) {
        self.name = name
        self.message = message
        self.avatarColor = avatarColor
        self.avatarImageName = avatarImageName
        self.profileVideoFileName = profileVideoFileName
    }
}

extension MessageFriend {

    var blockedUser: BlockedUser {
        BlockedUser(
            name: name,
            message: message,
            avatarImageName: avatarImageName,
            profileVideoFileName: profileVideoFileName
        )
    }

}

final class MessageViewController: UIViewController {

    private enum Asset {
        static let topBackground = "EmotionSync/ShareEmotions/share_emotions_background"
        static let messageTitle = "Message/message_section_title"
    }

    private var messages: [MessageFriend] = []

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let emptyStateView = EmptyStateView()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadMessages()
        setupContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadMessages()
        tableView.reloadData()
        updateEmptyState()
    }

    private func setupContent() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let topBackgroundImageView = UIImageView(image: UIImage(named: Asset.topBackground))
        topBackgroundImageView.contentMode = .scaleToFill
        topBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBackgroundImageView)

        let messageTitleImageView = UIImageView(image: UIImage(named: Asset.messageTitle))
        messageTitleImageView.contentMode = .scaleAspectFit
        messageTitleImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageTitleImageView)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 86
        tableView.register(MessageFriendCell.self, forCellReuseIdentifier: MessageFriendCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateView)

        NSLayoutConstraint.activate([
            topBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundImageView.heightAnchor.constraint(equalToConstant: 207),

            messageTitleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            messageTitleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 82),
            messageTitleImageView.widthAnchor.constraint(equalToConstant: 101),
            messageTitleImageView.heightAnchor.constraint(equalToConstant: 58),

            tableView.topAnchor.constraint(equalTo: messageTitleImageView.bottomAnchor, constant: 13),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyStateView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 12),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.heightAnchor.constraint(equalToConstant: 260)
        ])

        updateEmptyState()
    }

    private func updateEmptyState() {
        let isEmpty = visibleMessages.isEmpty
        tableView.isHidden = isEmpty
        emptyStateView.isHidden = !isEmpty
    }

    private func loadMessages() {
        messages = MessageConversationStore.summaries().map {
            MessageFriend(
                name: $0.name,
                message: $0.message,
                avatarColor: UIColor(red: 0.76, green: 0.87, blue: 1.00, alpha: 1),
                avatarImageName: $0.avatarImageName,
                profileVideoFileName: $0.profileVideoFileName
            )
        }
    }

}

extension MessageViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        visibleMessages.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MessageFriendCell.reuseIdentifier,
            for: indexPath
        ) as? MessageFriendCell
        cell?.configure(with: visibleMessages[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let friend = visibleMessages[indexPath.row]
        guard !UserBlockStore.isBlocked(name: friend.name) else {
            showBlockedUserAlert()
            return
        }

        let viewController = MessageChatViewController(friend: friend)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

}

private extension MessageViewController {

    var visibleMessages: [MessageFriend] {
        messages.filter { !UserBlockStore.isBlocked(name: $0.name) }
    }

}
