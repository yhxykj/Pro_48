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
    }

    func configure(imageName: String) {
        cardView.image = UIImage(named: imageName)
    }

    private func setupContent() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cardView.contentMode = .scaleToFill
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
