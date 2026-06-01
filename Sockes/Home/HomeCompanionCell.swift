//
//  HomeCompanionCell.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/1.
//

import UIKit

final class HomeCompanionCell: UITableViewCell {

    static let reuseIdentifier = "HomeCompanionCell"

    private let cardView = UIView()
    private let photoView = UIView()
    private let nameInitialLabel = UILabel()
    private let nameLabel = UILabel()
    private let coinLabel = UILabel()
    private let tagStack = UIStackView()
    private let messageLabel = UILabel()
    private let hiButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        tagStack.arrangedSubviews.forEach { view in
            tagStack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    func configure(with companion: HomeCompanion) {
        photoView.backgroundColor = companion.color
        nameInitialLabel.text = String(companion.name.prefix(1))
        nameLabel.text = companion.name
        messageLabel.text = companion.message
        companion.tags.forEach { tagStack.addArrangedSubview(makeTagLabel($0)) }
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 9
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.06
        cardView.layer.shadowRadius = 8
        cardView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        photoView.layer.cornerRadius = 5
        photoView.clipsToBounds = true
        photoView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(photoView)

        nameInitialLabel.font = .systemFont(ofSize: 38, weight: .bold)
        nameInitialLabel.textColor = UIColor.white.withAlphaComponent(0.82)
        nameInitialLabel.textAlignment = .center
        nameInitialLabel.translatesAutoresizingMaskIntoConstraints = false
        photoView.addSubview(nameInitialLabel)

        nameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        nameLabel.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.20, alpha: 1)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(nameLabel)

        coinLabel.text = "🪙999"
        coinLabel.font = .systemFont(ofSize: 12, weight: .regular)
        coinLabel.textColor = UIColor(red: 0.98, green: 0.57, blue: 0.00, alpha: 1)
        coinLabel.textAlignment = .center
        coinLabel.backgroundColor = UIColor(red: 1.00, green: 0.95, blue: 0.75, alpha: 1)
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(coinLabel)

        tagStack.axis = .horizontal
        tagStack.spacing = 12
        tagStack.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(tagStack)

        messageLabel.numberOfLines = 2
        messageLabel.font = .systemFont(ofSize: 12, weight: .regular)
        messageLabel.textColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(messageLabel)

        hiButton.setTitle("Hi", for: .normal)
        hiButton.titleLabel?.font = .italicSystemFont(ofSize: 19)
        hiButton.tintColor = .white
        hiButton.backgroundColor = UIColor(red: 0.68, green: 0.95, blue: 1.00, alpha: 1)
        hiButton.layer.cornerRadius = 12
        hiButton.layer.borderWidth = 1
        hiButton.layer.borderColor = UIColor(red: 0.42, green: 0.72, blue: 1.00, alpha: 1).cgColor
        hiButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(hiButton)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),

            photoView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            photoView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            photoView.widthAnchor.constraint(equalToConstant: 90),
            photoView.heightAnchor.constraint(equalToConstant: 90),

            nameInitialLabel.centerXAnchor.constraint(equalTo: photoView.centerXAnchor),
            nameInitialLabel.centerYAnchor.constraint(equalTo: photoView.centerYAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 17),

            coinLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            coinLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
            coinLabel.widthAnchor.constraint(equalToConstant: 50),
            coinLabel.heightAnchor.constraint(equalToConstant: 19),

            tagStack.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            tagStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 11),
            tagStack.heightAnchor.constraint(equalToConstant: 20),

            hiButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            hiButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor, constant: -2),
            hiButton.widthAnchor.constraint(equalToConstant: 36),
            hiButton.heightAnchor.constraint(equalToConstant: 36),

            messageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: hiButton.leadingAnchor, constant: -12),
            messageLabel.topAnchor.constraint(equalTo: tagStack.bottomAnchor, constant: 13)
        ])
    }

    private func makeTagLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 0.38, green: 0.63, blue: 1.00, alpha: 1)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 0.95, green: 0.98, blue: 1.00, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(greaterThanOrEqualToConstant: 58).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }

}
