//
//  ProfileStore.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/4.
//

import UIKit

enum ProfileStore {

    private enum StorageKey {
        static let displayNamePrefix = "profile.displayName"
        static let avatarFileNamePrefix = "profile.avatarFileName"
        static let deletedPostIDsPrefix = "profile.deletedPostIDs"
    }

    static var displayName: String {
        guard let storedName = UserDefaults.standard.string(forKey: displayNameStorageKey),
              !storedName.isEmpty else {
            return defaultDisplayName
        }

        if isTestAccount, storedName == "Williams" {
            return defaultDisplayName
        }

        return storedName
    }

    static var avatarImage: UIImage? {
        guard let fileName = UserDefaults.standard.string(forKey: avatarFileNameStorageKey) else {
            return defaultAvatarImage
        }

        return UIImage(contentsOfFile: avatarFileURL(fileName: fileName).path) ?? defaultAvatarImage
    }

    static var slogan: String {
        defaultSlogan
    }

    static var profilePosts: [ProfilePost] {
        baseProfilePosts.filter { !deletedPostIDs.contains($0.id) }
    }

    static func deletePost(_ post: ProfilePost) {
        var postIDs = deletedPostIDs
        postIDs.insert(post.id)
        UserDefaults.standard.set(Array(postIDs), forKey: deletedPostIDsStorageKey)
    }

    static func save(displayName: String, avatarImage: UIImage?) {
        UserDefaults.standard.set(displayName, forKey: displayNameStorageKey)

        guard let avatarImage,
              let imageData = avatarImage.jpegData(compressionQuality: 0.86) else { return }

        let fileName = "\(currentAccountKey)_profile_avatar.jpg"
        try? imageData.write(to: avatarFileURL(fileName: fileName), options: .atomic)
        UserDefaults.standard.set(fileName, forKey: avatarFileNameStorageKey)
    }

    static func avatarInitial() -> String {
        String(displayName.prefix(1)).uppercased()
    }

    private static var baseProfilePosts: [ProfilePost] {
        if isTestAccount {
            return [
                ProfilePost(
                    id: "test-account-psai-flower-post",
                    name: displayName,
                    time: "Jun 02",
                    content: "A small flower can still make the whole road feel softer.",
                    avatarColor: UIColor(red: 0.76, green: 0.87, blue: 1.00, alpha: 1),
                    avatarImage: avatarImage,
                    photoImageNames: [
                        "EmotionSync/PostPhotos/emotion_post_photo_flowers"
                    ]
                )
            ]
        }

        return []
    }

    private static var displayNameStorageKey: String {
        "\(StorageKey.displayNamePrefix).\(currentAccountKey)"
    }

    private static var avatarFileNameStorageKey: String {
        "\(StorageKey.avatarFileNamePrefix).\(currentAccountKey)"
    }

    private static var deletedPostIDsStorageKey: String {
        "\(StorageKey.deletedPostIDsPrefix).\(currentAccountKey)"
    }

    private static var deletedPostIDs: Set<String> {
        Set(UserDefaults.standard.stringArray(forKey: deletedPostIDsStorageKey) ?? [])
    }

    private static var currentAccountKey: String {
        (AuthSession.currentEmail ?? "guest")
            .lowercased()
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
    }

    private static var defaultDisplayName: String {
        isTestAccount ? "Psai" : "Williams"
    }

    private static var defaultAvatarImage: UIImage? {
        guard isTestAccount else { return nil }

        return UIImage(named: "EmotionSync/PostAvatars/emotion_post_avatar_psai")
    }

    private static var defaultSlogan: String {
        isTestAccount ?
            "A small flower can still make the\nwhole road feel softer." :
            "Love is not a matter of counting the\ndays. It'smaking the days count."
    }

    private static var isTestAccount: Bool {
        AuthSession.currentEmail?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "sockes333@gmail.com"
    }

    private static func avatarFileURL(fileName: String) -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }

}
