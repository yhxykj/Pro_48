//
//  CoinBalanceStore.swift
//  Sockes
//
//  Created by Codex on 2026/6/26.
//

import Foundation

enum CoinBalanceStore {

    private enum StorageKey {
        static let coinBalance = "profile.coinBalance"
    }

    private enum DefaultValue {
        static let coinBalance = 100
    }

    static var balance: Int {
        guard UserDefaults.standard.object(forKey: StorageKey.coinBalance) != nil else {
            UserDefaults.standard.set(DefaultValue.coinBalance, forKey: StorageKey.coinBalance)
            return DefaultValue.coinBalance
        }

        return UserDefaults.standard.integer(forKey: StorageKey.coinBalance)
    }

    static func add(_ coins: Int) -> Int {
        let updatedBalance = balance + coins
        UserDefaults.standard.set(updatedBalance, forKey: StorageKey.coinBalance)
        return updatedBalance
    }

    static func spend(_ coins: Int) -> Bool {
        let currentBalance = balance
        guard currentBalance >= coins else { return false }

        UserDefaults.standard.set(currentBalance - coins, forKey: StorageKey.coinBalance)
        return true
    }

}
