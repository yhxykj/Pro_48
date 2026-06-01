//
//  HomeViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/1.
//

import UIKit

struct HomeCompanion {
    let name: String
    let tags: [String]
    let message: String
    let color: UIColor
}

final class HomeViewController: UIViewController {

    private enum Asset {
        static let headerBackground = "Home/home_header_background"
        static let faceLarge = "Home/home_face_large"
        static let recommendHeader = "Home/home_recommend_header"
        static let unlockDialog = "Home/home_unlock_dialog"
    }

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var needsUnlock = true
    private var pendingChatIndexPath: IndexPath?
    private weak var unlockOverlayView: UIView?

    private let companions: [HomeCompanion] = [
        HomeCompanion(
            name: "Liony",
            tags: ["Gentle", "Listener"],
            message: "Can you tell me what's bothering\nyou and see if T can help you",
            color: UIColor(red: 0.78, green: 0.88, blue: 1.00, alpha: 1)
        ),
        HomeCompanion(
            name: "Wendy",
            tags: ["Cute", "Friendly"],
            message: "Do you also like small animals\nthatheal the soul?",
            color: UIColor(red: 1.00, green: 0.91, blue: 0.68, alpha: 1)
        ),
        HomeCompanion(
            name: "Kair",
            tags: ["Pure", "Loyalty"],
            message: "Do you want to take a walk alone\nbythe seaside in summer?",
            color: UIColor(red: 0.83, green: 0.90, blue: 0.80, alpha: 1)
        ),
        HomeCompanion(
            name: "Kioet",
            tags: ["Kind", "Wonderful"],
            message: "The sunshine is perfect today,\nlet's share a little smile.",
            color: UIColor(red: 1.00, green: 0.82, blue: 0.78, alpha: 1)
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHeader()
        setupTableView()
    }

    private func setupHeader() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let headerBackgroundView = UIImageView(image: UIImage(named: Asset.headerBackground))
        headerBackgroundView.contentMode = .scaleAspectFill
        headerBackgroundView.clipsToBounds = true
        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerBackgroundView)

        let healingBackLabel = UILabel()
        healingBackLabel.text = "AI HEALING"
        healingBackLabel.font = .systemFont(ofSize: 32, weight: .black)
        healingBackLabel.textColor = UIColor.white.withAlphaComponent(0.45)
        healingBackLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(healingBackLabel)

        let titleLabel = UILabel()
        titleLabel.text = "AI HEALING"
        titleLabel.font = .systemFont(ofSize: 33, weight: .black)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        let subtitleLabel = UILabel()
        subtitleLabel.text = "RELAXINC MOMENT"
        subtitleLabel.font = .systemFont(ofSize: 24, weight: .black)
        subtitleLabel.textColor = .black
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)

        let bubbleLabel = UILabel()
        bubbleLabel.text = "Hello ! Welcome"
        bubbleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        bubbleLabel.textColor = UIColor(red: 0.52, green: 1.00, blue: 0.87, alpha: 1)
        bubbleLabel.textAlignment = .center
        bubbleLabel.backgroundColor = UIColor(red: 0.06, green: 0.11, blue: 0.10, alpha: 1)
        bubbleLabel.layer.cornerRadius = 10
        bubbleLabel.layer.masksToBounds = true
        bubbleLabel.transform = CGAffineTransform(rotationAngle: -0.22)
        bubbleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bubbleLabel)

        let faceView = UIImageView(image: UIImage(named: Asset.faceLarge))
        faceView.contentMode = .scaleAspectFit
        faceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(faceView)

        let recommendHeaderView = UIImageView(image: UIImage(named: Asset.recommendHeader))
        recommendHeaderView.contentMode = .scaleAspectFit
        recommendHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recommendHeaderView)

        NSLayoutConstraint.activate([
            headerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            headerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerBackgroundView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.207),

            healingBackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -12),
            healingBackLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 96),

            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 122),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),

            bubbleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            bubbleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            bubbleLabel.widthAnchor.constraint(equalToConstant: 116),
            bubbleLabel.heightAnchor.constraint(equalToConstant: 34),

            faceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38),
            faceView.topAnchor.constraint(equalTo: view.topAnchor, constant: 156),
            faceView.widthAnchor.constraint(equalToConstant: 83),
            faceView.heightAnchor.constraint(equalToConstant: 83),

            recommendHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            recommendHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            recommendHeaderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 246),
            recommendHeaderView.heightAnchor.constraint(equalToConstant: 121)
        ])
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(HomeCompanionCell.self, forCellReuseIdentifier: HomeCompanionCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 305),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func showUnlockDialog() {
        guard unlockOverlayView == nil else { return }

        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        let presentationView: UIView = tabBarController?.view ?? view
        presentationView.addSubview(overlayView)
        unlockOverlayView = overlayView

        let dialogView = UIImageView(image: UIImage(named: Asset.unlockDialog))
        dialogView.contentMode = .scaleAspectFit
        dialogView.isUserInteractionEnabled = true
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(dialogView)

        let yesButton = UIButton(type: .custom)
        yesButton.addTarget(self, action: #selector(confirmUnlock), for: .touchUpInside)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addSubview(yesButton)

        let noButton = UIButton(type: .custom)
        noButton.addTarget(self, action: #selector(closeUnlockDialog), for: .touchUpInside)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        dialogView.addSubview(noButton)

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: presentationView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: presentationView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: presentationView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: presentationView.bottomAnchor),

            dialogView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            dialogView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            dialogView.widthAnchor.constraint(equalToConstant: 310),
            dialogView.heightAnchor.constraint(equalToConstant: 413),

            yesButton.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 54),
            yesButton.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -54),
            yesButton.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 289),
            yesButton.heightAnchor.constraint(equalToConstant: 48),

            noButton.leadingAnchor.constraint(equalTo: yesButton.leadingAnchor),
            noButton.trailingAnchor.constraint(equalTo: yesButton.trailingAnchor),
            noButton.topAnchor.constraint(equalTo: yesButton.bottomAnchor, constant: 6),
            noButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func confirmUnlock() {
        needsUnlock = false
        closeUnlockDialog()
        showChatPage()
    }

    @objc private func closeUnlockDialog() {
        unlockOverlayView?.removeFromSuperview()
        pendingChatIndexPath = nil
    }

    private func showChatPage() {
        pendingChatIndexPath = nil
        let chatViewController = ChatViewController()
        chatViewController.modalPresentationStyle = .fullScreen
        present(chatViewController, animated: true)
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        companions.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: HomeCompanionCell.reuseIdentifier,
            for: indexPath
        )
        guard let companionCell = cell as? HomeCompanionCell else {
            return cell
        }

        companionCell.configure(with: companions[indexPath.row])
        return companionCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if needsUnlock {
            pendingChatIndexPath = indexPath
            showUnlockDialog()
        } else {
            showChatPage()
        }
    }

}
