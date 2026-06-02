//
//  MoodBottleViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/2.
//

import UIKit

final class MoodBottleViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let bottle = "EmotionSync/MoodBottle/mood_bottle_bottle"
        static let moodBarBackground = "EmotionSync/MoodBottle/mood_bottle_mood_bar_background"
        static let sadNormal = "EmotionSync/MoodBottle/mood_bottle_sad_normal"
        static let sadSelected = "EmotionSync/MoodBottle/mood_bottle_sad_selected"
        static let anxiousNormal = "EmotionSync/MoodBottle/mood_bottle_anxious_normal"
        static let anxiousSelected = "EmotionSync/MoodBottle/mood_bottle_anxious_selected"
        static let angryNormal = "EmotionSync/MoodBottle/mood_bottle_angry_normal"
        static let angrySelected = "EmotionSync/MoodBottle/mood_bottle_angry_selected"
        static let happyNormal = "EmotionSync/MoodBottle/mood_bottle_happy_normal"
        static let happySelected = "EmotionSync/MoodBottle/mood_bottle_happy_selected"
    }

    fileprivate enum Mood: CaseIterable {
        case sad
        case anxious
        case angry
        case happy

        var title: String {
            switch self {
            case .sad:
                return "Sad"
            case .anxious:
                return "Anxious"
            case .angry:
                return "Angry"
            case .happy:
                return "Happy"
            }
        }

        var normalIconName: String {
            switch self {
            case .sad:
                return Asset.sadNormal
            case .anxious:
                return Asset.anxiousNormal
            case .angry:
                return Asset.angryNormal
            case .happy:
                return Asset.happyNormal
            }
        }

        var selectedIconName: String {
            switch self {
            case .sad:
                return Asset.sadSelected
            case .anxious:
                return Asset.anxiousSelected
            case .angry:
                return Asset.angrySelected
            case .happy:
                return Asset.happySelected
            }
        }
    }

    private var selectedMood: Mood = .sad
    private var moodOptionViews: [MoodBottleOptionView] = []
    private let bottleImageView = UIImageView()
    private var isThrowingBottle = false
    private weak var releasePromptView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
    }

    private func setupContent() {
        view.backgroundColor = .white

        let gradientView = MoodBottleGradientView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gradientView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        let titleLabel = UILabel()
        titleLabel.text = "Mood Bottle"
        titleLabel.font = .systemFont(ofSize: 25, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        bottleImageView.image = UIImage(named: Asset.bottle)
        bottleImageView.contentMode = .scaleToFill
        bottleImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottleImageView)

        let moodBarImageView = UIImageView(image: UIImage(named: Asset.moodBarBackground))
        moodBarImageView.contentMode = .scaleToFill
        moodBarImageView.clipsToBounds = true
        moodBarImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moodBarImageView)

        moodOptionViews = Mood.allCases.map { mood in
            let optionView = MoodBottleOptionView(mood: mood)
            optionView.configure(isSelected: mood == selectedMood)
            optionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectMood(_:))))
            return optionView
        }

        let moodStackView = UIStackView(arrangedSubviews: moodOptionViews)
        moodStackView.axis = .horizontal
        moodStackView.distribution = .equalSpacing
        moodStackView.alignment = .center
        moodStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moodStackView)

        let startButton = makeStartButton(
            titleColor: .white,
            starColor: UIColor.white.withAlphaComponent(0.34),
            backgroundColor: UIColor(red: 0.07, green: 0.09, blue: 0.07, alpha: 1)
        )
        startButton.addTarget(self, action: #selector(startBottleThrowAnimation), for: .touchUpInside)
        view.addSubview(startButton)

        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 622),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),

            bottleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 122),
            bottleImageView.widthAnchor.constraint(equalToConstant: 246),
            bottleImageView.heightAnchor.constraint(equalToConstant: 381),

            moodBarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            moodBarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            moodBarImageView.topAnchor.constraint(equalTo: bottleImageView.bottomAnchor, constant: 63),
            moodBarImageView.heightAnchor.constraint(equalToConstant: 100),

            moodStackView.leadingAnchor.constraint(equalTo: moodBarImageView.leadingAnchor, constant: 23),
            moodStackView.trailingAnchor.constraint(equalTo: moodBarImageView.trailingAnchor, constant: -23),
            moodStackView.centerYAnchor.constraint(equalTo: moodBarImageView.centerYAnchor, constant: 4),

            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 43),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -43),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            startButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    private func makeStartButton(titleColor: UIColor, starColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false

        let leftStarLabel = makeStarLabel(color: starColor)
        let titleLabel = UILabel()
        titleLabel.text = "Start"
        titleLabel.textColor = titleColor
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let rightStarLabel = makeStarLabel(color: starColor)

        button.addSubview(leftStarLabel)
        button.addSubview(titleLabel)
        button.addSubview(rightStarLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            leftStarLabel.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -18),
            leftStarLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            rightStarLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 18),
            rightStarLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])

        return button
    }

    private func makeStarLabel(color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = "✦"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

    @objc private func selectMood(_ gesture: UITapGestureRecognizer) {
        guard let optionView = gesture.view as? MoodBottleOptionView else { return }

        selectedMood = optionView.mood
        moodOptionViews.forEach { view in
            view.configure(isSelected: view.mood == selectedMood)
        }
    }

    @objc private func startBottleThrowAnimation() {
        guard !isThrowingBottle else { return }

        isThrowingBottle = true
        bottleImageView.layer.removeAllAnimations()

        UIView.animate(
            withDuration: 0.12,
            delay: 0,
            options: [.curveEaseOut]
        ) {
            self.bottleImageView.transform = CGAffineTransform(translationX: 0, y: -14)
                .rotated(by: -0.08)
                .scaledBy(x: 1.03, y: 1.03)
        } completion: { _ in
            self.throwBottleOut()
        }
    }

    private func throwBottleOut() {
        UIView.animateKeyframes(
            withDuration: 0.72,
            delay: 0,
            options: [.calculationModeCubic]
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.38) {
                self.bottleImageView.transform = CGAffineTransform(translationX: 44, y: -210)
                    .rotated(by: 0.42)
                    .scaledBy(x: 0.88, y: 0.88)
                self.bottleImageView.alpha = 0.92
            }

            UIView.addKeyframe(withRelativeStartTime: 0.28, relativeDuration: 0.42) {
                self.bottleImageView.transform = CGAffineTransform(translationX: 126, y: -470)
                    .rotated(by: 1.04)
                    .scaledBy(x: 0.56, y: 0.56)
                self.bottleImageView.alpha = 0.48
            }

            UIView.addKeyframe(withRelativeStartTime: 0.62, relativeDuration: 0.38) {
                self.bottleImageView.transform = CGAffineTransform(translationX: 210, y: -780)
                    .rotated(by: 1.68)
                    .scaledBy(x: 0.24, y: 0.24)
                self.bottleImageView.alpha = 0
            }
        } completion: { _ in
            self.showFlashLight {
                self.bottleImageView.transform = .identity
                self.bottleImageView.alpha = 1
                self.isThrowingBottle = false
                self.showReleasePrompt()
            }
        }
    }

    private func showFlashLight(completion: @escaping () -> Void) {
        let flashView = UIView()
        flashView.backgroundColor = .white
        flashView.alpha = 0
        flashView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(flashView)

        NSLayoutConstraint.activate([
            flashView.topAnchor.constraint(equalTo: view.topAnchor),
            flashView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flashView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            flashView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.curveEaseOut]
        ) {
            flashView.alpha = 0.92
        } completion: { _ in
            UIView.animate(
                withDuration: 0.32,
                delay: 0.04,
                options: [.curveEaseIn]
            ) {
                flashView.alpha = 0
            } completion: { _ in
                flashView.removeFromSuperview()
                completion()
            }
        }
    }

    private func showReleasePrompt() {
        releasePromptView?.removeFromSuperview()

        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.28)
        overlayView.alpha = 0
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        releasePromptView = overlayView

        let promptView = UIView()
        promptView.backgroundColor = .white
        promptView.layer.cornerRadius = 18
        promptView.layer.masksToBounds = true
        promptView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(promptView)

        let messageLabel = UILabel()
        messageLabel.text = "Take a breath. Your mood has been released."
        messageLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        messageLabel.textColor = UIColor(red: 0.12, green: 0.13, blue: 0.12, alpha: 1)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        promptView.addSubview(messageLabel)

        let okButton = UIButton(type: .custom)
        okButton.setTitle("OK", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        okButton.backgroundColor = UIColor(red: 0.07, green: 0.09, blue: 0.07, alpha: 1)
        okButton.layer.cornerRadius = 22
        okButton.layer.masksToBounds = true
        okButton.addTarget(self, action: #selector(closeReleasePrompt), for: .touchUpInside)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        promptView.addSubview(okButton)

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            promptView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            promptView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            promptView.widthAnchor.constraint(equalToConstant: 286),

            messageLabel.topAnchor.constraint(equalTo: promptView.topAnchor, constant: 32),
            messageLabel.leadingAnchor.constraint(equalTo: promptView.leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: promptView.trailingAnchor, constant: -24),

            okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            okButton.leadingAnchor.constraint(equalTo: promptView.leadingAnchor, constant: 42),
            okButton.trailingAnchor.constraint(equalTo: promptView.trailingAnchor, constant: -42),
            okButton.heightAnchor.constraint(equalToConstant: 44),
            okButton.bottomAnchor.constraint(equalTo: promptView.bottomAnchor, constant: -24)
        ])

        UIView.animate(withDuration: 0.18) {
            overlayView.alpha = 1
        }
    }

    @objc private func closeReleasePrompt() {
        guard let releasePromptView else { return }

        UIView.animate(withDuration: 0.18) {
            releasePromptView.alpha = 0
        } completion: { _ in
            releasePromptView.removeFromSuperview()
        }
    }

}

private final class MoodBottleOptionView: UIView {

    let mood: MoodBottleViewController.Mood

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()

    init(mood: MoodBottleViewController.Mood) {
        self.mood = mood
        super.init(frame: .zero)

        titleLabel.text = mood.title
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(isSelected: Bool) {
        iconImageView.image = UIImage(named: isSelected ? mood.selectedIconName : mood.normalIconName)
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)

        titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        titleLabel.textColor = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 64),

            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 44),
            iconImageView.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

private final class MoodBottleGradientView: UIView {

    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupGradient()
    }

    private func setupGradient() {
        guard let gradientLayer = layer as? CAGradientLayer else { return }
        gradientLayer.colors = [
            UIColor(red: 0.74, green: 0.84, blue: 1.00, alpha: 1).cgColor,
            UIColor(red: 0.78, green: 1.00, blue: 0.94, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.locations = [0, 0.52, 1]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }

}
