//
//  EditProfileViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/4.
//

import UIKit

final class EditProfileViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let topBackground = "EmotionSync/ShareEmotions/share_emotions_background"
        static let avatarEditIcon = "Profile/profile_avatar_edit_icon"
    }

    private let avatarImageView = UIImageView()
    private let avatarInitialLabel = UILabel()
    private let nicknameTextField = UITextField()
    private weak var photoOptionsOverlayView: UIView?
    private var selectedAvatarImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        selectedAvatarImage = ProfileStore.avatarImage
        setupContent()
        setupKeyboardDismiss()
        updateAvatarView()
    }

    private func setupContent() {
        view.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1)

        let backgroundImageView = UIImageView(image: UIImage(named: Asset.topBackground))
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Edit Profile"
        titleLabel.font = .systemFont(ofSize: 25, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        let avatarContainer = UIControl()
        avatarContainer.addTarget(self, action: #selector(showPhotoOptions), for: .touchUpInside)
        avatarContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarContainer)

        avatarImageView.backgroundColor = UIColor(red: 0.96, green: 0.75, blue: 0.42, alpha: 1)
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 46
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.masksToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainer.addSubview(avatarImageView)

        avatarInitialLabel.font = .systemFont(ofSize: 36, weight: .semibold)
        avatarInitialLabel.textColor = .white
        avatarInitialLabel.textAlignment = .center
        avatarInitialLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.addSubview(avatarInitialLabel)

        let editBadgeView = UIImageView(image: UIImage(named: Asset.avatarEditIcon))
        editBadgeView.contentMode = .scaleAspectFit
        editBadgeView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainer.addSubview(editBadgeView)

        let fieldContainerView = UIView()
        fieldContainerView.backgroundColor = .white
        fieldContainerView.layer.cornerRadius = 9
        fieldContainerView.layer.masksToBounds = true
        fieldContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fieldContainerView)

        nicknameTextField.text = ProfileStore.displayName
        nicknameTextField.borderStyle = .none
        nicknameTextField.clearButtonMode = .whileEditing
        nicknameTextField.returnKeyType = .done
        nicknameTextField.font = .systemFont(ofSize: 16, weight: .regular)
        nicknameTextField.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.22, alpha: 1)
        nicknameTextField.attributedPlaceholder = NSAttributedString(
            string: "Nickname",
            attributes: [
                .foregroundColor: UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1),
                .font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )
        nicknameTextField.delegate = self
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        fieldContainerView.addSubview(nicknameTextField)

        let saveButton = UIButton(type: .custom)
        saveButton.backgroundColor = UIColor(red: 0.08, green: 0.10, blue: 0.08, alpha: 1)
        saveButton.layer.cornerRadius = 15
        saveButton.layer.masksToBounds = true
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        saveButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 220),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            avatarContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 98),
            avatarContainer.widthAnchor.constraint(equalToConstant: 100),
            avatarContainer.heightAnchor.constraint(equalToConstant: 100),

            avatarImageView.centerXAnchor.constraint(equalTo: avatarContainer.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarContainer.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 92),
            avatarImageView.heightAnchor.constraint(equalToConstant: 92),

            avatarInitialLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            avatarInitialLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),

            editBadgeView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -2),
            editBadgeView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -2),
            editBadgeView.widthAnchor.constraint(equalToConstant: 28),
            editBadgeView.heightAnchor.constraint(equalToConstant: 28),

            fieldContainerView.topAnchor.constraint(equalTo: avatarContainer.bottomAnchor, constant: 46),
            fieldContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            fieldContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            fieldContainerView.heightAnchor.constraint(equalToConstant: 56),

            nicknameTextField.leadingAnchor.constraint(equalTo: fieldContainerView.leadingAnchor, constant: 18),
            nicknameTextField.trailingAnchor.constraint(equalTo: fieldContainerView.trailingAnchor, constant: -18),
            nicknameTextField.topAnchor.constraint(equalTo: fieldContainerView.topAnchor),
            nicknameTextField.bottomAnchor.constraint(equalTo: fieldContainerView.bottomAnchor),

            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            saveButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }

    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    private func updateAvatarView() {
        avatarImageView.image = selectedAvatarImage
        avatarInitialLabel.isHidden = selectedAvatarImage != nil
        avatarInitialLabel.text = ProfileStore.avatarInitial()
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func saveProfile() {
        view.endEditing(true)

        let nickname = nicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !nickname.isEmpty else {
            showSimpleAlert(title: "Please enter your nickname.")
            return
        }

        ProfileStore.save(displayName: nickname, avatarImage: selectedAvatarImage)
        dismiss(animated: true)
    }

}

private extension EditProfileViewController {

    @objc func showPhotoOptions() {
        view.endEditing(true)
        guard photoOptionsOverlayView == nil else { return }

        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.18)
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

    func makePhotoOptionButton(title: String, action: Selector, isCancel: Bool = false) -> UIButton {
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

    func makePhotoOptionSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        return view
    }

    func makePhotoOptionGap() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }

    @objc func dismissPhotoOptions() {
        closePhotoOptionsOverlay(completion: nil)
    }

    func closePhotoOptionsOverlay(completion: (() -> Void)?) {
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

    @objc func selectCameraPhoto() {
        closePhotoOptionsOverlay { [weak self] in
            self?.presentImagePicker(sourceType: .camera)
        }
    }

    @objc func selectLibraryPhoto() {
        closePhotoOptionsOverlay { [weak self] in
            self?.presentImagePicker(sourceType: .photoLibrary)
        }
    }

    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }

}

extension EditProfileViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveProfile()
        return true
    }

}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        selectedAvatarImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
        updateAvatarView()
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

}
