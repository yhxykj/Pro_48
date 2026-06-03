//
//  MessageVideoCallViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import AVFoundation
import UIKit

final class MessageVideoCallViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let topBackground = "EmotionSync/ShareEmotions/share_emotions_background"
        static let avatarRing = "Message/VideoCall/video_call_avatar_ring"
        static let micSelected = "Message/VideoCall/video_call_mic_selected"
        static let micNormal = "Message/VideoCall/video_call_mic_normal"
        static let speakerSelected = "Message/VideoCall/video_call_speaker_selected"
        static let speakerNormal = "Message/VideoCall/video_call_speaker_normal"
        static let hangupButton = "Message/VideoCall/video_call_hangup_button"
    }

    private let friend: MessageFriend
    private let captureQueue = DispatchQueue(label: "com.sockes.messageVideoCall.capture")
    private var captureSession: AVCaptureSession?

    init(friend: MessageFriend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
        requestCallPermissionsAndStartSession()
    }

    deinit {
        stopCaptureSession()
    }

    private func setupContent() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.97, alpha: 1)

        let topBackgroundImageView = UIImageView(image: UIImage(named: Asset.topBackground))
        topBackgroundImageView.contentMode = .scaleToFill
        topBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBackgroundImageView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let nameLabel = UILabel()
        nameLabel.text = friend.name
        nameLabel.font = .systemFont(ofSize: 23, weight: .regular)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)

        let avatarAreaView = UIView()
        avatarAreaView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarAreaView)

        let connectingLabel = UILabel()
        connectingLabel.text = "Connecting..."
        connectingLabel.font = .systemFont(ofSize: 16, weight: .regular)
        connectingLabel.textColor = UIColor(red: 0.48, green: 0.48, blue: 0.49, alpha: 1)
        connectingLabel.textAlignment = .center
        connectingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(connectingLabel)

        let ringImageView = UIImageView(image: UIImage(named: Asset.avatarRing))
        ringImageView.contentMode = .scaleAspectFit
        ringImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarAreaView.addSubview(ringImageView)

        let avatarView = UIView()
        avatarView.backgroundColor = friend.avatarColor
        avatarView.layer.cornerRadius = 72
        avatarView.layer.masksToBounds = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarAreaView.addSubview(avatarView)

        let avatarLabel = UILabel()
        avatarLabel.text = String(friend.name.prefix(1))
        avatarLabel.font = .systemFont(ofSize: 52, weight: .semibold)
        avatarLabel.textColor = .white
        avatarLabel.textAlignment = .center
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(avatarLabel)

        let speakerButton = makeToggleButton(normalImageName: Asset.speakerNormal, selectedImageName: Asset.speakerSelected)
        speakerButton.isSelected = true
        speakerButton.addTarget(self, action: #selector(toggleCallButton(_:)), for: .touchUpInside)
        view.addSubview(speakerButton)

        let hangupButton = makeControlButton(imageName: Asset.hangupButton)
        hangupButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        view.addSubview(hangupButton)
        startHangupShake(on: hangupButton)

        let micButton = makeToggleButton(normalImageName: Asset.micNormal, selectedImageName: Asset.micSelected)
        micButton.isSelected = true
        micButton.addTarget(self, action: #selector(toggleCallButton(_:)), for: .touchUpInside)
        view.addSubview(micButton)

        NSLayoutConstraint.activate([
            topBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundImageView.heightAnchor.constraint(equalToConstant: 180),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            avatarAreaView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarAreaView.topAnchor.constraint(equalTo: view.topAnchor, constant: 210),
            avatarAreaView.widthAnchor.constraint(equalToConstant: 234.79),
            avatarAreaView.heightAnchor.constraint(equalToConstant: 207.24),

            ringImageView.centerXAnchor.constraint(equalTo: avatarAreaView.centerXAnchor),
            ringImageView.centerYAnchor.constraint(equalTo: avatarAreaView.centerYAnchor),
            ringImageView.widthAnchor.constraint(equalToConstant: 234.79),
            ringImageView.heightAnchor.constraint(equalToConstant: 207.24),

            avatarView.leadingAnchor.constraint(equalTo: avatarAreaView.leadingAnchor, constant: 29),
            avatarView.topAnchor.constraint(equalTo: avatarAreaView.topAnchor, constant: 29),
            avatarView.widthAnchor.constraint(equalToConstant: 141.94),
            avatarView.heightAnchor.constraint(equalToConstant: 141.94),

            avatarLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),

            connectingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectingLabel.topAnchor.constraint(equalTo: avatarAreaView.bottomAnchor, constant: 24),

            speakerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            speakerButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 570),
            speakerButton.widthAnchor.constraint(equalToConstant: 48),
            speakerButton.heightAnchor.constraint(equalToConstant: 48),

            hangupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hangupButton.centerYAnchor.constraint(equalTo: speakerButton.centerYAnchor),
            hangupButton.widthAnchor.constraint(equalToConstant: 48),
            hangupButton.heightAnchor.constraint(equalToConstant: 48),

            micButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            micButton.centerYAnchor.constraint(equalTo: speakerButton.centerYAnchor),
            micButton.widthAnchor.constraint(equalToConstant: 48),
            micButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    private func makeControlButton(imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func requestCallPermissionsAndStartSession() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] videoGranted in
            AVCaptureDevice.requestAccess(for: .audio) { [weak self] audioGranted in
                guard let self, videoGranted, audioGranted else { return }

                self.captureQueue.async {
                    self.configureCaptureSession()
                }
            }
        }
    }

    private func configureCaptureSession() {
        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = .medium

        if
            let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
            let cameraInput = try? AVCaptureDeviceInput(device: cameraDevice),
            session.canAddInput(cameraInput) {
            session.addInput(cameraInput)
        }

        if
            let microphoneDevice = AVCaptureDevice.default(for: .audio),
            let microphoneInput = try? AVCaptureDeviceInput(device: microphoneDevice),
            session.canAddInput(microphoneInput) {
            session.addInput(microphoneInput)
        }

        session.commitConfiguration()
        captureSession = session
        session.startRunning()
    }

    private func stopCaptureSession() {
        captureQueue.async { [captureSession] in
            captureSession?.stopRunning()
        }
    }

    private func startHangupShake(on button: UIButton) {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [-0.08, 0.08, -0.06, 0.06, 0]
        animation.duration = 0.36
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        button.layer.add(animation, forKey: "hangupShake")
    }

    private func makeToggleButton(normalImageName: String, selectedImageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: normalImageName), for: .normal)
        button.setImage(UIImage(named: selectedImageName), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    private func makeSmallFaceView(text: String) -> UIView {
        let faceView = UIView()
        faceView.backgroundColor = UIColor(red: 0.77, green: 0.95, blue: 0.98, alpha: 1)
        faceView.layer.cornerRadius = 14
        faceView.layer.shadowColor = UIColor(red: 0.42, green: 0.64, blue: 0.88, alpha: 0.35).cgColor
        faceView.layer.shadowOpacity = 1
        faceView.layer.shadowRadius = 5
        faceView.layer.shadowOffset = CGSize(width: 0, height: 2)
        faceView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 0.12, green: 0.17, blue: 0.18, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        faceView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: faceView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: faceView.centerYAnchor)
        ])

        return faceView
    }

    @objc private func closePage() {
        stopCaptureSession()
        dismiss(animated: true)
    }

    @objc private func toggleCallButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }

}
