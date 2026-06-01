//
//  ChatMessageCell.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/1.
//

import UIKit

final class ChatMessageCell: UITableViewCell {

    static let reuseIdentifier = "ChatMessageCell"

    private let avatarView = UIView()
    private let avatarLabel = UILabel()
    private let bubbleLabel = PaddedLabel()
    private var leadingConstraints: [NSLayoutConstraint] = []
    private var trailingConstraints: [NSLayoutConstraint] = []
    private var bubbleWidthConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with message: ChatMessage) {
        bubbleLabel.text = message.text
        bubbleLabel.backgroundColor = message.isMine
            ? UIColor(red: 0.73, green: 0.84, blue: 1.00, alpha: 1)
            : .white
        avatarView.backgroundColor = message.isMine
            ? UIColor(red: 1.00, green: 0.91, blue: 0.68, alpha: 1)
            : UIColor(red: 0.78, green: 0.88, blue: 1.00, alpha: 1)
        avatarLabel.text = message.isMine ? "W" : "L"
        bubbleWidthConstraint?.constant = message.isMine ? 252 : 256

        NSLayoutConstraint.deactivate(leadingConstraints + trailingConstraints)
        NSLayoutConstraint.activate(message.isMine ? trailingConstraints : leadingConstraints)
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        avatarView.layer.cornerRadius = 4
        avatarView.clipsToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarView)

        avatarLabel.font = .systemFont(ofSize: 12, weight: .bold)
        avatarLabel.textColor = .white
        avatarLabel.textAlignment = .center
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(avatarLabel)

        bubbleLabel.numberOfLines = 0
        bubbleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        bubbleLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1)
        bubbleLabel.layer.cornerRadius = 12
        bubbleLabel.layer.masksToBounds = true
        bubbleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bubbleLabel)
        bubbleWidthConstraint = bubbleLabel.widthAnchor.constraint(equalToConstant: 256)
        bubbleWidthConstraint?.isActive = true

        leadingConstraints = [
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            bubbleLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 15)
        ]

        trailingConstraints = [
            avatarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            bubbleLabel.trailingAnchor.constraint(equalTo: avatarView.leadingAnchor, constant: -15)
        ]

        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            avatarView.widthAnchor.constraint(equalToConstant: 28),
            avatarView.heightAnchor.constraint(equalToConstant: 28),

            avatarLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),

            bubbleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bubbleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }

}

private final class PaddedLabel: UILabel {

    var textInsets = UIEdgeInsets(top: 11, left: 15, bottom: 11, right: 15)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }

    override func textRect(
        forBounds bounds: CGRect,
        limitedToNumberOfLines numberOfLines: Int
    ) -> CGRect {
        let insetBounds = bounds.inset(by: textInsets)
        let rect = super.textRect(forBounds: insetBounds, limitedToNumberOfLines: numberOfLines)
        return rect.inset(
            by: UIEdgeInsets(
                top: -textInsets.top,
                left: -textInsets.left,
                bottom: -textInsets.bottom,
                right: -textInsets.right
            )
        )
    }

}
