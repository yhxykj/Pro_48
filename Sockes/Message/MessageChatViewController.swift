//
//  MessageChatViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

final class MessageChatViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let topBackground = "EmotionSync/ShareEmotions/share_emotions_background"
        static let alertIcon = "EmotionSync/PostDetail/post_detail_alert_icon"
        static let videoIcon = "Message/message_chat_video_icon"
        static let sendButton = "Chat/chat_send_button"
    }

    private let friend: MessageFriend
    private let messages: [ChatMessage] = [
        ChatMessage(text: "Tell me what's bothering you, I'll\nhelp you relieve it.", isMine: false),
        ChatMessage(text: "I haven't been working very\nsmoothly lately, and I don't know\nwhat to do next", isMine: true),
        ChatMessage(text: "You can try submitting more\nresumes and exploring variou\nsopportunities", isMine: false)
    ]

    private let tableView = UITableView(frame: .zero, style: .plain)
    private let inputBar = UIView()

    init(friend: MessageFriend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHeader()
        setupTableView()
        setupInputBar()
        setupKeyboardDismiss()
        setupKeyboardObserver()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupHeader() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let topBackgroundImageView = UIImageView(image: UIImage(named: Asset.topBackground))
        topBackgroundImageView.contentMode = .scaleToFill
        topBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBackgroundImageView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let nameLabel = UILabel()
        nameLabel.text = friend.name
        nameLabel.font = .systemFont(ofSize: 22, weight: .regular)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        let alertButton = UIButton(type: .custom)
        alertButton.setImage(UIImage(named: Asset.alertIcon), for: .normal)
        alertButton.imageView?.contentMode = .scaleAspectFit
        alertButton.addTarget(self, action: #selector(showReportMenu(_:)), for: .touchUpInside)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertButton)

        NSLayoutConstraint.activate([
            topBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundImageView.heightAnchor.constraint(equalToConstant: 190),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            alertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
            alertButton.topAnchor.constraint(equalTo: backButton.topAnchor),
            alertButton.widthAnchor.constraint(equalToConstant: 44),
            alertButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .interactive
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 126
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83)
        ])
    }

    private func setupInputBar() {
        inputBar.backgroundColor = .white
        inputBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputBar)

        let videoButton = UIButton(type: .custom)
        videoButton.setImage(UIImage(named: Asset.videoIcon), for: .normal)
        videoButton.imageView?.contentMode = .scaleAspectFit
        videoButton.addTarget(self, action: #selector(showVideoCallPage), for: .touchUpInside)
        videoButton.translatesAutoresizingMaskIntoConstraints = false
        inputBar.addSubview(videoButton)

        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: "Please enter...",
            attributes: [
                .foregroundColor: UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1),
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
        )
        textField.layer.cornerRadius = 6
        textField.layer.masksToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        inputBar.addSubview(textField)

        let sendButton = UIButton(type: .custom)
        sendButton.setImage(UIImage(named: Asset.sendButton), for: .normal)
        sendButton.imageView?.contentMode = .scaleAspectFit
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        inputBar.addSubview(sendButton)

        NSLayoutConstraint.activate([
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBar.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor, constant: 0),
            inputBar.heightAnchor.constraint(equalToConstant: 83),

            videoButton.leadingAnchor.constraint(equalTo: inputBar.leadingAnchor, constant: 17),
            videoButton.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 11),
            videoButton.widthAnchor.constraint(equalToConstant: 44),
            videoButton.heightAnchor.constraint(equalToConstant: 40),

            textField.leadingAnchor.constraint(equalTo: videoButton.trailingAnchor, constant: 13),
            textField.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 11),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -15),
            textField.heightAnchor.constraint(equalToConstant: 40),

            sendButton.trailingAnchor.constraint(equalTo: inputBar.trailingAnchor, constant: -15),
            sendButton.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 11),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    private func setupKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardFrameDidChange(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardFrameDidChange(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func showReportMenu(_ sender: UIButton) {
        showEmotionReportMenu(from: sender)
    }

    @objc private func showVideoCallPage() {
        view.endEditing(true)

        let viewController = MessageVideoCallViewController(friend: friend)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }

    @objc private func keyboardFrameDidChange(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        let convertedFrame = view.convert(keyboardFrame, from: nil)
        let keyboardHeight = max(0, view.bounds.maxY - convertedFrame.minY)
        let bottomOffset = max(0, keyboardHeight - view.safeAreaInsets.bottom + 10)
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 7
        let options = UIView.AnimationOptions(rawValue: curveValue << 16)

        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.inputBar.transform = CGAffineTransform(translationX: 0, y: -bottomOffset)
            self.tableView.contentInset.bottom = bottomOffset
            self.tableView.verticalScrollIndicatorInsets.bottom = bottomOffset
            self.view.layoutIfNeeded()
        }
    }

}

extension MessageChatViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatMessageCell.reuseIdentifier,
            for: indexPath
        )
        guard let messageCell = cell as? ChatMessageCell else {
            return cell
        }

        messageCell.configure(with: messages[indexPath.row])
        return messageCell
    }

}
