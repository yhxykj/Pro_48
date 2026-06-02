//
//  EmotionReportMenuPresenter.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/2.
//

import UIKit

extension UIViewController {

    func showEmotionReportMenu(from sourceView: UIView) {
        view.endEditing(true)

        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.42)
        overlayView.alpha = 0
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)

        let dismissControl = UIControl()
        dismissControl.addAction(UIAction { [weak overlayView] _ in
            UIView.animate(withDuration: 0.18) {
                overlayView?.alpha = 0
            } completion: { _ in
                overlayView?.removeFromSuperview()
            }
        }, for: .touchUpInside)
        dismissControl.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(dismissControl)

        let menuView = UIView()
        menuView.backgroundColor = .white
        menuView.layer.cornerRadius = 10
        menuView.layer.masksToBounds = true
        menuView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(menuView)

        let stackView = UIStackView(arrangedSubviews: [
            makeEmotionReportMenuRow(iconName: "EmotionSync/ReportMenu/report_menu_report_icon", title: "Report"),
            makeEmotionReportMenuRow(iconName: "EmotionSync/ReportMenu/report_menu_block_icon", title: "Block")
        ])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        menuView.addSubview(stackView)

        let sourceFrame = sourceView.convert(sourceView.bounds, to: view)
        let menuWidth: CGFloat = 132
        let rightPadding = max(15, view.bounds.width - sourceFrame.maxX)
        let topConstant = min(sourceFrame.maxY + 12, view.bounds.height - 150)

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            dismissControl.topAnchor.constraint(equalTo: overlayView.topAnchor),
            dismissControl.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
            dismissControl.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor),
            dismissControl.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor),

            menuView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: topConstant),
            menuView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -rightPadding),
            menuView.widthAnchor.constraint(equalToConstant: menuWidth),

            stackView.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 9),
            stackView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: menuView.bottomAnchor, constant: -9)
        ])

        UIView.animate(withDuration: 0.18) {
            overlayView.alpha = 1
        }
    }

    private func makeEmotionReportMenuRow(iconName: String, title: String) -> UIView {
        let rowView = UIView()
        rowView.backgroundColor = .white
        rowView.translatesAutoresizingMaskIntoConstraints = false

        let iconImageView = UIImageView(image: UIImage(named: iconName))
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        rowView.addSubview(iconImageView)

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.20, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        rowView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            rowView.heightAnchor.constraint(equalToConstant: 36),

            iconImageView.leadingAnchor.constraint(equalTo: rowView.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: rowView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 13),
            titleLabel.centerYAnchor.constraint(equalTo: rowView.centerYAnchor)
        ])

        return rowView
    }

}
