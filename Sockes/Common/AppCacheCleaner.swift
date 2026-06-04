//
//  AppCacheCleaner.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/4.
//

import Foundation
import WebKit

enum AppCacheCleaner {

    static func clearAll(completion: (() -> Void)? = nil) {
        clearUserDefaults()
        clearURLCache()
        clearCookies()
        clearLocalFiles()
        clearWebData(completion: completion)
    }

    private static func clearUserDefaults() {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }

        UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        UserDefaults.standard.synchronize()
    }

    private static func clearURLCache() {
        URLCache.shared.removeAllCachedResponses()
    }

    private static func clearCookies() {
        HTTPCookieStorage.shared.cookies?.forEach {
            HTTPCookieStorage.shared.deleteCookie($0)
        }
    }

    private static func clearLocalFiles() {
        let fileManager = FileManager.default

        if let cachesURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            removeContents(of: cachesURL)
        }

        removeContents(of: fileManager.temporaryDirectory)
        removeSavedProfileAvatars()
    }

    private static func clearWebData(completion: (() -> Void)?) {
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
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first,
              let fileURLs = try? fileManager.contentsOfDirectory(
                at: documentsURL,
                includingPropertiesForKeys: nil
              ) else { return }

        fileURLs
            .filter { $0.lastPathComponent.hasSuffix("_profile_avatar.jpg") }
            .forEach { try? fileManager.removeItem(at: $0) }
    }

    private static func removeContents(of folderURL: URL) {
        let fileManager = FileManager.default
        guard let fileURLs = try? fileManager.contentsOfDirectory(
            at: folderURL,
            includingPropertiesForKeys: nil
        ) else { return }

        fileURLs.forEach { try? fileManager.removeItem(at: $0) }
    }

}
