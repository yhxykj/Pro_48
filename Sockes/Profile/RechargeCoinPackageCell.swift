//
//  RechargeCoinPackageCell.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

final class RechargeCoinPackageCell: UICollectionViewCell {

    static let reuseIdentifier = "RechargeCoinPackageCell"

    let cardView = UIImageView()
    private let textPanelView = UIView()
    private let textStackView = UIStackView()
    private let coinLabel = UILabel()
    private let coinTitleLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cardView.image = nil
        cardView.transform = .identity
        coinLabel.text = nil
        priceLabel.text = nil
    }

    func configure(coins: Int, priceText: String) {
        cardView.image = nil
        coinLabel.text = "\(coins)"
        priceLabel.text = priceText
    }

    private func setupContent() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cardView.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 0.82, alpha: 1)
        cardView.contentMode = .scaleToFill
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = true
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(red: 0.82, green: 0.91, blue: 0.90, alpha: 1).cgColor
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        textPanelView.backgroundColor = .clear
        textPanelView.layer.cornerRadius = 8
        textPanelView.layer.masksToBounds = true
        textPanelView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textPanelView)

        coinLabel.font = .systemFont(ofSize: 23, weight: .bold)
        coinLabel.textColor = UIColor(red: 0.22, green: 0.18, blue: 0.12, alpha: 1)
        coinLabel.textAlignment = .center
        coinLabel.adjustsFontSizeToFitWidth = true
        coinLabel.minimumScaleFactor = 0.72
        coinLabel.translatesAutoresizingMaskIntoConstraints = false

        coinTitleLabel.text = "Coins"
        coinTitleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        coinTitleLabel.textColor = UIColor(red: 0.62, green: 0.48, blue: 0.28, alpha: 1)
        coinTitleLabel.textAlignment = .center
        coinTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        priceLabel.font = .systemFont(ofSize: 15, weight: .bold)
        priceLabel.textColor = UIColor(red: 0.96, green: 0.48, blue: 0.04, alpha: 1)
        priceLabel.textAlignment = .center
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.minimumScaleFactor = 0.78
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        textStackView.axis = .vertical
        textStackView.alignment = .fill
        textStackView.spacing = 6
        textStackView.translatesAutoresizingMaskIntoConstraints = false

        textStackView.addArrangedSubview(coinLabel)
        textStackView.addArrangedSubview(coinTitleLabel)
        textStackView.addArrangedSubview(priceLabel)
        textPanelView.addSubview(textStackView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            textPanelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            textPanelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            textPanelView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textPanelView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.76),

            textStackView.leadingAnchor.constraint(equalTo: textPanelView.leadingAnchor, constant: 6),
            textStackView.trailingAnchor.constraint(equalTo: textPanelView.trailingAnchor, constant: -6),
            textStackView.centerYAnchor.constraint(equalTo: textPanelView.centerYAnchor),
            textStackView.topAnchor.constraint(greaterThanOrEqualTo: textPanelView.topAnchor, constant: 8),
            textStackView.bottomAnchor.constraint(lessThanOrEqualTo: textPanelView.bottomAnchor, constant: -8),

            coinLabel.heightAnchor.constraint(equalToConstant: 27),
            coinTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            priceLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

}
