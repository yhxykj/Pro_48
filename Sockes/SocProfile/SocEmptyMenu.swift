
import Foundation

import UIKit

enum SocEmptyMenu {

    private enum YCleanerQ {
        static let displayNamePrefix = "profile.displayName"
        static let avatarFileNamePrefix = "profile.avatarFileName"
        static let deletedPostIDsPrefix = "profile.deletedPostIDs"
    }

    static var displayName: String {
       var tagsG: Double = 4.0
      tagsG /= Swift.max(4, (Double(Int(tagsG > 159767433.0 || tagsG < -159767433.0 ? 17.0 : tagsG))))

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
       var tagliney: String! = String(cString: [115,101,97,116,0], encoding: .utf8)!
   while (tagliney.count > tagliney.count) {
      tagliney.append("\(tagliney.count / (Swift.max(3, 3)))")
      break
   }

        guard let fileName = UserDefaults.standard.string(forKey: avatarFileNameStorageKey) else {
            return defaultAvatarImage
        }

        return UIImage(contentsOfFile: avatarFileURL(fileName: fileName).path) ?? defaultAvatarImage
    }

    static var slogan: String {
       var malef: String! = String(cString: [104,101,118,99,0], encoding: .utf8)!
   for _ in 0 ..< 2 {
      malef.append("\(2)")
   }

            return defaultSlogan
    }

    static var profilePosts: [SocFollowArlan] {
       var headerx: Int = 0
    var shouldy: [Any]! = [String(cString: [115,101,114,105,97,108,0], encoding: .utf8)!, String(cString: [97,112,112,114,111,120,105,109,97,116,101,0], encoding: .utf8)!]
    var topW: Double = 0.0
      shouldy.append(1 << (Swift.min(1, shouldy.count)))
      topW -= (Double(Int(topW > 93797134.0 || topW < -93797134.0 ? 59.0 : topW) + headerx))

            return baseProfilePosts.filter { !deletedPostIDs.contains($0.id) }
   if (3 ^ headerx) > 2 || (3 ^ headerx) > 3 {
       var users7: [String: Any]! = [String(cString: [99,104,101,118,114,111,110,0], encoding: .utf8)!:String(cString: [115,97,116,117,114,97,116,105,111,110,0], encoding: .utf8)!, String(cString: [102,116,118,102,111,108,100,101,114,111,112,101,110,0], encoding: .utf8)!:String(cString: [108,101,114,116,0], encoding: .utf8)!]
       var microphone6: String! = String(cString: [114,108,118,108,99,0], encoding: .utf8)!
      withUnsafeMutablePointer(to: &microphone6) { pointer in
    
      }
       var messagesx: String! = String(cString: [112,97,103,0], encoding: .utf8)!
       var appearanceS: Int = 4
         messagesx = "\(messagesx.count - 3)"
         messagesx.append("\(users7.values.count)")
      if 4 > microphone6.count {
          var repliesC: Int = 0
          var synch: String! = String(cString: [105,110,102,101,114,0], encoding: .utf8)!
         microphone6.append("\(microphone6.count | users7.values.count)")
         repliesC |= ((String(cString:[52,0], encoding: .utf8)!) == synch ? messagesx.count : synch.count)
      }
      for _ in 0 ..< 3 {
          var keywordsO: Bool = false
          _ = keywordsO
         messagesx = "\(messagesx.count)"
         keywordsO = messagesx.count == 5
      }
      repeat {
         microphone6 = "\(messagesx.count)"
         if (String(cString:[120,117,56,114,57,110,0], encoding: .utf8)!) == microphone6 {
            break
         }
      } while ((String(cString:[120,117,56,114,57,110,0], encoding: .utf8)!) == microphone6) && (messagesx == microphone6)
      while (3 == (5 * microphone6.count)) {
          var psai_: [Any]! = [String(cString: [117,110,100,101,102,105,110,101,100,0], encoding: .utf8)!, String(cString: [99,111,109,112,108,101,120,0], encoding: .utf8)!, String(cString: [110,97,116,117,114,97,108,0], encoding: .utf8)!]
          var modity0: Int = 3
          var updated9: [String: Any]! = [String(cString: [101,114,108,101,0], encoding: .utf8)!:66, String(cString: [115,104,105,109,109,101,114,0], encoding: .utf8)!:68, String(cString: [115,116,114,101,97,109,102,111,117,114,99,99,0], encoding: .utf8)!:50]
         users7 = ["\(users7.values.count)": (microphone6 == (String(cString:[85,0], encoding: .utf8)!) ? microphone6.count : users7.values.count)]
         psai_.append(users7.keys.count)
         modity0 >>= Swift.min(1, updated9.count)
         updated9["\(psai_.count)"] = users7.keys.count % (Swift.max(1, 3))
         break
      }
       var remainD: Double = 5.0
       var cameraI: Double = 4.0
       _ = cameraI
       var closeH: [String: Any]! = [String(cString: [105,110,115,101,114,116,105,110,103,0], encoding: .utf8)!:2, String(cString: [115,101,109,97,110,116,105,99,97,108,108,121,0], encoding: .utf8)!:52]
       var indexH: [String: Any]! = [String(cString: [99,111,100,101,114,0], encoding: .utf8)!:8, String(cString: [98,101,108,111,110,103,0], encoding: .utf8)!:91]
      if (indexH.count % 2) <= 4 || 5 <= (2 % (Swift.max(8, closeH.values.count))) {
         indexH = ["\(indexH.keys.count)": indexH.values.count]
      }
       var arlan9: String! = String(cString: [100,111,109,105,110,97,110,116,0], encoding: .utf8)!
          var throw_jmr: String! = String(cString: [108,105,98,118,111,114,98,105,115,0], encoding: .utf8)!
          var microphoneb: Bool = true
         withUnsafeMutablePointer(to: &microphoneb) { pointer in
                _ = pointer.pointee
         }
          var insufficientR: String! = String(cString: [113,117,101,114,121,0], encoding: .utf8)!
         appearanceS <<= Swift.min(labs(insufficientR.count >> (Swift.min(3, indexH.keys.count))), 3)
         throw_jmr = "\(appearanceS - insufficientR.count)"
         microphoneb = cameraI >= 79.89
         closeH = [microphone6: (microphone6 == (String(cString:[104,0], encoding: .utf8)!) ? appearanceS : microphone6.count)]
         remainD += Double(users7.values.count | closeH.keys.count)
         arlan9 = "\(messagesx.count)"
      headerx >>= Swift.min(4, labs(users7.values.count >> (Swift.min(labs(3), 3))))
   }
    }

    static func deletePost(_ post: SocFollowArlan) {
       var main_yz: String! = String(cString: [99,116,105,118,105,116,121,0], encoding: .utf8)!
   repeat {
       var messageO: String! = String(cString: [112,108,97,116,101,97,117,0], encoding: .utf8)!
       var topW: [String: Any]! = [String(cString: [117,110,105,116,121,0], encoding: .utf8)!:16, String(cString: [114,101,113,117,105,114,101,100,0], encoding: .utf8)!:76, String(cString: [97,99,111,108,111,114,0], encoding: .utf8)!:80]
       var min_7k: String! = String(cString: [97,112,112,108,101,0], encoding: .utf8)!
      repeat {
         topW = ["\(topW.keys.count)": 2 - min_7k.count]
         if topW.count == 3479011 {
            break
         }
      } while (topW.count == 3479011) && (min_7k.count > topW.values.count)
         messageO = "\(messageO.count | min_7k.count)"
      while (min_7k.hasPrefix("\(topW.values.count)")) {
          var presentationM: Double = 1.0
         min_7k = "\(topW.count)"
         presentationM /= Swift.max(3, Double(messageO.count))
         break
      }
      for _ in 0 ..< 3 {
         min_7k = "\((messageO == (String(cString:[84,0], encoding: .utf8)!) ? min_7k.count : messageO.count))"
      }
      for _ in 0 ..< 2 {
         messageO = "\((min_7k == (String(cString:[48,0], encoding: .utf8)!) ? messageO.count : min_7k.count))"
      }
      if !min_7k.hasPrefix("\(topW.count)") {
         topW = ["\(topW.count)": 1 << (Swift.min(3, messageO.count))]
      }
      repeat {
         min_7k.append("\(1 * min_7k.count)")
         if (String(cString:[56,50,112,119,100,118,0], encoding: .utf8)!) == min_7k {
            break
         }
      } while ((String(cString:[56,50,112,119,100,118,0], encoding: .utf8)!) == min_7k) && (min_7k.hasSuffix("\(topW.values.count)"))
         topW["\(messageO)"] = topW.count
       var frame_aJ: Bool = false
      withUnsafeMutablePointer(to: &frame_aJ) { pointer in
             _ = pointer.pointee
      }
       var femaleG: Bool = false
         frame_aJ = min_7k.count >= 96 && femaleG
         femaleG = frame_aJ || femaleG
      main_yz = "\(3 - topW.count)"
      if main_yz == (String(cString:[95,49,112,0], encoding: .utf8)!) {
         break
      }
   } while (main_yz.hasSuffix(main_yz)) && (main_yz == (String(cString:[95,49,112,0], encoding: .utf8)!))

        var sheet = deletedPostIDs
        sheet.insert(post.id)
        UserDefaults.standard.set(Array(sheet), forKey: deletedPostIDsStorageKey)
    }

    static func save(displayName: String, avatarImage: UIImage?) {
       var settingA: Int = 4
   if 2 >= (settingA + 3) || 5 >= (3 + settingA) {
      settingA &= 3
   }

        UserDefaults.standard.set(displayName, forKey: displayNameStorageKey)

        guard let avatarImage,
              let recommend = avatarImage.jpegData(compressionQuality: 0.86) else { return }

        let screen = "\(currentAccountKey)_profile_avatar.jpg"
        try? recommend.write(to: avatarFileURL(fileName: screen), options: .atomic)
        UserDefaults.standard.set(screen, forKey: avatarFileNameStorageKey)
    }

    static func avatarInitial() -> String {
       var frame_5ei: String! = String(cString: [115,117,115,112,101,110,100,101,100,0], encoding: .utf8)!
    _ = frame_5ei
   for _ in 0 ..< 1 {
      frame_5ei.append("\(3)")
   }

return         String(displayName.prefix(1)).uppercased()
    }

    private static var baseProfilePosts: [SocFollowArlan] {
       var fansh: Int = 1
       var f_width4: [String: Any]! = [String(cString: [102,105,110,103,101,114,0], encoding: .utf8)!:UILabel()]
          var rightr: String! = String(cString: [108,97,116,101,98,105,110,100,105,110,103,115,121,109,98,111,108,116,97,98,108,101,0], encoding: .utf8)!
          var fromy: String! = String(cString: [103,117,97,114,97,110,116,101,101,115,0], encoding: .utf8)!
         f_width4 = [fromy: rightr.count]
      if f_width4.values.count > 2 {
         f_width4["\(f_width4.count)"] = f_width4.values.count
      }
         f_width4 = ["\(f_width4.values.count)": 2]
      fansh += 2 ^ f_width4.count

        if isTestAccount {
            return [
                SocFollowArlan(
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
       var tapF: String! = String(cString: [117,110,105,109,112,108,101,109,101,110,116,101,100,0], encoding: .utf8)!
    _ = tapF
    var storew: Double = 4.0
   withUnsafeMutablePointer(to: &storew) { pointer in
    
   }
       var optionsc: String! = String(cString: [105,109,112,108,0], encoding: .utf8)!
      withUnsafeMutablePointer(to: &optionsc) { pointer in
             _ = pointer.pointee
      }
       var mutuali: String! = String(cString: [109,117,108,116,105,102,114,97,109,101,0], encoding: .utf8)!
       var configurationi: [String: Any]! = [String(cString: [111,118,101,114,108,97,112,0], encoding: .utf8)!:[86, 8, 96]]
       var throw_j5h: [String: Any]! = [String(cString: [99,117,101,115,0], encoding: .utf8)!:[88, 26, 30]]
      while (optionsc != mutuali) {
         mutuali.append("\(1)")
         break
      }
         optionsc.append("\(((String(cString:[85,0], encoding: .utf8)!) == optionsc ? optionsc.count : configurationi.values.count))")
         optionsc.append("\(((String(cString:[118,0], encoding: .utf8)!) == optionsc ? optionsc.count : configurationi.values.count))")
      while (1 > (configurationi.keys.count * throw_j5h.values.count) && 2 > (throw_j5h.values.count * 1)) {
         throw_j5h = ["\(throw_j5h.keys.count)": configurationi.count]
         break
      }
      if optionsc == String(cString:[107,0], encoding: .utf8)! {
          var shouldP: Double = 4.0
          _ = shouldP
         mutuali = "\(mutuali.count | configurationi.keys.count)"
         shouldP -= Double(configurationi.keys.count)
      }
      tapF = "\(optionsc.count)"
   repeat {
       var buildD: String! = String(cString: [115,101,116,108,105,115,116,0], encoding: .utf8)!
       var lightR: Double = 0.0
       var happyB: Double = 2.0
       var optionsV: Double = 3.0
          var mailo: String! = String(cString: [110,97,109,101,115,0], encoding: .utf8)!
         lightR += (Double(Int(happyB > 17716902.0 || happyB < -17716902.0 ? 73.0 : happyB)))
         mailo = "\((buildD == (String(cString:[119,0], encoding: .utf8)!) ? buildD.count : Int(optionsV > 59084418.0 || optionsV < -59084418.0 ? 94.0 : optionsV)))"
       var buttong: Bool = true
      if 4.25 == (lightR + Double(buildD.count)) {
         buildD = "\((Int(optionsV > 83502369.0 || optionsV < -83502369.0 ? 78.0 : optionsV)))"
      }
          var contentq: String! = String(cString: [100,101,99,108,97,114,101,0], encoding: .utf8)!
          var update_q72: Double = 4.0
         buttong = contentq.count <= 95 && 70.68 <= optionsV
         update_q72 += Double(1 / (Swift.max(2, contentq.count)))
      while (1.40 < (happyB - 4.7) || 5.62 < (4.7 - lightR)) {
         lightR -= (Double(Int(lightR > 78606939.0 || lightR < -78606939.0 ? 56.0 : lightR) | 3))
         break
      }
          var repliesw: String! = String(cString: [99,103,105,109,97,103,101,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &repliesw) { pointer in
                _ = pointer.pointee
         }
          var overlapP: String! = String(cString: [103,97,108,108,101,114,121,0], encoding: .utf8)!
          _ = overlapP
         lightR /= Swift.max((Double(Int(optionsV > 246597537.0 || optionsV < -246597537.0 ? 94.0 : optionsV))), 2)
         repliesw.append("\(((buttong ? 5 : 3) ^ Int(lightR > 335953453.0 || lightR < -335953453.0 ? 97.0 : lightR)))")
         overlapP = "\(overlapP.count)"
          var deletedT: String! = String(cString: [97,116,101,120,105,116,0], encoding: .utf8)!
          _ = deletedT
         lightR += (Double(Int(optionsV > 362847228.0 || optionsV < -362847228.0 ? 10.0 : optionsV)))
         deletedT.append("\((2 << (Swift.min(3, labs(Int(happyB > 38594321.0 || happyB < -38594321.0 ? 63.0 : happyB))))))")
      if 1.83 > optionsV {
         optionsV /= Swift.max((Double((buttong ? 1 : 3) | Int(happyB > 272639855.0 || happyB < -272639855.0 ? 60.0 : happyB))), 5)
      }
      for _ in 0 ..< 3 {
         happyB /= Swift.max(5, Double(3))
      }
       var bubble7: String! = String(cString: [101,110,117,109,101,114,97,116,101,0], encoding: .utf8)!
          var messageZ: Double = 3.0
         withUnsafeMutablePointer(to: &messageZ) { pointer in
                _ = pointer.pointee
         }
          var largeI: Int = 0
          var storeG: String! = String(cString: [110,97,108,117,115,0], encoding: .utf8)!
         optionsV -= (Double(Int(lightR > 188899959.0 || lightR < -188899959.0 ? 38.0 : lightR) + storeG.count))
         messageZ /= Swift.max((Double(Int(lightR > 279145031.0 || lightR < -279145031.0 ? 16.0 : lightR) / (Swift.max(Int(happyB > 382703842.0 || happyB < -382703842.0 ? 32.0 : happyB), 3)))), 4)
         largeI >>= Swift.min(labs((Int(lightR > 114752748.0 || lightR < -114752748.0 ? 70.0 : lightR))), 3)
         lightR -= (Double(Int(optionsV > 386789662.0 || optionsV < -386789662.0 ? 82.0 : optionsV) | Int(lightR > 287735274.0 || lightR < -287735274.0 ? 87.0 : lightR)))
         bubble7.append("\(1)")
      storew -= Double(buildD.count)
      if storew == 2134373.0 {
         break
      }
   } while ((3.30 - storew) <= 3.68 && 3.30 <= (storew - storew)) && (storew == 2134373.0)

            return "\(YCleanerQ.displayNamePrefix).\(currentAccountKey)"
    }

    private static var avatarFileNameStorageKey: String {
       var collectionH: String! = String(cString: [115,99,97,108,97,98,108,101,0], encoding: .utf8)!
    var presentationu: Double = 1.0
   withUnsafeMutablePointer(to: &presentationu) { pointer in
    
   }
   for _ in 0 ..< 2 {
      collectionH = "\((Int(presentationu > 351467067.0 || presentationu < -351467067.0 ? 21.0 : presentationu)))"
   }
      collectionH.append("\((Int(presentationu > 287416206.0 || presentationu < -287416206.0 ? 83.0 : presentationu)))")

            return "\(YCleanerQ.avatarFileNamePrefix).\(currentAccountKey)"
    }

    private static var deletedPostIDsStorageKey: String {
       var postl: Float = 4.0
   for _ in 0 ..< 2 {
       var constraint4: Float = 3.0
       var home5: Double = 5.0
      withUnsafeMutablePointer(to: &home5) { pointer in
    
      }
       var signP: [Any]! = [false]
       var g_playerT: String! = String(cString: [104,115,99,97,108,101,114,0], encoding: .utf8)!
         signP = [(Int(constraint4 > 298606768.0 || constraint4 < -298606768.0 ? 99.0 : constraint4) % (Swift.max(signP.count, 1)))]
         g_playerT = "\((Int(home5 > 383192905.0 || home5 < -383192905.0 ? 88.0 : home5)))"
         g_playerT.append("\((Int(home5 > 186046430.0 || home5 < -186046430.0 ? 23.0 : home5)))")
          var option1: Double = 5.0
          var rect4: String! = String(cString: [97,108,112,104,97,110,117,109,101,114,105,99,0], encoding: .utf8)!
          _ = rect4
         signP = [2]
         option1 -= Double(3 - signP.count)
         rect4.append("\((Int(option1 > 346041112.0 || option1 < -346041112.0 ? 51.0 : option1) * Int(home5 > 244027143.0 || home5 < -244027143.0 ? 89.0 : home5)))")
         signP.append(3)
          var tags9: Double = 5.0
          var queuen: Float = 1.0
         g_playerT.append("\(g_playerT.count)")
         tags9 -= (Double(2 % (Swift.max(Int(tags9 > 225578177.0 || tags9 < -225578177.0 ? 21.0 : tags9), 4))))
         queuen -= Float(2)
      repeat {
          var dcopy_9T: String! = String(cString: [99,97,109,101,108,108,105,97,0], encoding: .utf8)!
          _ = dcopy_9T
          var stylet: [Any]! = [75]
         withUnsafeMutablePointer(to: &stylet) { pointer in
                _ = pointer.pointee
         }
          var errorU: Double = 2.0
          var subtitleO: Double = 5.0
         withUnsafeMutablePointer(to: &subtitleO) { pointer in
                _ = pointer.pointee
         }
         g_playerT = "\((Int(home5 > 181686917.0 || home5 < -181686917.0 ? 100.0 : home5) << (Swift.min(2, labs(Int(constraint4 > 25505294.0 || constraint4 < -25505294.0 ? 80.0 : constraint4))))))"
         dcopy_9T.append("\(signP.count * 2)")
         stylet.append(g_playerT.count)
         errorU -= (Double(Int(subtitleO > 243056545.0 || subtitleO < -243056545.0 ? 6.0 : subtitleO)))
         subtitleO += (Double(1 | Int(constraint4 > 23205138.0 || constraint4 < -23205138.0 ? 44.0 : constraint4)))
         if (String(cString:[105,104,122,0], encoding: .utf8)!) == g_playerT {
            break
         }
      } while (4.88 <= (5.67 / (Swift.max(1, constraint4)))) && ((String(cString:[105,104,122,0], encoding: .utf8)!) == g_playerT)
         constraint4 /= Swift.max(4, Float(g_playerT.count))
      postl -= (Float(3 << (Swift.min(labs(Int(constraint4 > 350901139.0 || constraint4 < -350901139.0 ? 88.0 : constraint4)), 2))))
   }

            return "\(YCleanerQ.deletedPostIDsPrefix).\(currentAccountKey)"
    }

    private static var deletedPostIDs: Set<String> {
       var now6: String! = String(cString: [117,110,98,111,120,101,100,0], encoding: .utf8)!
    var release_gN: Double = 1.0
    _ = release_gN
   while (Double(now6.count) <= release_gN) {
      release_gN -= Double(2)
      break
   }
       var path4: String! = String(cString: [119,97,107,101,0], encoding: .utf8)!
       _ = path4
      if 4 < path4.count {
         path4 = "\(path4.count & path4.count)"
      }
         path4.append("\(path4.count % 3)")
         path4 = "\(path4.count)"
      release_gN += Double(2)

            return Set(UserDefaults.standard.stringArray(forKey: deletedPostIDsStorageKey) ?? [])
      now6.append("\(3 | now6.count)")
    }

    private static var currentAccountKey: String {
       var add3: String! = String(cString: [112,114,101,100,0], encoding: .utf8)!
    var listeny: Double = 4.0
    var sharingc: [String: Any]! = [String(cString: [100,114,97,103,103,105,110,103,0], encoding: .utf8)!:0, String(cString: [112,97,108,109,0], encoding: .utf8)!:37, String(cString: [115,117,98,116,114,97,99,116,105,111,110,0], encoding: .utf8)!:11]
       var local_kh3: [String: Any]! = [String(cString: [99,111,114,111,117,116,105,110,101,0], encoding: .utf8)!:8.0]
      for _ in 0 ..< 2 {
         local_kh3 = ["\(local_kh3.keys.count)": local_kh3.count ^ local_kh3.keys.count]
      }
      while ((1 * local_kh3.values.count) == 5 && 1 == (local_kh3.keys.count * local_kh3.values.count)) {
         local_kh3 = ["\(local_kh3.values.count)": local_kh3.count]
         break
      }
      while ((1 - local_kh3.values.count) <= 5) {
          var maleD: String! = String(cString: [109,100,104,100,0], encoding: .utf8)!
          var closez: [Any]! = [91, 26]
          var layout1: Double = 0.0
         local_kh3 = ["\(local_kh3.count)": closez.count]
         maleD = "\(1 + closez.count)"
         layout1 -= (Double(Int(layout1 > 70539844.0 || layout1 < -70539844.0 ? 94.0 : layout1) * 2))
         break
      }
      add3 = "\(add3.count)"

            return (SocLoginCache.currentEmail ?? "guest")
            .lowercased()
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_")
      sharingc = ["\(sharingc.values.count)": ((String(cString:[49,0], encoding: .utf8)!) == add3 ? sharingc.count : add3.count)]
       var playl: Float = 1.0
         playl += (Float(Int(playl > 12228673.0 || playl < -12228673.0 ? 76.0 : playl) + 1))
      while (1.96 < playl) {
          var avatarl: String! = String(cString: [101,110,104,97,110,99,101,114,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &avatarl) { pointer in
                _ = pointer.pointee
         }
          var local_tO: String! = String(cString: [110,119,105,115,101,0], encoding: .utf8)!
          _ = local_tO
          var duration3: Int = 1
          var min_pn: String! = String(cString: [100,101,99,111,100,101,114,105,110,105,116,0], encoding: .utf8)!
          _ = min_pn
         playl /= Swift.max(Float(duration3), 5)
         avatarl = "\(3 * duration3)"
         local_tO.append("\(avatarl.count)")
         min_pn.append("\(((String(cString:[68,0], encoding: .utf8)!) == avatarl ? duration3 : avatarl.count))")
         break
      }
         playl += (Float(Int(playl > 14876367.0 || playl < -14876367.0 ? 91.0 : playl) >> (Swift.min(3, labs(1)))))
      listeny += (Double(Int(playl > 24611904.0 || playl < -24611904.0 ? 13.0 : playl)))
    }

    private static var defaultDisplayName: String {
       var companionL: String! = String(cString: [108,95,50,52,0], encoding: .utf8)!
   while (!companionL.hasSuffix(companionL)) {
      companionL.append("\(companionL.count | 3)")
      break
   }

            return isTestAccount ? "Psai" : "Williams"
    }

    private static var defaultAvatarImage: UIImage? {
       var emotion1: Bool = false
    _ = emotion1
      emotion1 = (!emotion1 ? !emotion1 : !emotion1)

        guard isTestAccount else { return nil }

        return UIImage(named: "EmotionSync/PostAvatars/emotion_post_avatar_psai")
    }

    private static var defaultSlogan: String {
       var resignI: String! = String(cString: [109,111,100,101,99,111,115,116,115,0], encoding: .utf8)!
    var selectedS: [Any]! = [41, 14, 56]
      selectedS = [2]

            return isTestAccount ?
            "A small flower can still make the\nwhole road feel softer." :
            "Love is not a matter of counting the\ndays. It'smaking the days count."
   if (2 + selectedS.count) == 5 || 2 == (2 + resignI.count) {
      resignI.append("\(1)")
   }
    }

    private static var isTestAccount: Bool {
       var storedw: Double = 1.0
    var session9: String! = String(cString: [100,105,115,112,97,116,99,104,101,100,0], encoding: .utf8)!
      session9.append("\((Int(storedw > 316636478.0 || storedw < -316636478.0 ? 8.0 : storedw)))")
   if (storedw + storedw) >= 1.41 {
      storedw -= (Double(Int(storedw > 215294865.0 || storedw < -215294865.0 ? 22.0 : storedw)))
   }

            return SocLoginCache.currentEmail?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "sockes333@gmail.com"
    }

    private static func avatarFileURL(fileName: String) -> URL {
       var originalK: Bool = true
   withUnsafeMutablePointer(to: &originalK) { pointer in
          _ = pointer.pointee
   }
      originalK = (!originalK ? !originalK : !originalK)

return         FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }

}
