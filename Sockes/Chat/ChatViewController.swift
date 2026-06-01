//
//  ChatViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/1.
//

import UIKit

struct ChatMessage {
    let text: String
    let isMine: Bool
}

final class ChatViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let sendButton = "Chat/chat_send_button"
    }

    private let messages: [ChatMessage] = [
        ChatMessage(text: "Tell me what's bothering you, I'll\nhelp you relieve it.", isMine: false),
        ChatMessage(text: "I haven't been working very\nsmoothly lately, and I don't know\nwhat to do next", isMine: true),
        ChatMessage(text: "You can try submitting more\nresumes and exploring variou\nsopportunities", isMine: false)
    ]

    private let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHeader()
        setupTableView()
        setupInputBar()
    }

    private func setupHeader() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let headerView = GradientHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let nameLabel = UILabel()
        nameLabel.text = "Liora"
        nameLabel.font = .systemFont(ofSize: 22, weight: .regular)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        let tagStack = UIStackView(arrangedSubviews: [
            makeTagLabel("Kind"),
            makeTagLabel("Wonderful")
        ])
        tagStack.axis = .horizontal
        tagStack.spacing = 12
        tagStack.alignment = .center
        tagStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagStack)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 225),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            nameLabel.heightAnchor.constraint(equalToConstant: 44),

            tagStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tagStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30)
        ])
    }

    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 126
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 214),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -118)
        ])
    }

    private func setupInputBar() {
        let inputBar = UIView()
        inputBar.backgroundColor = .white
        inputBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputBar)

        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        textField.font = .systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: "Please input what you want to say",
            attributes: [
                .foregroundColor: UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1),
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
        )
        textField.layer.cornerRadius = 6
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
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
            inputBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            inputBar.heightAnchor.constraint(equalToConstant: 116),

            textField.leadingAnchor.constraint(equalTo: inputBar.leadingAnchor, constant: 15),
            textField.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -22),
            textField.heightAnchor.constraint(equalToConstant: 56),

            sendButton.trailingAnchor.constraint(equalTo: inputBar.trailingAnchor, constant: -22),
            sendButton.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 16),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func makeTagLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 0.38, green: 0.63, blue: 1.00, alpha: 1)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.76, green: 0.87, blue: 1.00, alpha: 1)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 70),
            label.heightAnchor.constraint(equalToConstant: 24)
        ])
        return label
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {

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

private final class GradientHeaderView: UIView {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        gradientLayer.colors = [
            UIColor(red: 0.72, green: 0.82, blue: 1.00, alpha: 1).cgColor,
            UIColor(red: 0.82, green: 0.99, blue: 0.98, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(gradientLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = bounds
    }

}
