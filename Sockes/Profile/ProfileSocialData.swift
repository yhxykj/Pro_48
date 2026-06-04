//
//  ProfileSocialData.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

enum ProfileSocialData {

    private struct StoredUser: Codable {
        let name: String
        let avatarImageName: String?
        let message: String
        let profileVideoFileName: String?
    }

    private enum StorageKey {
        static let followingPrefix = "profile.social.following"
    }

    static var visibleFans: [ProfileListUser] {
        fans.filter { !UserBlockStore.isBlocked(name: $0.name) }
    }

    static var visibleFollowing: [ProfileListUser] {
        following.filter { !UserBlockStore.isBlocked(name: $0.name) }
    }

    static func isFollowing(name: String) -> Bool {
        following.contains { $0.name == name }
    }

    static func isMutualFollow(name: String) -> Bool {
        visibleFans.contains { $0.name == name } &&
            visibleFollowing.contains { $0.name == name }
    }

    static func follow(_ user: ProfileListUser) {
        var users = following.filter { $0.name != user.name }
        users.insert(user, at: 0)
        saveFollowing(users)
    }

    static func unfollow(name: String) {
        saveFollowing(following.filter { $0.name != name })
    }

    private static var following: [ProfileListUser] {
        guard let data = UserDefaults.standard.data(forKey: followingStorageKey),
              let users = try? JSONDecoder().decode([StoredUser].self, from: data) else {
            return []
        }

        return users.map {
            ProfileListUser(
                name: $0.name,
                avatarColor: UIColor(red: 0.76, green: 0.87, blue: 1.00, alpha: 1),
                avatarImageName: $0.avatarImageName,
                message: $0.message,
                profileVideoFileName: $0.profileVideoFileName
            )
        }
    }

    private static func saveFollowing(_ users: [ProfileListUser]) {
        let storedUsers = users.map {
            StoredUser(
                name: $0.name,
                avatarImageName: $0.avatarImageName,
                message: $0.message,
                profileVideoFileName: $0.profileVideoFileName
            )
        }

        guard let data = try? JSONEncoder().encode(storedUsers) else { return }

        UserDefaults.standard.set(data, forKey: followingStorageKey)
    }

    private static var followingStorageKey: String {
        let email = AuthSession.currentEmail ?? "guest"
        return "\(StorageKey.followingPrefix).\(email)"
    }

    private static var fans: [ProfileListUser] {
        guard isTestAccount else { return [] }

        return [
            ProfileListUser(
                name: "Simo",
                avatarColor: UIColor(red: 0.76, green: 0.87, blue: 1.00, alpha: 1),
                avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_simo",
                message: "Love is not a matter of counting the days. It's making the days count.",
                profileVideoFileName: "profile_male_video_simo"
            ),
            ProfileListUser(
                name: "Arlan",
                avatarColor: UIColor(red: 0.76, green: 0.87, blue: 1.00, alpha: 1),
                avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_arlan",
                message: "Don't be discouraged; it's often the last key in the bunch that opens the lock.",
                profileVideoFileName: "profile_female_video_arlan"
            ),
            ProfileListUser(
                name: "Williams",
                avatarColor: UIColor(red: 0.76, green: 0.87, blue: 1.00, alpha: 1),
                avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_williams",
                message: "Life is like a box of chocolates, you never know what you're gonna get.",
                profileVideoFileName: "profile_male_video_williams"
            )
        ]
    }

    private static var isTestAccount: Bool {
        AuthSession.currentEmail?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "sockes333@gmail.com"
    }

}
