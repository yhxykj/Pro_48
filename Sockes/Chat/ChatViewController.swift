

import UIKit

struct ChatMessage: Codable {
    let text: String
    let isMine: Bool
}

final class ChatViewController: UIViewController, UITextFieldDelegate {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let sendButton = "Chat/chat_send_button"
    }

    private enum StorageKey {
        static let messagePrefix = "chat.ai.messages"
    }

    private var messages: [ChatMessage] = []
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let inputBar = UIView()
    private let inputTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadMessages()
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
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            nameLabel.heightAnchor.constraint(equalToConstant: 44),

            tagStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tagStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12)
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 92),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -88)
        ])
    }

    private func setupInputBar() {
        inputBar.backgroundColor = .white
        inputBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputBar)

        inputTextField.borderStyle = .none
        inputTextField.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
        inputTextField.font = .systemFont(ofSize: 14, weight: .regular)
        inputTextField.textColor = .black
        inputTextField.returnKeyType = .send
        inputTextField.delegate = self
        inputTextField.attributedPlaceholder = NSAttributedString(
            string: "Please input what you want to say",
            attributes: [
                .foregroundColor: UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1),
                .font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
        )
        inputTextField.layer.cornerRadius = 6
        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        inputTextField.leftViewMode = .always
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputBar.addSubview(inputTextField)

        let sendButton = UIButton(type: .custom)
        sendButton.setImage(UIImage(named: Asset.sendButton), for: .normal)
        sendButton.imageView?.contentMode = .scaleAspectFit
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        inputBar.addSubview(sendButton)

        NSLayoutConstraint.activate([
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            inputBar.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.bottomAnchor, constant: 0),
            inputBar.heightAnchor.constraint(equalToConstant: 83),

            inputTextField.leadingAnchor.constraint(equalTo: inputBar.leadingAnchor, constant: 15),
            inputTextField.topAnchor.constraint(equalTo: inputBar.topAnchor, constant: 11),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -15),
            inputTextField.heightAnchor.constraint(equalToConstant: 40),

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
        label.widthAnchor.constraint(equalToConstant: text.width(font: label.font) + 22).isActive = true
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return label
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func sendMessage() {
        let text = inputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !text.isEmpty else { return }

        inputTextField.text = nil
        appendMessage(ChatMessage(text: text, isMine: true))
    }

    private func appendMessage(_ message: ChatMessage) {
        messages.append(message)
        saveMessages()

        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.performBatchUpdates {
            tableView.insertRows(at: [indexPath], with: .fade)
        } completion: { [weak self] _ in
            self?.scrollToLatestMessage()
        }
    }

    private func loadMessages() {
        guard let data = UserDefaults.standard.data(forKey: messageStorageKey),
              let savedMessages = try? JSONDecoder().decode([ChatMessage].self, from: data) else {
            messages = []
            return
        }

        messages = savedMessages
    }

    private func saveMessages() {
        guard let data = try? JSONEncoder().encode(messages) else { return }

        UserDefaults.standard.set(data, forKey: messageStorageKey)
    }

    private var messageStorageKey: String {
        let email = AuthSession.currentEmail ?? "guest"
        return "\(StorageKey.messagePrefix).\(email)"
    }

    private func scrollToLatestMessage() {
        guard !messages.isEmpty else { return }

        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
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

private extension String {

    func width(font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        return ceil((self as NSString).size(withAttributes: attributes).width)
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
