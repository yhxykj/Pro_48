//
//  SettingWebViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/4.
//

import UIKit
import WebKit

final class SettingWebViewController: UIViewController {

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let topBackground = "EmotionSync/ShareEmotions/share_emotions_background"
    }

    private let pageTitle: String
    private let pageURL: URL
    private let webView = WKWebView(frame: .zero)
    private let progressView = UIProgressView(progressViewStyle: .bar)
    private let errorView = UIView()
    private var progressObservation: NSKeyValueObservation?

    init(title: String, url: URL) {
        self.pageTitle = title
        self.pageURL = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
        observeLoadingProgress()
        loadPage()
    }

    deinit {
        progressObservation?.invalidate()
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

        let titleLabel = UILabel()
        titleLabel.text = pageTitle
        titleLabel.font = .systemFont(ofSize: 22, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        progressView.progressTintColor = UIColor(red: 0.42, green: 0.65, blue: 1.00, alpha: 1)
        progressView.trackTintColor = UIColor(red: 0.88, green: 0.92, blue: 0.98, alpha: 1)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)

        webView.navigationDelegate = self
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        setupErrorView()

        NSLayoutConstraint.activate([
            topBackgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundImageView.heightAnchor.constraint(equalToConstant: 180),

            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backButton.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -58),

            progressView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            progressView.heightAnchor.constraint(equalToConstant: 2),

            webView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 13),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 36),
            errorView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -36),
            errorView.widthAnchor.constraint(lessThanOrEqualToConstant: 310)
        ])
    }

    private func setupErrorView() {
        errorView.backgroundColor = .white
        errorView.layer.cornerRadius = 16
        errorView.layer.shadowColor = UIColor.black.cgColor
        errorView.layer.shadowOpacity = 0.10
        errorView.layer.shadowRadius = 16
        errorView.layer.shadowOffset = CGSize(width: 0, height: 8)
        errorView.isHidden = true
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)

        let titleLabel = UILabel()
        titleLabel.text = "Unable to load"
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(titleLabel)

        let messageLabel = UILabel()
        messageLabel.text = "Please check your network and try again."
        messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        messageLabel.textColor = UIColor(red: 0.42, green: 0.42, blue: 0.44, alpha: 1)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(messageLabel)

        let retryButton = UIButton(type: .custom)
        retryButton.backgroundColor = UIColor(red: 0.08, green: 0.10, blue: 0.08, alpha: 1)
        retryButton.layer.cornerRadius = 13
        retryButton.layer.masksToBounds = true
        retryButton.setTitle("Retry", for: .normal)
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        retryButton.addTarget(self, action: #selector(retryLoading), for: .touchUpInside)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(retryButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: errorView.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -24),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 28),
            messageLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -28),

            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 22),
            retryButton.leadingAnchor.constraint(equalTo: errorView.leadingAnchor, constant: 42),
            retryButton.trailingAnchor.constraint(equalTo: errorView.trailingAnchor, constant: -42),
            retryButton.heightAnchor.constraint(equalToConstant: 44),
            retryButton.bottomAnchor.constraint(equalTo: errorView.bottomAnchor, constant: -26)
        ])
    }

    private func observeLoadingProgress() {
        progressObservation = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            guard let self else { return }

            self.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            self.progressView.isHidden = webView.estimatedProgress >= 1
        }
    }

    private func loadPage() {
        errorView.isHidden = true
        progressView.isHidden = false
        progressView.progress = 0
        webView.load(URLRequest(url: pageURL))
    }

    @objc private func retryLoading() {
        loadPage()
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

}

extension SettingWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        errorView.isHidden = false
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        errorView.isHidden = false
    }

}
