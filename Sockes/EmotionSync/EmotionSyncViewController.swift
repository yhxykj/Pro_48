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
    let avatarImageName: String
    let photoImageNames: [String]
    let profileVideoFileName: String
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
            time: "Jun 04",
            content: "Love is not a matter of counting the days. It's making the days count.",
            avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_simo",
            photoImageNames: [
                "EmotionSync/PostPhotos/emotion_post_photo_sunset_lake",
                "EmotionSync/PostPhotos/emotion_post_photo_window"
            ],
            profileVideoFileName: "profile_male_video_simo"
        ),
        EmotionPost(
            name: "Arlan",
            time: "Jun 04",
            content: "Don't be discouraged; it's often the last key in the bunch that opens the lock.",
            avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_arlan",
            photoImageNames: [
                "EmotionSync/PostPhotos/emotion_post_photo_coast",
                "EmotionSync/PostPhotos/emotion_post_photo_warm_light"
            ],
            profileVideoFileName: "profile_female_video_arlan"
        ),
        EmotionPost(
            name: "Williams",
            time: "Jun 04",
            content: "Life is like a box of chocolates, you never know what you're gonna get.",
            avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_williams",
            photoImageNames: [
                "EmotionSync/PostPhotos/emotion_post_photo_city_sky",
                "EmotionSync/PostPhotos/emotion_post_photo_lamp"
            ],
            profileVideoFileName: "profile_male_video_williams"
        ),
        EmotionPost(
            name: "Perla",
            time: "Jun 03",
            content: "Let the evening light carry away the heavy thoughts for a while.",
            avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_perla",
            photoImageNames: [
                "EmotionSync/PostPhotos/emotion_post_photo_evening_street"
            ],
            profileVideoFileName: "profile_female_video_perla"
        ),
        EmotionPost(
            name: "Nue",
            time: "Jun 03",
            content: "Some quiet moments are also gentle answers from the day.",
            avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_nue",
            photoImageNames: [
                "EmotionSync/PostPhotos/emotion_post_photo_blur_light"
            ],
            profileVideoFileName: "profile_male_video_nue"
        ),
        EmotionPost(
            name: "Psai",
            time: "Jun 02",
            content: "A small flower can still make the whole road feel softer.",
            avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_psai",
            photoImageNames: [
                "EmotionSync/PostPhotos/emotion_post_photo_flowers"
            ],
            profileVideoFileName: "profile_male_video_psai"
        ),
        EmotionPost(
            name: "Kari",
            time: "Jun 02",
            content: "Rain on the window sounds like the city taking a deep breath.",
            avatarImageName: "EmotionSync/PostAvatars/emotion_post_avatar_kari",
            photoImageNames: [
                "EmotionSync/PostPhotos/emotion_post_photo_rain_window"
            ],
            profileVideoFileName: "profile_female_video_kari"
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupTopContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
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
        visiblePosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: EmotionPostCell.reuseIdentifier,
            for: indexPath
        ) as? EmotionPostCell
        let post = visiblePosts[indexPath.row]
        cell?.configure(with: post)
        cell?.onAvatarTap = { [weak self] in
            guard let self else { return }
            guard !UserBlockStore.isBlocked(name: post.name) else {
                self.showBlockedUserAlert()
                return
            }

            let viewController = EmotionUserProfileViewController(post: post)
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
        cell?.onAlertTap = { [weak self] sourceView in
            self?.showReportMenu(from: sourceView, for: post)
        }
        cell?.onVideoTap = { [weak self] in
            guard let self else { return }

            self.showVideoCallPage(for: post)
        }
        cell?.onMailTap = { [weak self] in
            guard let self else { return }

            self.showMessageChatPage(for: post)
        }
        return cell ?? UITableViewCell()
    }

}

extension EmotionSyncViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let post = visiblePosts[indexPath.row]
        guard !UserBlockStore.isBlocked(name: post.name) else {
            showBlockedUserAlert()
            return
        }

        let viewController = EmotionPostDetailViewController(post: post)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    private func showVideoCallPage(for post: EmotionPost) {
        guard !UserBlockStore.isBlocked(name: post.name) else {
            showBlockedUserAlert()
            return
        }

        let viewController = MessageVideoCallViewController(friend: makeMessageFriend(from: post))
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    private func showMessageChatPage(for post: EmotionPost) {
        guard !UserBlockStore.isBlocked(name: post.name) else {
            showBlockedUserAlert()
            return
        }

        let viewController = MessageChatViewController(
            friend: makeMessageFriend(from: post),
            returnDestination: .emotionSync
        )
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    private func makeMessageFriend(from post: EmotionPost) -> MessageFriend {
        MessageFriend(
            name: post.name,
            message: post.content,
            avatarColor: UIColor(red: 0.76, green: 0.87, blue: 1.00, alpha: 1),
            avatarImageName: post.avatarImageName,
            profileVideoFileName: post.profileVideoFileName
        )
    }

}

private extension EmotionSyncViewController {

    var visiblePosts: [EmotionPost] {
        posts.filter { !UserBlockStore.isBlocked(name: $0.name) }
    }

    func showReportMenu(from sourceView: UIView, for post: EmotionPost) {
        showEmotionReportMenu(
            from: sourceView,
            onReport: { [weak self] in
                self?.showReportReceivedAlert()
            },
            onBlock: { [weak self] in
                guard let self else { return }

                self.showBlockConfirmation(for: post.blockedUser) { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        )
    }

}

extension EmotionPost {

    var blockedUser: BlockedUser {
        BlockedUser(
            name: name,
            message: content,
            avatarImageName: avatarImageName,
            profileVideoFileName: profileVideoFileName
        )
    }

}
