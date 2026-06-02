//
//  EmotionUserProfileViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/2.
//

import UIKit

final class EmotionUserProfileViewController: UIViewController {

    private enum Asset {
        static let headerPhoto = "EmotionSync/UserProfile/user_profile_header_photo"
        static let backIcon = "EmotionSync/UserProfile/user_profile_back_icon"
        static let alertIcon = "EmotionSync/UserProfile/user_profile_alert_icon"
        static let starNormal = "EmotionSync/UserProfile/user_profile_star_normal"
        static let starSelected = "EmotionSync/UserProfile/user_profile_star_selected"
        static let videoButton = "EmotionSync/UserProfile/user_profile_video_button"
        static let mailButton = "EmotionSync/UserProfile/user_profile_mail_button"
        static let playButton = "EmotionSync/UserProfile/user_profile_play_button"
        static let cardBackground = "EmotionSync/emotion_sync_post_card_background"
        static let avatarRing = "EmotionSync/emotion_sync_avatar_ring"
    }

    private enum FallbackAsset {
        static let backIcon = "Common/common_back_icon"
        static let alertIcon = "EmotionSync/PostDetail/post_detail_alert_icon"
        static let videoButton = "EmotionSync/emotion_sync_video_button"
        static let mailButton = "EmotionSync/emotion_sync_mail_button"
    }

    private let post: EmotionPost
    private let starButton = UIButton(type: .custom)

    init(post: EmotionPost) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
    }

    private func setupContent() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let contentView = UIView()
        contentView.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 1.00, alpha: 1)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let headerPhotoView = makeHeaderPhotoView()
        contentView.addSubview(headerPhotoView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(loadImage(named: Asset.backIcon, fallbackName: FallbackAsset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let alertButton = UIButton(type: .custom)
        alertButton.setImage(loadImage(named: Asset.alertIcon, fallbackName: FallbackAsset.alertIcon), for: .normal)
        alertButton.imageView?.contentMode = .scaleAspectFit
        alertButton.addTarget(self, action: #selector(showReportMenu(_:)), for: .touchUpInside)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(alertButton)

        let playButton = makePlayButton()
        contentView.addSubview(playButton)
        
        let backgroundImageView = UIImageView(image: UIImage(named: "EmotionSync/ShareEmotions/share_emotions_background"))
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 10
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImageView)

        let profilePanelView = UIView()
        profilePanelView.backgroundColor = .clear
        profilePanelView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profilePanelView)

        let avatarView = makeProfileAvatarView()
        contentView.addSubview(avatarView)

        let nameLabel = UILabel()
        nameLabel.text = "Williams"
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        nameLabel.textColor = UIColor(red: 0.19, green: 0.19, blue: 0.20, alpha: 1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePanelView.addSubview(nameLabel)

        configureStarButton()
        profilePanelView.addSubview(starButton)

        let videoButton = UIButton(type: .custom)
        videoButton.setImage(loadImage(named: Asset.videoButton, fallbackName: FallbackAsset.videoButton), for: .normal)
        videoButton.translatesAutoresizingMaskIntoConstraints = false
        profilePanelView.addSubview(videoButton)

        let mailButton = UIButton(type: .custom)
        mailButton.setImage(loadImage(named: Asset.mailButton, fallbackName: FallbackAsset.mailButton), for: .normal)
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        profilePanelView.addSubview(mailButton)

        let postTitleLabel = UILabel()
        postTitleLabel.text = "Post"
        postTitleLabel.font = .systemFont(ofSize: 21, weight: .bold)
        postTitleLabel.textColor = .black
        postTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(postTitleLabel)

        let postCardView = makeProfilePostCard()
        contentView.addSubview(postCardView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),

            headerPhotoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerPhotoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerPhotoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerPhotoView.heightAnchor.constraint(equalToConstant: 598),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            alertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            alertButton.widthAnchor.constraint(equalToConstant: 44),
            alertButton.heightAnchor.constraint(equalToConstant: 44),

            playButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 368),
            playButton.widthAnchor.constraint(equalToConstant: 48),
            playButton.heightAnchor.constraint(equalToConstant: 48),
            
            backgroundImageView.topAnchor.constraint(equalTo: headerPhotoView.bottomAnchor, constant: -46),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 200),

            profilePanelView.topAnchor.constraint(equalTo: headerPhotoView.bottomAnchor, constant: -46),
            profilePanelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profilePanelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profilePanelView.heightAnchor.constraint(equalToConstant: 88),

            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            avatarView.centerYAnchor.constraint(equalTo: profilePanelView.topAnchor, constant: 18),
            avatarView.widthAnchor.constraint(equalToConstant: 66),
            avatarView.heightAnchor.constraint(equalToConstant: 66),

            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: profilePanelView.topAnchor, constant: 20),

            mailButton.trailingAnchor.constraint(equalTo: profilePanelView.trailingAnchor, constant: -22),
            mailButton.topAnchor.constraint(equalTo: profilePanelView.topAnchor, constant: 13),
            mailButton.widthAnchor.constraint(equalToConstant: 36),
            mailButton.heightAnchor.constraint(equalToConstant: 36),

            videoButton.trailingAnchor.constraint(equalTo: mailButton.leadingAnchor, constant: -22),
            videoButton.topAnchor.constraint(equalTo: mailButton.topAnchor),
            videoButton.widthAnchor.constraint(equalToConstant: 36),
            videoButton.heightAnchor.constraint(equalToConstant: 36),

            starButton.trailingAnchor.constraint(equalTo: videoButton.leadingAnchor, constant: -22),
            starButton.centerYAnchor.constraint(equalTo: videoButton.centerYAnchor),
            starButton.widthAnchor.constraint(equalToConstant: 36),
            starButton.heightAnchor.constraint(equalToConstant: 36),

            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            postTitleLabel.topAnchor.constraint(equalTo: profilePanelView.bottomAnchor, constant: 15),

            postCardView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 18),
            postCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            postCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            postCardView.heightAnchor.constraint(equalToConstant: 230),
            postCardView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -24)
        ])
    }

    private func makeHeaderPhotoView() -> UIView {
        if let image = UIImage(named: Asset.headerPhoto) {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }

        let placeholderView = UIView()
        placeholderView.backgroundColor = UIColor(red: 0.63, green: 0.76, blue: 0.61, alpha: 1)
        placeholderView.translatesAutoresizingMaskIntoConstraints = false

        let imageLabel = UILabel()
        imageLabel.text = "Williams"
        imageLabel.font = .systemFont(ofSize: 42, weight: .bold)
        imageLabel.textColor = UIColor.white.withAlphaComponent(0.42)
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.addSubview(imageLabel)

        NSLayoutConstraint.activate([
            imageLabel.centerXAnchor.constraint(equalTo: placeholderView.centerXAnchor),
            imageLabel.centerYAnchor.constraint(equalTo: placeholderView.centerYAnchor)
        ])

        return placeholderView
    }

    private func makeProfileAvatarView() -> UIView {
        let avatarView = UIView()
        avatarView.backgroundColor = UIColor(red: 0.96, green: 0.76, blue: 0.50, alpha: 1)
        avatarView.layer.cornerRadius = 33
        avatarView.layer.borderWidth = 1
        avatarView.layer.borderColor = UIColor(red: 0.41, green: 0.65, blue: 1.00, alpha: 1).cgColor
        avatarView.clipsToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "W"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor)
        ])

        return avatarView
    }

    private func configureStarButton() {
        starButton.setImage(UIImage(named: Asset.starNormal), for: .normal)
        starButton.setImage(UIImage(named: Asset.starSelected), for: .selected)
        if UIImage(named: Asset.starNormal) == nil {
        }
        starButton.addTarget(self, action: #selector(toggleStarState), for: .touchUpInside)
        starButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func makePlayButton() -> UIButton {
        let button = UIButton(type: .custom)
        if let image = UIImage(named: Asset.playButton) {
            button.setImage(image, for: .normal)
        } else {
            button.setTitle("▶", for: .normal)
            button.setTitleColor(UIColor(red: 0.38, green: 0.72, blue: 0.70, alpha: 1), for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
            button.backgroundColor = UIColor.white.withAlphaComponent(0.62)
            button.layer.cornerRadius = 24
            button.layer.masksToBounds = true
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func makeProfilePostCard() -> UIView {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 8
        cardView.layer.shadowColor = UIColor(red: 0.53, green: 0.71, blue: 0.95, alpha: 1).cgColor
        cardView.layer.shadowOpacity = 0.22
        cardView.layer.shadowRadius = 0
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.translatesAutoresizingMaskIntoConstraints = false

        let cardBackgroundView = UIImageView(image: UIImage(named: Asset.cardBackground))
        cardBackgroundView.contentMode = .scaleToFill
        cardBackgroundView.clipsToBounds = true
        cardBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(cardBackgroundView)

        let avatarView = makeProfileAvatarView()
        cardView.addSubview(avatarView)

        let avatarRingView = UIImageView(image: UIImage(named: Asset.avatarRing))
        avatarRingView.contentMode = .scaleAspectFit
        avatarRingView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(avatarRingView)

        let nameLabel = UILabel()
        nameLabel.text = "Arlan"
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.22, alpha: 1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(nameLabel)

        let timeLabel = UILabel()
        timeLabel.text = "10 min ago"
        timeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        timeLabel.textColor = UIColor(red: 0.45, green: 0.45, blue: 0.46, alpha: 1)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(timeLabel)

        let contentLabel = UILabel()
        contentLabel.text = "Don't be discouraged; it's often the last key in the bunch\nthat opens the lock."
        contentLabel.numberOfLines = 2
        contentLabel.font = .systemFont(ofSize: 13, weight: .regular)
        contentLabel.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(contentLabel)

        let photoStackView = UIStackView()
        photoStackView.axis = .horizontal
        photoStackView.spacing = 8
        photoStackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(photoStackView)

        post.photoColors.prefix(2).forEach { color in
            photoStackView.addArrangedSubview(makePostPhotoView(color: color))
        }

        NSLayoutConstraint.activate([
            cardBackgroundView.topAnchor.constraint(equalTo: cardView.topAnchor),
            cardBackgroundView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            cardBackgroundView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            cardBackgroundView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),

            avatarView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 28),
            avatarView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 25),
            avatarView.widthAnchor.constraint(equalToConstant: 52),
            avatarView.heightAnchor.constraint(equalToConstant: 52),

            avatarRingView.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarRingView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarRingView.widthAnchor.constraint(equalToConstant: 70),
            avatarRingView.heightAnchor.constraint(equalToConstant: 70),

            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 105),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 53),

            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),

            contentLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 26),
            contentLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -22),
            contentLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 106),

            photoStackView.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
            photoStackView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 16),
            photoStackView.heightAnchor.constraint(equalToConstant: 63)
        ])

        return cardView
    }

    private func makePostPhotoView(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "AI"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = UIColor.white.withAlphaComponent(0.82)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 84),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    private func loadImage(named name: String, fallbackName: String) -> UIImage? {
        UIImage(named: name) ?? UIImage(named: fallbackName)
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

    @objc private func toggleStarState() {
        starButton.isSelected.toggle()
    }

    @objc private func showReportMenu(_ sender: UIButton) {
        showEmotionReportMenu(from: sender)
    }

}
