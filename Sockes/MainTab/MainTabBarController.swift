//
//  MainTabBarController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/1.
//

import UIKit

final class MainTabBarController: UITabBarController {

    private enum Asset {
        static let homeNormal = "MainTab/tab_home_normal"
        static let homeSelected = "MainTab/tab_home_selected"
        static let healNormal = "MainTab/tab_heal_normal"
        static let healSelected = "MainTab/tab_heal_selected"
        static let chatNormal = "MainTab/tab_chat_normal"
        static let chatSelected = "MainTab/tab_chat_selected"
        static let profileNormal = "MainTab/tab_profile_normal"
        static let profileSelected = "MainTab/tab_profile_selected"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        setupTabBarStyle()
    }

    private func setupViewControllers() {
        viewControllers = [
            makeTabPage(
                viewController: HomeViewController(),
                title: "首页",
                normalImageName: Asset.homeNormal,
                selectedImageName: Asset.homeSelected
            ),
            makeTabPage(
                viewController: EmotionSyncViewController(),
                title: "疗愈",
                normalImageName: Asset.healNormal,
                selectedImageName: Asset.healSelected
            ),
            makeTabPage(
                viewController: MessageViewController(),
                title: "消息",
                normalImageName: Asset.chatNormal,
                selectedImageName: Asset.chatSelected
            ),
            makeTabPage(
                viewController: ProfileViewController(),
                title: "我的",
                normalImageName: Asset.profileNormal,
                selectedImageName: Asset.profileSelected
            )
        ]
    }

    private func setupTabBarStyle() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        tabBar.isTranslucent = false

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        itemAppearance.selected.iconColor = .black
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.clear]
        itemAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 100)
        itemAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 100)

        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }

    private func makeTabPage(
        viewController: UIViewController,
        title: String,
        normalImageName: String,
        selectedImageName: String
    ) -> UIViewController {
        viewController.view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let item = UITabBarItem(
            title: nil,
            image: UIImage(named: normalImageName)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        )
        item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        item.accessibilityLabel = title
        viewController.tabBarItem = item

        return viewController
    }

}
