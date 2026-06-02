//
//  ShareEmotionsViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/2.
//

import UIKit

final class ShareEmotionsViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let background = "EmotionSync/ShareEmotions/share_emotions_background"
        static let coinIcon = "EmotionSync/ShareEmotions/share_emotions_coin_icon"
        static let closeIcon = "EmotionSync/ShareEmotions/share_emotions_close_icon"
        static let addPhotoIcon = "EmotionSync/ShareEmotions/share_emotions_add_photo_icon"
    }

    private let feelingsTextView = UITextView()
    private let placeholderLabel = UILabel()
    private let selectedPhotoImageView = UIImageView()
    private weak var addPhotoView: UIView?
    private weak var closePhotoView: UIView?
    private weak var photoOptionsOverlayView: UIView?
    private var selectedPhoto: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
        setupKeyboardDismiss()
    }

    private func setupContent() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let contentView = UIView()
        contentView.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)

        let backgroundImageView = UIImageView(image: UIImage(named: Asset.background))
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backgroundImageView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Share Emotions"
        titleLabel.font = .systemFont(ofSize: 25, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        feelingsTextView.backgroundColor = .white
        feelingsTextView.layer.cornerRadius = 9
        feelingsTextView.layer.masksToBounds = true
        feelingsTextView.font = .systemFont(ofSize: 15, weight: .regular)
        feelingsTextView.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1)
        feelingsTextView.textContainerInset = UIEdgeInsets(top: 22, left: 18, bottom: 18, right: 18)
        feelingsTextView.delegate = self
        feelingsTextView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(feelingsTextView)

        placeholderLabel.text = "Please write down your feelings"
        placeholderLabel.font = .systemFont(ofSize: 15, weight: .regular)
        placeholderLabel.textColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        feelingsTextView.addSubview(placeholderLabel)

        let photoContainerView = UIView()
        photoContainerView.backgroundColor = .white
        photoContainerView.layer.cornerRadius = 9
        photoContainerView.layer.masksToBounds = false
        photoContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photoContainerView)

        selectedPhotoImageView.contentMode = .scaleAspectFill
        selectedPhotoImageView.clipsToBounds = true
        selectedPhotoImageView.layer.cornerRadius = 9
        selectedPhotoImageView.isHidden = true
        selectedPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoContainerView.addSubview(selectedPhotoImageView)

        let addPhotoView = makeAddPhotoView()
        self.addPhotoView = addPhotoView
        addPhotoView.isUserInteractionEnabled = true
        addPhotoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPhotoOptions)))
        addPhotoView.translatesAutoresizingMaskIntoConstraints = false
        photoContainerView.addSubview(addPhotoView)

        let closeView = makeCloseView()
        closePhotoView = closeView
        closeView.isHidden = true
        closeView.isUserInteractionEnabled = true
        closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeSelectedPhoto)))
        closeView.translatesAutoresizingMaskIntoConstraints = false
        photoContainerView.addSubview(closeView)

        let shareButton = makeShareButton()
        shareButton.addTarget(self, action: #selector(shareEmotion), for: .touchUpInside)
        contentView.addSubview(shareButton)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),

            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 200),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            feelingsTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 119),
            feelingsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            feelingsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            feelingsTextView.heightAnchor.constraint(equalToConstant: 240),

            placeholderLabel.topAnchor.constraint(equalTo: feelingsTextView.topAnchor, constant: 22),
            placeholderLabel.leadingAnchor.constraint(equalTo: feelingsTextView.leadingAnchor, constant: 22),

            photoContainerView.topAnchor.constraint(equalTo: feelingsTextView.bottomAnchor, constant: 18),
            photoContainerView.leadingAnchor.constraint(equalTo: feelingsTextView.leadingAnchor),
            photoContainerView.widthAnchor.constraint(equalToConstant: 94),
            photoContainerView.heightAnchor.constraint(equalToConstant: 94),

            selectedPhotoImageView.topAnchor.constraint(equalTo: photoContainerView.topAnchor),
            selectedPhotoImageView.leadingAnchor.constraint(equalTo: photoContainerView.leadingAnchor),
            selectedPhotoImageView.trailingAnchor.constraint(equalTo: photoContainerView.trailingAnchor),
            selectedPhotoImageView.bottomAnchor.constraint(equalTo: photoContainerView.bottomAnchor),

            addPhotoView.centerXAnchor.constraint(equalTo: photoContainerView.centerXAnchor),
            addPhotoView.centerYAnchor.constraint(equalTo: photoContainerView.centerYAnchor),
            addPhotoView.widthAnchor.constraint(equalToConstant: 31),
            addPhotoView.heightAnchor.constraint(equalToConstant: 31),

            closeView.topAnchor.constraint(equalTo: photoContainerView.topAnchor, constant: -3),
            closeView.trailingAnchor.constraint(equalTo: photoContainerView.trailingAnchor, constant: 3),
            closeView.widthAnchor.constraint(equalToConstant: 22),
            closeView.heightAnchor.constraint(equalToConstant: 22),

            shareButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 43),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -43),
            shareButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 662),
            shareButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    private func makeAddPhotoView() -> UIView {
        if let image = UIImage(named: Asset.addPhotoIcon) {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }

        let label = UILabel()
        label.text = "+"
        label.font = .systemFont(ofSize: 44, weight: .ultraLight)
        label.textColor = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1)
        label.textAlignment = .center
        return label
    }

    private func makeCloseView() -> UIView {
        if let image = UIImage(named: Asset.closeIcon) {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }

        let label = UILabel()
        label.text = "×"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 1.00, green: 0.40, blue: 0.40, alpha: 1)
        label.layer.cornerRadius = 11
        label.layer.masksToBounds = true
        return label
    }

    private func makeShareButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 0.07, green: 0.09, blue: 0.07, alpha: 1)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false

        let leftStarLabel = makeStarLabel()
        let titleLabel = UILabel()
        titleLabel.text = "Share"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let rightStarLabel = makeStarLabel()
        let coinView = makeCoinView()
        coinView.translatesAutoresizingMaskIntoConstraints = false

        let coinCountLabel = UILabel()
        coinCountLabel.text = "99"
        coinCountLabel.textColor = .white
        coinCountLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        coinCountLabel.translatesAutoresizingMaskIntoConstraints = false

        button.addSubview(leftStarLabel)
        button.addSubview(titleLabel)
        button.addSubview(rightStarLabel)
        button.addSubview(coinView)
        button.addSubview(coinCountLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor, constant: -14),
            titleLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            leftStarLabel.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -18),
            leftStarLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            rightStarLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 18),
            rightStarLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            coinView.leadingAnchor.constraint(equalTo: rightStarLabel.trailingAnchor, constant: 21),
            coinView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            coinView.widthAnchor.constraint(equalToConstant: 22),
            coinView.heightAnchor.constraint(equalToConstant: 22),

            coinCountLabel.leadingAnchor.constraint(equalTo: coinView.trailingAnchor, constant: 5),
            coinCountLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])

        return button
    }

    private func makeCoinView() -> UIView {
        if let image = UIImage(named: Asset.coinIcon) {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }

        let label = UILabel()
        label.text = "¥"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(red: 0.78, green: 0.43, blue: 0.00, alpha: 1)
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 1.00, green: 0.74, blue: 0.17, alpha: 1)
        label.layer.cornerRadius = 11
        label.layer.masksToBounds = true
        return label
    }

    private func makeStarLabel() -> UILabel {
        let label = UILabel()
        label.text = "✦"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor.white.withAlphaComponent(0.34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func showPhotoOptions() {
        view.endEditing(true)
        guard photoOptionsOverlayView == nil else { return }

        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.28)
        overlayView.alpha = 0
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        photoOptionsOverlayView = overlayView

        let dismissControl = UIControl()
        dismissControl.addTarget(self, action: #selector(dismissPhotoOptions), for: .touchUpInside)
        dismissControl.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(dismissControl)

        let sheetView = UIView()
        sheetView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(sheetView)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.addSubview(stackView)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            stackView.addArrangedSubview(makePhotoOptionButton(title: "Camera", action: #selector(selectCameraPhoto)))
            stackView.addArrangedSubview(makePhotoOptionSeparator())
        }

        stackView.addArrangedSubview(makePhotoOptionButton(title: "Photo Library", action: #selector(selectLibraryPhoto)))
        stackView.addArrangedSubview(makePhotoOptionGap())
        stackView.addArrangedSubview(makePhotoOptionButton(title: "Cancel", action: #selector(dismissPhotoOptions), isCancel: true))

        let sheetBottomConstraint = sheetView.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: 220)

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            dismissControl.topAnchor.constraint(equalTo: overlayView.topAnchor),
            dismissControl.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
            dismissControl.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor),
            dismissControl.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor),

            sheetView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor),
            sheetBottomConstraint,

            stackView.topAnchor.constraint(equalTo: sheetView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: sheetView.safeAreaLayoutGuide.bottomAnchor)
        ])

        view.layoutIfNeeded()
        sheetBottomConstraint.constant = 0

        UIView.animate(withDuration: 0.24, delay: 0, options: [.curveEaseOut]) {
            overlayView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    private func makePhotoOptionButton(title: String, action: Selector, isCancel: Bool = false) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.setTitle(title, for: .normal)
        button.setTitleColor(isCancel ? UIColor(red: 1.00, green: 0.36, blue: 0.36, alpha: 1) : .black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: isCancel ? .semibold : .regular)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }

    private func makePhotoOptionSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        return view
    }

    private func makePhotoOptionGap() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }

    @objc private func selectCameraPhoto() {
        closePhotoOptionsOverlay { [weak self] in
            self?.presentImagePicker(sourceType: .camera)
        }
    }

    @objc private func selectLibraryPhoto() {
        closePhotoOptionsOverlay { [weak self] in
            self?.presentImagePicker(sourceType: .photoLibrary)
        }
    }

    @objc private func dismissPhotoOptions() {
        closePhotoOptionsOverlay(completion: nil)
    }

    private func closePhotoOptionsOverlay(completion: (() -> Void)?) {
        guard let photoOptionsOverlayView else {
            completion?()
            return
        }

        UIView.animate(withDuration: 0.18) {
            photoOptionsOverlayView.alpha = 0
        } completion: { _ in
            photoOptionsOverlayView.removeFromSuperview()
            completion?()
        }
    }

    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }

    @objc private func removeSelectedPhoto() {
        selectedPhoto = nil
        selectedPhotoImageView.image = nil
        selectedPhotoImageView.isHidden = true
        addPhotoView?.isHidden = false
        closePhotoView?.isHidden = true
    }

    @objc private func shareEmotion() {
        view.endEditing(true)

        let feelings = feelingsTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !feelings.isEmpty else {
            showMessage("Please write down your feelings first.")
            return
        }

        guard selectedPhoto != nil else {
            showMessage("Please add a photo first.")
            return
        }

        showShareSuccessAndReturn()
    }

    private func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    private func showShareSuccessAndReturn() {
        let alertController = UIAlertController(title: nil, message: "Shared successfully.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        })
        present(alertController, animated: true)
    }

}

extension ShareEmotionsViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

}

extension ShareEmotionsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
        selectedPhoto = image
        selectedPhotoImageView.image = image
        selectedPhotoImageView.isHidden = image == nil
        addPhotoView?.isHidden = image != nil
        closePhotoView?.isHidden = image == nil
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}
