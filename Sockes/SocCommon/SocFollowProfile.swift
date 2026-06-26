
import UIKit

import Foundation
import WebKit

enum SocFollowProfile {

    static func clearAll(completion: (() -> Void)? = nil) {
       var markH: String! = String(cString: [99,111,112,105,101,100,0], encoding: .utf8)!
       var ringD: Double = 3.0
       var snewsM: Bool = true
         snewsM = ringD >= 61.80 && !snewsM
      repeat {
         snewsM = 35.22 <= ringD || !snewsM
         if snewsM ? !snewsM : snewsM {
            break
         }
      } while (snewsM ? !snewsM : snewsM) && (snewsM && (3.1 / (Swift.max(8, ringD))) == 3.36)
          var retry3: Double = 3.0
         withUnsafeMutablePointer(to: &retry3) { pointer in
    
         }
         snewsM = ringD > 87.42 && snewsM
         retry3 += (Double((snewsM ? 2 : 1) - Int(ringD > 283581235.0 || ringD < -283581235.0 ? 59.0 : ringD)))
      while ((ringD / 5.59) <= 3.36) {
         ringD += (Double(Int(ringD > 108540944.0 || ringD < -108540944.0 ? 92.0 : ringD) >> (Swift.min(3, labs(3)))))
         break
      }
      while (5.68 > (ringD - 4.70) || 4.70 > ringD) {
          var callD: Float = 1.0
         withUnsafeMutablePointer(to: &callD) { pointer in
    
         }
         ringD += (Double(2 & Int(callD > 342291384.0 || callD < -342291384.0 ? 5.0 : callD)))
         break
      }
         snewsM = ringD > 42.98
      markH = "\(((snewsM ? 5 : 2) / (Swift.max(Int(ringD > 112420708.0 || ringD < -112420708.0 ? 25.0 : ringD), 7))))"

        clearUserDefaults()
        clearURLCache()
        clearCookies()
        clearLocalFiles()
        clearWebData(completion: completion)
    }

    private static func clearUserDefaults() {
       var observationU: Bool = false
   withUnsafeMutablePointer(to: &observationU) { pointer in
          _ = pointer.pointee
   }
   for _ in 0 ..< 2 {
       var settingy: Float = 4.0
          var emotionT: Float = 3.0
          var bannerW: String! = String(cString: [111,118,101,114,108,97,121,105,110,103,0], encoding: .utf8)!
          var keyboard9: Float = 3.0
         settingy -= (Float(Int(emotionT > 74938668.0 || emotionT < -74938668.0 ? 46.0 : emotionT)))
         bannerW.append("\((Int(settingy > 379210800.0 || settingy < -379210800.0 ? 94.0 : settingy)))")
         keyboard9 /= Swift.max((Float(Int(settingy > 171138951.0 || settingy < -171138951.0 ? 8.0 : settingy) - Int(emotionT > 384193468.0 || emotionT < -384193468.0 ? 92.0 : emotionT))), 1)
          var callj: [Any]! = [72]
         settingy += Float(2)
         callj.append(3)
          var delete_rom: Int = 4
          _ = delete_rom
         settingy -= Float(2)
         delete_rom &= (delete_rom - Int(settingy > 82005357.0 || settingy < -82005357.0 ? 49.0 : settingy))
      observationU = !observationU
   }

        guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }

        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        UserDefaults.standard.synchronize()
    }

    private static func clearURLCache() {
       var profilel: Int = 2
    _ = profilel
    var fallback1: String! = String(cString: [120,109,117,108,116,105,112,108,101,0], encoding: .utf8)!
   withUnsafeMutablePointer(to: &fallback1) { pointer in
    
   }
      profilel -= 2 * fallback1.count
   repeat {
       var packages5: Float = 3.0
          var resultf: String! = String(cString: [101,120,112,97,110,100,101,100,0], encoding: .utf8)!
         withUnsafeMutablePointer(to: &resultf) { pointer in
    
         }
          var user9: Int = 1
         packages5 -= Float(user9 ^ resultf.count)
         packages5 += (Float(Int(packages5 > 213715871.0 || packages5 < -213715871.0 ? 6.0 : packages5) | 3))
          var stack7: Int = 5
         withUnsafeMutablePointer(to: &stack7) { pointer in
    
         }
         packages5 -= (Float(stack7 >> (Swift.min(labs(Int(packages5 > 202562690.0 || packages5 < -202562690.0 ? 69.0 : packages5)), 5))))
      profilel -= 2 % (Swift.max(7, fallback1.count))
      if 1976623 == profilel {
         break
      }
   } while ((1 >> (Swift.min(3, labs(profilel)))) >= 4) && (1976623 == profilel)

        URLCache.shared.removeAllCachedResponses()
    }

    private static func clearCookies() {
       var datat: Double = 4.0
    _ = datat
    var micm: String! = String(cString: [97,99,114,111,110,121,109,115,0], encoding: .utf8)!
   withUnsafeMutablePointer(to: &micm) { pointer in
          _ = pointer.pointee
   }
   if micm.count == 3 {
      datat += (Double(Int(datat > 41974959.0 || datat < -41974959.0 ? 94.0 : datat)))
   }

   for _ in 0 ..< 3 {
      datat -= Double(micm.count)
   }
        HTTPCookieStorage.shared.cookies?.forEach {
            HTTPCookieStorage.shared.deleteCookie($0)
        }
    }

    private static func clearLocalFiles() {
       var based: Float = 0.0
    _ = based
    var modeE: String! = String(cString: [109,101,100,105,117,109,0], encoding: .utf8)!
      based -= (Float(Int(based > 24860968.0 || based < -24860968.0 ? 5.0 : based) / 2))

   if 3 < modeE.count {
      modeE = "\(2)"
   }
        let scroll = FileManager.default

        if let cachesURL = scroll.urls(for: .cachesDirectory, in: .userDomainMask).first {
            removeContents(of: cachesURL)
        }

        removeContents(of: scroll.temporaryDirectory)
        removeSavedProfileAvatars()
    }

    private static func clearWebData(completion: (() -> Void)?) {
       var arlana: String! = String(cString: [115,116,114,108,99,97,116,0], encoding: .utf8)!
    var reusef: String! = String(cString: [116,105,116,108,116,101,0], encoding: .utf8)!
   withUnsafeMutablePointer(to: &reusef) { pointer in
    
   }
      reusef = "\((arlana == (String(cString:[56,0], encoding: .utf8)!) ? arlana.count : reusef.count))"

       var authb: Double = 4.0
       _ = authb
       var menuE: Double = 3.0
         menuE -= (Double(Int(menuE > 99818752.0 || menuE < -99818752.0 ? 75.0 : menuE) & Int(authb > 6758606.0 || authb < -6758606.0 ? 36.0 : authb)))
      while (5.20 >= (2.6 * menuE)) {
         menuE /= Swift.max(Double(2), 4)
         break
      }
       var settingsm: [Any]! = [23, 7]
       var williamsX: [Any]! = [[String(cString: [100,121,110,97,109,105,99,0], encoding: .utf8)!:69, String(cString: [114,111,117,110,100,110,101,115,115,0], encoding: .utf8)!:99, String(cString: [114,97,98,98,105,116,0], encoding: .utf8)!:99]]
      if 1.25 >= (Double(williamsX.count) + menuE) && (menuE + 1.25) >= 1.4 {
          var sloganO: Bool = false
         withUnsafeMutablePointer(to: &sloganO) { pointer in
    
         }
          var presenterr: String! = String(cString: [112,114,101,102,101,114,101,110,99,101,0], encoding: .utf8)!
          var sessionU: Float = 1.0
          _ = sessionU
         menuE += Double(1)
         sloganO = authb > 90.18
         presenterr = "\((3 << (Swift.min(4, labs((sloganO ? 4 : 3))))))"
         sessionU += Float(williamsX.count + 3)
      }
         authb -= Double(settingsm.count)
       var configurationC: Double = 0.0
       var recommendD: Double = 3.0
         configurationC -= (Double(Int(recommendD > 144121413.0 || recommendD < -144121413.0 ? 33.0 : recommendD) / (Swift.max(7, Int(menuE > 208327247.0 || menuE < -208327247.0 ? 32.0 : menuE)))))
         recommendD /= Swift.max(5, Double(3))
      arlana.append("\(1 | arlana.count)")
        WKWebsiteDataStore.default().removeData(
            ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
            modifiedSince: .distantPast
        ) {
            DispatchQueue.main.async {
                completion?()
            }
        }
    }

    private static func removeSavedProfileAvatars() {
       var select7: [Any]! = [true]
    var observationY: Float = 1.0
   for _ in 0 ..< 3 {
      observationY -= Float(2)
   }

      select7 = [select7.count & select7.count]
        let scroll = FileManager.default
        guard let documentsURL = scroll.urls(for: .documentDirectory, in: .userDomainMask).first,
              let post = try? scroll.contentsOfDirectory(
                at: documentsURL,
                includingPropertiesForKeys: nil
              ) else { return }

        post
            .filter { $0.lastPathComponent.hasSuffix("_profile_avatar.jpg") }
            .forEach { try? scroll.removeItem(at: $0) }
    }

    private static func removeContents(of folderURL: URL) {
       var emptyx: Bool = true
      emptyx = (emptyx ? emptyx : emptyx)

        let scroll = FileManager.default
        guard let fileURLs = try? scroll.contentsOfDirectory(
            at: folderURL,
            includingPropertiesForKeys: nil
        ) else { return }

        fileURLs.forEach { try? scroll.removeItem(at: $0) }
    }

}
