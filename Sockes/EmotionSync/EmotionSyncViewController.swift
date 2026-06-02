//
//  EmotionSyncViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/2.
//

import UIKit

struct EmotionPost {
    let name: String
    let time: String
    let content: String
    let avatarColor: UIColor
    let photoColors: [UIColor]
}

final class EmotionSyncViewController: UIViewController {

    private enum Asset {
        static let headerBackground = "EmotionSync/emotion_sync_header_background"
        static let moodBottleCard = "EmotionSync/emotion_sync_mood_bottle_card"
        static let shareEmotionsCard = "EmotionSync/emotion_sync_share_emotions_card"
    }

    private let tableView = UITableView(frame: .zero, style: .plain)

    private let posts: [EmotionPost] = [
        EmotionPost(
            name: "Simo",
            time: "1 min ago",
            content: "Love is not a matter of counting the days. It's making the days count.",
            avatarColor: UIColor(red: 0.98, green: 0.82, blue: 0.55, alpha: 1),
            photoColors: [
                UIColor(red: 0.74, green: 0.88, blue: 0.68, alpha: 1),
                UIColor(red: 0.72, green: 0.82, blue: 0.95, alpha: 1)
            ]
        ),
        EmotionPost(
            name: "Arlan",
            time: "10 min ago",
            content: "Don't be discouraged; it's often the last key in the bunch that opens the lock.",
            avatarColor: UIColor(red: 0.84, green: 0.66, blue: 0.90, alpha: 1),
            photoColors: [
                UIColor(red: 0.80, green: 0.90, blue: 0.72, alpha: 1),
                UIColor(red: 0.96, green: 0.76, blue: 0.82, alpha: 1)
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupTopContent()
    }

    private func setupBackground() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)
    }

    private func setupTopContent() {
        let headerImageView = UIImageView(image: UIImage(named: Asset.headerBackground))
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerImageView)

        let moodBottleView = UIImageView(image: UIImage(named: Asset.moodBottleCard))
        moodBottleView.contentMode = .scaleAspectFit
        moodBottleView.isUserInteractionEnabled = true
        moodBottleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMoodBottlePage)))
        moodBottleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moodBottleView)

        let shareEmotionsView = UIImageView(image: UIImage(named: Asset.shareEmotionsCard))
        shareEmotionsView.contentMode = .scaleAspectFit
        shareEmotionsView.isUserInteractionEnabled = true
        shareEmotionsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showShareEmotionsPage)))
        shareEmotionsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shareEmotionsView)
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 248
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EmotionPostCell.self, forCellReuseIdentifier: EmotionPostCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.21),

            moodBottleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            moodBottleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            moodBottleView.widthAnchor.constraint(equalToConstant: 170),
            moodBottleView.heightAnchor.constraint(equalToConstant: 92),

            shareEmotionsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            shareEmotionsView.topAnchor.constraint(equalTo: moodBottleView.topAnchor),
            shareEmotionsView.widthAnchor.constraint(equalToConstant: 170),
            shareEmotionsView.heightAnchor.constraint(equalToConstant: 92),
            
            tableView.topAnchor.constraint(equalTo: moodBottleView.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func showMoodBottlePage() {
        let viewController = MoodBottleViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @objc private func showShareEmotionsPage() {
        let viewController = ShareEmotionsViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

}

extension EmotionSyncViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: EmotionPostCell.reuseIdentifier,
            for: indexPath
        ) as? EmotionPostCell
        cell?.configure(with: posts[indexPath.row])
        cell?.onAvatarTap = { [weak self] in
            guard let self else { return }

            let viewController = EmotionUserProfileViewController(post: self.posts[indexPath.row])
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
        cell?.onAlertTap = { [weak self] sourceView in
            self?.showEmotionReportMenu(from: sourceView)
        }
        return cell ?? UITableViewCell()
    }

}

extension EmotionSyncViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewController = EmotionPostDetailViewController(post: posts[indexPath.row])
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

}
