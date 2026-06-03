//
//  MessageConversationStore.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import Foundation

struct MessageConversationSummary: Codable {
    let name: String
    var message: String
    var avatarImageName: String?
    var profileVideoFileName: String?
    var updatedAt: TimeInterval
}

enum MessageConversationStore {

    private enum StorageKey {
        static let summaryPrefix = "message.friend.summaries"
    }

    static func summaries() -> [MessageConversationSummary] {
        guard let data = UserDefaults.standard.data(forKey: summaryStorageKey),
              let summaries = try? JSONDecoder().decode([MessageConversationSummary].self, from: data) else {
            return []
        }

        let enrichedSummaries = summaries.map(enrichedSummary)
        if enrichedSummaries.contains(where: { summary in
            guard let original = summaries.first(where: { $0.name == summary.name }) else { return false }

            return original.avatarImageName != summary.avatarImageName ||
                original.profileVideoFileName != summary.profileVideoFileName
        }) {
            save(enrichedSummaries)
        }

        return enrichedSummaries.sorted { $0.updatedAt > $1.updatedAt }
    }

    static func upsert(friend: MessageFriend, latestMessage: String) {
        var summaries = summaries()
        let now = Date().timeIntervalSince1970

        if let index = summaries.firstIndex(where: { $0.name == friend.name }) {
            summaries[index].message = latestMessage
            summaries[index].avatarImageName = friend.avatarImageName ?? avatarImageName(for: friend.name)
            summaries[index].profileVideoFileName = friend.profileVideoFileName ?? profileVideoFileName(for: friend.name)
            summaries[index].updatedAt = now
        } else {
            let summary = MessageConversationSummary(
                name: friend.name,
                message: latestMessage,
                avatarImageName: friend.avatarImageName ?? avatarImageName(for: friend.name),
                profileVideoFileName: friend.profileVideoFileName ?? profileVideoFileName(for: friend.name),
                updatedAt: now
            )
            summaries.append(summary)
        }

        save(summaries)
    }

    private static func save(_ summaries: [MessageConversationSummary]) {
        guard let data = try? JSONEncoder().encode(summaries) else { return }

        UserDefaults.standard.set(data, forKey: summaryStorageKey)
    }

    private static var summaryStorageKey: String {
        let email = AuthSession.currentEmail ?? "guest"
        return "\(StorageKey.summaryPrefix).\(email)"
    }

    private static func enrichedSummary(_ summary: MessageConversationSummary) -> MessageConversationSummary {
        MessageConversationSummary(
            name: summary.name,
            message: summary.message,
            avatarImageName: summary.avatarImageName ?? avatarImageName(for: summary.name),
            profileVideoFileName: summary.profileVideoFileName ?? profileVideoFileName(for: summary.name),
            updatedAt: summary.updatedAt
        )
    }

    private static func avatarImageName(for name: String) -> String? {
        switch name {
        case "Simo":
            return "EmotionSync/PostAvatars/emotion_post_avatar_simo"
        case "Arlan":
            return "EmotionSync/PostAvatars/emotion_post_avatar_arlan"
        case "Williams":
            return "EmotionSync/PostAvatars/emotion_post_avatar_williams"
        case "Perla":
            return "EmotionSync/PostAvatars/emotion_post_avatar_perla"
        case "Nue":
            return "EmotionSync/PostAvatars/emotion_post_avatar_nue"
        case "Psai":
            return "EmotionSync/PostAvatars/emotion_post_avatar_psai"
        case "Kari":
            return "EmotionSync/PostAvatars/emotion_post_avatar_kari"
        default:
            return nil
        }
    }

    private static func profileVideoFileName(for name: String) -> String? {
        switch name {
        case "Simo":
            return "profile_male_video_simo"
        case "Arlan":
            return "profile_female_video_arlan"
        case "Williams":
            return "profile_male_video_williams"
        case "Perla":
            return "profile_female_video_perla"
        case "Nue":
            return "profile_male_video_nue"
        case "Psai":
            return "profile_male_video_psai"
        case "Kari":
            return "profile_female_video_kari"
        default:
            return nil
        }
    }

}
