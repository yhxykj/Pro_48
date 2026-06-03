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
}

final class MessageViewController: UIViewController {

    private enum Asset {
        static let topBackground = "EmotionSync/ShareEmotions/share_emotions_background"
        static let messageTitle = "Message/message_section_title"
    }

    private let messages: [MessageFriend] = [
        MessageFriend(name: "Williams", message: "Smart and handsome sunshine boy.", avatarColor: UIColor(red: 0.96, green: 0.75, blue: 0.41, alpha: 1)),
        MessageFriend(name: "Greer", message: "Smart and handsome sunshine boy.", avatarColor: UIColor(red: 0.83, green: 0.55, blue: 0.36, alpha: 1)),
        MessageFriend(name: "Mianon", message: "Smart and handsome sunshine boy.", avatarColor: UIColor(red: 0.60, green: 0.39, blue: 0.72, alpha: 1)),
        MessageFriend(name: "Tawanna", message: "Smart and handsome sunshine boy.", avatarColor: UIColor(red: 0.98, green: 0.68, blue: 0.53, alpha: 1))
    ]

    private let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension MessageViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MessageFriendCell.reuseIdentifier,
            for: indexPath
        ) as? MessageFriendCell
        cell?.configure(with: messages[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewController = MessageChatViewController(friend: messages[indexPath.row])
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

}
