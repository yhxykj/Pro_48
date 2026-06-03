//
//  HomeCompanionCell.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/1.
//

import UIKit

final class HomeCompanionCell: UITableViewCell {

    static let reuseIdentifier = "HomeCompanionCell"

    private let cardImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cardImageView.image = nil
    }

    func configure(with companion: HomeCompanion) {
        cardImageView.image = UIImage(named: companion.cellImageName)
    }

    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        cardImageView.contentMode = .scaleToFill
        cardImageView.clipsToBounds = true
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardImageView)

        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13)
        ])
    }

}
