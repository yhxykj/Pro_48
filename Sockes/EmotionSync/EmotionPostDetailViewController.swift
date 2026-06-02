//
//  EmotionPostDetailViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/2.
//

import UIKit

final class EmotionPostDetailViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let background = "EmotionSync/ShareEmotions/share_emotions_background"
        static let cardBackground = "EmotionSync/emotion_sync_post_card_background"
        static let avatarRing = "EmotionSync/emotion_sync_avatar_ring"
        static let mailButton = "EmotionSync/emotion_sync_mail_button"
        static let videoButton = "EmotionSync/emotion_sync_video_button"
        static let alertIcon = "EmotionSync/PostDetail/post_detail_alert_icon"
        static let likeNormal = "EmotionSync/PostDetail/post_detail_like_normal"
        static let likeSelected = "EmotionSync/PostDetail/post_detail_like_selected"
    }

    private let post: EmotionPost
    private let likeButton = UIButton(type: .custom)
    private let commentBarView = UIView()

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
        setupKeyboardDismiss()
        setupKeyboardObserver()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupContent() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let contentView = UIView()
        contentView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)

        let backgroundImageView = UIImageView(image: UIImage(named: Asset.background))
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImageView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Share Emotions"
        titleLabel.font = .systemFont(ofSize: 25, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        let topAlertImageView = UIImageView(image: UIImage(named: Asset.alertIcon))
        topAlertImageView.contentMode = .scaleAspectFit
        topAlertImageView.isUserInteractionEnabled = true
        topAlertImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showTopReportMenu(_:))))
        topAlertImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topAlertImageView)

        let cardView = makePostCard()
        contentView.addSubview(cardView)

        let commentsTitleLabel = UILabel()
        commentsTitleLabel.text = "Comments"
        commentsTitleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        commentsTitleLabel.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.20, alpha: 1)
        commentsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentsTitleLabel)

        let commentAvatarView = makeCommentAvatarView()
        contentView.addSubview(commentAvatarView)

        let commentNameLabel = UILabel()
        commentNameLabel.text = "Williams"
        commentNameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        commentNameLabel.textColor = UIColor(red: 0.19, green: 0.19, blue: 0.20, alpha: 1)
        commentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentNameLabel)

        let commentLabel = UILabel()
        commentLabel.text = "Smart and handsome sunshine boy."
        commentLabel.font = .systemFont(ofSize: 14, weight: .regular)
        commentLabel.textColor = UIColor(red: 0.68, green: 0.68, blue: 0.68, alpha: 1)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentLabel)

        let commentReportButton = UIButton(type: .custom)
        commentReportButton.setImage(UIImage(named: Asset.alertIcon), for: .normal)
        commentReportButton.imageView?.contentMode = .scaleAspectFit
        commentReportButton.addTarget(self, action: #selector(showCommentReportMenu(_:)), for: .touchUpInside)
        commentReportButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentReportButton)

        commentBarView.backgroundColor = .white
        commentBarView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(commentBarView)

        likeButton.setImage(UIImage(named: Asset.likeNormal), for: .normal)
        likeButton.setImage(UIImage(named: Asset.likeSelected), for: .selected)
        likeButton.addTarget(self, action: #selector(toggleLikeState), for: .touchUpInside)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        commentBarView.addSubview(likeButton)

        let commentInputField = UITextField()
        commentInputField.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        commentInputField.layer.cornerRadius = 5
        commentInputField.layer.masksToBounds = true
        commentInputField.font = .systemFont(ofSize: 15, weight: .regular)
        commentInputField.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1)
        commentInputField.attributedPlaceholder = NSAttributedString(
            string: "Write to comment...",
            attributes: [.foregroundColor: UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1)]
        )
        commentInputField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        commentInputField.leftViewMode = .always
        commentInputField.translatesAutoresizingMaskIntoConstraints = false
        commentBarView.addSubview(commentInputField)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 200),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            topAlertImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            topAlertImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            topAlertImageView.widthAnchor.constraint(equalToConstant: 20),
            topAlertImageView.heightAnchor.constraint(equalToConstant: 20),

            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 119),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cardView.heightAnchor.constraint(equalToConstant: 230),

            commentsTitleLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 39),
            commentsTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 2),

            commentAvatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            commentAvatarView.topAnchor.constraint(equalTo: commentsTitleLabel.bottomAnchor, constant: 36),
            commentAvatarView.widthAnchor.constraint(equalToConstant: 50),
            commentAvatarView.heightAnchor.constraint(equalToConstant: 50),

            commentNameLabel.leadingAnchor.constraint(equalTo: commentAvatarView.trailingAnchor, constant: 16),
            commentNameLabel.topAnchor.constraint(equalTo: commentAvatarView.topAnchor, constant: 3),

            commentLabel.leadingAnchor.constraint(equalTo: commentNameLabel.leadingAnchor),
            commentLabel.topAnchor.constraint(equalTo: commentNameLabel.bottomAnchor, constant: 11),

            commentReportButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            commentReportButton.centerYAnchor.constraint(equalTo: commentAvatarView.centerYAnchor),
            commentReportButton.widthAnchor.constraint(equalToConstant: 20),
            commentReportButton.heightAnchor.constraint(equalToConstant: 20),

            commentBarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commentBarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commentBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            commentBarView.heightAnchor.constraint(equalToConstant: 83),

            commentInputField.leadingAnchor.constraint(equalTo: commentBarView.leadingAnchor, constant: 15),
            commentInputField.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -20),
            commentInputField.topAnchor.constraint(equalTo: commentBarView.topAnchor, constant: 11),
            commentInputField.heightAnchor.constraint(equalToConstant: 40),

            likeButton.trailingAnchor.constraint(equalTo: commentBarView.trailingAnchor, constant: -10),
            likeButton.centerYAnchor.constraint(equalTo: commentInputField.centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 44),
            likeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func makePostCard() -> UIView {
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

        let avatarView = UIView()
        avatarView.backgroundColor = post.avatarColor
        avatarView.layer.cornerRadius = 26
        avatarView.clipsToBounds = true
        avatarView.isUserInteractionEnabled = true
        avatarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showUserProfilePage)))
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(avatarView)

        let avatarInitialLabel = UILabel()
        avatarInitialLabel.text = String(post.name.prefix(1))
        avatarInitialLabel.font = .systemFont(ofSize: 24, weight: .bold)
        avatarInitialLabel.textColor = .white
        avatarInitialLabel.textAlignment = .center
        avatarInitialLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(avatarInitialLabel)

        let avatarRingView = UIImageView(image: UIImage(named: Asset.avatarRing))
        avatarRingView.contentMode = .scaleAspectFit
        avatarRingView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(avatarRingView)

        let nameLabel = UILabel()
        nameLabel.text = post.name
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.22, alpha: 1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(nameLabel)

        let timeLabel = UILabel()
        timeLabel.text = post.time
        timeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        timeLabel.textColor = UIColor(red: 0.45, green: 0.45, blue: 0.46, alpha: 1)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(timeLabel)

        let videoButton = UIButton(type: .custom)
        videoButton.setImage(UIImage(named: Asset.videoButton), for: .normal)
        videoButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(videoButton)

        let mailButton = UIButton(type: .custom)
        mailButton.setImage(UIImage(named: Asset.mailButton), for: .normal)
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(mailButton)

        let contentLabel = UILabel()
        contentLabel.text = post.content
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

            avatarInitialLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarInitialLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),

            avatarRingView.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarRingView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarRingView.widthAnchor.constraint(equalToConstant: 70),
            avatarRingView.heightAnchor.constraint(equalToConstant: 70),

            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 105),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 53),

            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),

            mailButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -25),
            mailButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 23),
            mailButton.widthAnchor.constraint(equalToConstant: 42),
            mailButton.heightAnchor.constraint(equalToConstant: 42),

            videoButton.trailingAnchor.constraint(equalTo: mailButton.leadingAnchor, constant: -15),
            videoButton.topAnchor.constraint(equalTo: mailButton.topAnchor),
            videoButton.widthAnchor.constraint(equalToConstant: 42),
            videoButton.heightAnchor.constraint(equalToConstant: 42),

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
        label.font = .systemFont(ofSize: 24, weight: .bold)
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

    private func makeCommentAvatarView() -> UIView {
        let avatarView = UIView()
        avatarView.backgroundColor = UIColor(red: 0.96, green: 0.76, blue: 0.50, alpha: 1)
        avatarView.layer.cornerRadius = 25
        avatarView.layer.borderWidth = 1
        avatarView.layer.borderColor = UIColor(red: 0.41, green: 0.65, blue: 1.00, alpha: 1).cgColor
        avatarView.clipsToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "W"
        label.font = .systemFont(ofSize: 22, weight: .bold)
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

    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardFrameChange(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardFrameChange(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

    @objc private func toggleLikeState() {
        likeButton.isSelected.toggle()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func showUserProfilePage() {
        view.endEditing(true)

        let viewController = EmotionUserProfileViewController(post: post)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @objc private func showTopReportMenu(_ gesture: UITapGestureRecognizer) {
        guard let sourceView = gesture.view else { return }

        showEmotionReportMenu(from: sourceView)
    }

    @objc private func showCommentReportMenu(_ sender: UIButton) {
        showEmotionReportMenu(from: sender)
    }

    @objc private func handleKeyboardFrameChange(_ notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let curveValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 7
        let options = UIView.AnimationOptions(rawValue: curveValue << 16)

        let keyboardMinY = keyboardFrame.map { view.convert($0, from: nil).minY } ?? view.bounds.maxY
        let bottomOffset = max(0, view.bounds.maxY - keyboardMinY)

        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.commentBarView.transform = CGAffineTransform(translationX: 0, y: -bottomOffset)
        }
    }

}
