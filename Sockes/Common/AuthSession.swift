//
//  AuthSession.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import Foundation

enum AuthSession {

    private enum Key {
        static let isLoggedIn = "auth.isLoggedIn"
        static let currentEmail = "auth.currentEmail"
    }

    static var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: Key.isLoggedIn)
    }

    static var currentEmail: String? {
        UserDefaults.standard.string(forKey: Key.currentEmail)
    }

    static func markLoggedIn(email: String) {
        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        UserDefaults.standard.set(true, forKey: Key.isLoggedIn)
        UserDefaults.standard.set(normalizedEmail, forKey: Key.currentEmail)
    }

    static func markLoggedOut() {
        UserDefaults.standard.set(false, forKey: Key.isLoggedIn)
        UserDefaults.standard.removeObject(forKey: Key.currentEmail)
    }

}
