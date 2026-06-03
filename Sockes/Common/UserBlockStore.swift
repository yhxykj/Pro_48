//
//  UserBlockStore.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

struct BlockedUser: Codable, Equatable {
    let name: String
    let message: String
    let avatarImageName: String?
    let profileVideoFileName: String?
}

enum UserBlockStore {

    private static let storageKey = "user.blockedUsers"

    static var blockedUsers: [BlockedUser] {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let users = try? JSONDecoder().decode([BlockedUser].self, from: data)
        else { return [] }

        return users
    }

    static func isBlocked(name: String) -> Bool {
        blockedUsers.contains { $0.name == name }
    }

    static func block(_ user: BlockedUser) {
        var users = blockedUsers.filter { $0.name != user.name }
        users.append(user)
        save(users)
    }

    static func unblock(name: String) {
        save(blockedUsers.filter { $0.name != name })
    }

    private static func save(_ users: [BlockedUser]) {
        guard let data = try? JSONEncoder().encode(users) else { return }

        UserDefaults.standard.set(data, forKey: storageKey)
    }

}

enum PrimaryTabDestination {
    case home
    case emotionSync
    case message
    case profile

    var index: Int {
        switch self {
        case .home:
            return 0
        case .emotionSync:
            return 1
        case .message:
            return 2
        case .profile:
            return 3
        }
    }
}

extension UIViewController {

    func showBlockConfirmation(for user: BlockedUser, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(
            title: "Block this user?",
            message: "You won't receive messages or see their posts anymore.",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Block", style: .destructive) { [weak self] _ in
            UserBlockStore.block(user)
            self?.showSimpleAlert(title: "Blocked successfully", completion: completion)
        })
        present(alertController, animated: true)
    }

    func showBlockedUserAlert() {
        showSimpleAlert(title: "This user has been blocked")
    }

    func showReportReceivedAlert() {
        showSimpleAlert(
            title: "Thanks for your report.",
            message: "We'll review this content within 24 hours and take action if it violates our guidelines."
        )
    }

    func returnToPrimaryPage(_ destination: PrimaryTabDestination) {
        guard let tabBarController = view.window?.rootViewController as? UITabBarController else {
            dismiss(animated: true)
            return
        }

        tabBarController.selectedIndex = destination.index
        tabBarController.dismiss(animated: true)
    }

    func showSimpleAlert(title: String, message: String? = nil, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alertController, animated: true)
    }

}
