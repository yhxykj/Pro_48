//
//  EmptyStateView.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import UIKit

final class EmptyStateView: UIView {

    private enum Asset {
        static let noDataIcon = "Common/empty_no_data_icon"
    }

    private let imageView = UIImageView(image: UIImage(named: Asset.noDataIcon))

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupContent()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContent() {
        backgroundColor = .clear
        isHidden = true

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 118),
            imageView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }

}
