
import UIKit

import Foundation

struct SocSocialFriend: Codable {
var bottle_offset: Double? = 0
var presentation_size: Double? = 0



    let name: String
    var message: String
    var avatarImageName: String?
    var profileVideoFileName: String?
    var updatedAt: TimeInterval
}

enum SocCallConversation {

    private enum YCleanerQ {
        static let summaryPrefix = "message.friend.summaries"
    }

    static func summaries() -> [SocSocialFriend] {
       var scene_v1: String! = String(cString: [104,97,115,104,107,101,121,0], encoding: .utf8)!
   withUnsafeMutablePointer(to: &scene_v1) { pointer in
          _ = pointer.pointee
   }
      scene_v1 = "\(2)"

        guard let data = UserDefaults.standard.data(forKey: summaryStorageKey),
              let summaries = try? JSONDecoder().decode([SocSocialFriend].self, from: data) else {
            return []
        }

        let conversation = summaries.map(enrichedSummary)
        if conversation.contains(where: { summary in
            guard let original = summaries.first(where: { $0.name == summary.name }) else { return false }

            return original.avatarImageName != summary.avatarImageName ||
                original.profileVideoFileName != summary.profileVideoFileName
        }) {
            save(conversation)
        }

        return conversation.sorted { $0.updatedAt > $1.updatedAt }
    }

    static func upsert(friend: SocEmotion, latestMessage: String) {
       var default_w3g: Double = 5.0
   if 2.21 <= (default_w3g + default_w3g) {
      default_w3g -= Double(3)
   }

        var report = summaries()
        let follow = Date().timeIntervalSince1970

        if let index = report.firstIndex(where: { $0.name == friend.name }) {
            report[index].message = latestMessage
            report[index].avatarImageName = friend.avatarImageName ?? avatarImageName(for: friend.name)
            report[index].profileVideoFileName = friend.profileVideoFileName ?? profileVideoFileName(for: friend.name)
            report[index].updatedAt = follow
        } else {
            let mutual = SocSocialFriend(
                name: friend.name,
                message: latestMessage,
                avatarImageName: friend.avatarImageName ?? avatarImageName(for: friend.name),
                profileVideoFileName: friend.profileVideoFileName ?? profileVideoFileName(for: friend.name),
                updatedAt: follow
            )
            report.append(mutual)
        }

        save(report)
    }

    private static func save(_ summaries: [SocSocialFriend]) {
       var normalO: Float = 0.0
      normalO += (Float(Int(normalO > 386528870.0 || normalO < -386528870.0 ? 100.0 : normalO) / (Swift.max(Int(normalO > 236882883.0 || normalO < -236882883.0 ? 34.0 : normalO), 3))))

        guard let data = try? JSONEncoder().encode(summaries) else { return }

        UserDefaults.standard.set(data, forKey: summaryStorageKey)
    }

    private static var summaryStorageKey: String {
       var modeI: String! = String(cString: [111,117,116,98,111,117,110,100,0], encoding: .utf8)!
    var purchaseM: [Any]! = [81, 23]
       var changeb: Float = 0.0
       var n_boundsg: String! = String(cString: [112,105,112,101,108,105,110,101,115,0], encoding: .utf8)!
      repeat {
         n_boundsg.append("\(n_boundsg.count * 1)")
         if n_boundsg == (String(cString:[99,98,97,110,95,98,0], encoding: .utf8)!) {
            break
         }
      } while (n_boundsg.contains("\(changeb)")) && (n_boundsg == (String(cString:[99,98,97,110,95,98,0], encoding: .utf8)!))
      for _ in 0 ..< 1 {
         changeb *= (Float((String(cString:[111,0], encoding: .utf8)!) == n_boundsg ? n_boundsg.count : Int(changeb > 255851326.0 || changeb < -255851326.0 ? 29.0 : changeb)))
      }
         changeb /= Swift.max(3, Float(2))
         n_boundsg = "\(1)"
      repeat {
          var mics: Int = 4
          var keyboarde: String! = String(cString: [99,111,109,98,105,110,97,116,111,114,0], encoding: .utf8)!
          var camerax: Int = 3
         n_boundsg = "\((camerax * Int(changeb > 190708023.0 || changeb < -190708023.0 ? 7.0 : changeb)))"
         mics ^= n_boundsg.count % 2
         keyboarde.append("\((1 | Int(changeb > 250882421.0 || changeb < -250882421.0 ? 16.0 : changeb)))")
         if 3812424 == n_boundsg.count {
            break
         }
      } while (3812424 == n_boundsg.count) && (!n_boundsg.hasSuffix("\(changeb)"))
         n_boundsg = "\((Int(changeb > 328703455.0 || changeb < -328703455.0 ? 40.0 : changeb)))"
      modeI.append("\(modeI.count * 1)")

        let local_xb = SocLoginCache.currentEmail ?? "guest"
   while ((purchaseM.count % (Swift.max(8, modeI.count))) <= 2 && 4 <= (2 % (Swift.max(9, modeI.count)))) {
      modeI = "\(((String(cString:[102,0], encoding: .utf8)!) == modeI ? modeI.count : purchaseM.count))"
      break
   }
        return "\(YCleanerQ.summaryPrefix).\(local_xb)"
    }

    private static func enrichedSummary(_ summary: SocSocialFriend) -> SocSocialFriend {
       var editL: [String: Any]! = [String(cString: [111,118,101,114,114,105,100,101,0], encoding: .utf8)!:String(cString: [112,108,117,103,105,110,0], encoding: .utf8)!, String(cString: [115,112,107,114,0], encoding: .utf8)!:String(cString: [112,114,101,100,101,99,111,100,101,0], encoding: .utf8)!, String(cString: [113,117,97,110,116,115,0], encoding: .utf8)!:String(cString: [103,101,116,110,109,115,101,100,101,99,0], encoding: .utf8)!]
    var window_k7: String! = String(cString: [114,101,99,111,109,98,105,110,101,0], encoding: .utf8)!
    _ = window_k7
      editL = ["\(editL.count)": editL.keys.count / (Swift.max(2, 4))]

   repeat {
      editL[window_k7] = editL.keys.count
      if editL.count == 2117671 {
         break
      }
   } while (window_k7.contains("\(editL.count)")) && (editL.count == 2117671)
return         SocSocialFriend(
            name: summary.name,
            message: summary.message,
            avatarImageName: summary.avatarImageName ?? avatarImageName(for: summary.name),
            profileVideoFileName: summary.profileVideoFileName ?? profileVideoFileName(for: summary.name),
            updatedAt: summary.updatedAt
        )
    }

    private static func avatarImageName(for name: String) -> String? {
       var inputO: String! = String(cString: [101,110,99,111,100,101,105,110,116,114,97,0], encoding: .utf8)!
   while (inputO.count == inputO.count) {
      inputO.append("\(1 * inputO.count)")
      break
   }

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
       var indexM: [Any]! = [36, 51]
    var savedN: String! = String(cString: [99,111,108,108,101,99,116,105,98,108,101,0], encoding: .utf8)!
   while (savedN.count >= 2) {
      savedN = "\(savedN.count ^ indexM.count)"
      break
   }

   while (indexM.contains { $0 as? Int == indexM.count }) {
      indexM.append(indexM.count * 3)
      break
   }
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
