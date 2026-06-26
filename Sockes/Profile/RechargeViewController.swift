//
//  RechargeViewController.swift
//  Sockes
//
//  Created by 上包666 on 2026/6/3.
//

import StoreKit
import UIKit

final class RechargeViewController: UIViewController {

    private enum ProductIdentifier {
        static let coin63700 = "sjhdbcrodrkogoyx"
        static let coin49400 = "qjbdjfhbksduwerg"
        static let coin29400 = "swutqcmefssyysqm"
        static let coin16800 = "iwejhjjdbfhqrfnd"
        static let coin10800 = "kaihwzstfvrvljvg"
        static let coin5150 = "fzogbndzawjjdfga"
        static let coin2450 = "smcmexdueucqopyy"
        static let coin800 = "wvdawjqhitlwnnpd"
        static let coin400 = "mneozskrxnvtguds"
    }

    private enum PurchaseVerificationError: Error {
        case failedVerification
    }

    private enum Asset {
        static let backIcon = "Common/common_back_icon"
        static let topBackground = "EmotionSync/ShareEmotions/share_emotions_background"
        static let coinHero = "Profile/Recharge/recharge_coin_hero"
    }

    private struct CoinPackage {
        let productID: String
        let priceText: String
        let coins: Int
    }

    private let balanceLabel = UILabel()
    private let purchaseLoadingView = UIView()
    private let purchaseLoadingIndicatorView = UIActivityIndicatorView(style: .medium)
    private lazy var packageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = .zero

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
            RechargeCoinPackageCell.self,
            forCellWithReuseIdentifier: RechargeCoinPackageCell.reuseIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let coinPackages: [CoinPackage] = [
        CoinPackage(productID: ProductIdentifier.coin63700, priceText: "$99.99", coins: 63700),
        CoinPackage(productID: ProductIdentifier.coin49400, priceText: "$79.99", coins: 49400),
        CoinPackage(productID: ProductIdentifier.coin29400, priceText: "$49.99", coins: 29400),
        CoinPackage(productID: ProductIdentifier.coin16800, priceText: "$29.99", coins: 16800),
        CoinPackage(productID: ProductIdentifier.coin10800, priceText: "$19.99", coins: 10800),
        CoinPackage(productID: ProductIdentifier.coin5150, priceText: "$9.99", coins: 5150),
        CoinPackage(productID: ProductIdentifier.coin2450, priceText: "$4.99", coins: 2450),
        CoinPackage(productID: ProductIdentifier.coin800, priceText: "$1.99", coins: 800),
        CoinPackage(productID: ProductIdentifier.coin400, priceText: "$0.99", coins: 400)
    ]
    private var coinProducts: [String: Product] = [:]
    private var coinBalance = CoinBalanceStore.balance
    private var isPurchasing = false
    private var transactionListenerTask: Task<Void, Never>?

    override func viewDidLoad() {
        super.viewDidLoad()

        coinBalance = CoinBalanceStore.balance
        setupContent()
        transactionListenerTask = listenForTransactions()
        Task {
            await loadCoinProducts()
        }
    }

    deinit {
        transactionListenerTask?.cancel()
    }

    private func setupContent() {
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.97, alpha: 1)

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)

        let topBackgroundImageView = UIImageView(image: UIImage(named: Asset.topBackground))
        topBackgroundImageView.contentMode = .scaleToFill
        topBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topBackgroundImageView)

        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: Asset.backIcon), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backButton)

        let coinHeroImageView = UIImageView(image: UIImage(named: Asset.coinHero))
        coinHeroImageView.contentMode = .scaleAspectFit
        coinHeroImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coinHeroImageView)

        balanceLabel.text = "\(coinBalance)"
        balanceLabel.font = .systemFont(ofSize: 35, weight: .bold)
        balanceLabel.textColor = UIColor(red: 0.27, green: 0.27, blue: 0.28, alpha: 1)
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(balanceLabel)

        let remainLabel = UILabel()
        remainLabel.text = "Remaining Coins"
        remainLabel.font = .systemFont(ofSize: 16, weight: .regular)
        remainLabel.textColor = UIColor(red: 0.67, green: 0.67, blue: 0.68, alpha: 1)
        remainLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(remainLabel)

        contentView.addSubview(packageCollectionView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            topBackgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topBackgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topBackgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topBackgroundImageView.heightAnchor.constraint(equalToConstant: 250),

            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 3),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),

            coinHeroImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            coinHeroImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            coinHeroImageView.widthAnchor.constraint(equalToConstant: 209),
            coinHeroImageView.heightAnchor.constraint(equalToConstant: 209),

            balanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            balanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 150),

            remainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 27),
            remainLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 27),

            packageCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            packageCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            packageCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 256),
            packageCollectionView.heightAnchor.constraint(equalToConstant: 345),
            packageCollectionView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -40)
        ])

        setupPurchaseLoadingView()
    }

    private func purchaseCoinPackage(_ coinPackage: CoinPackage, from cardView: UIView) async {
        isPurchasing = true
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        await animatePackagePress(cardView)
        showPurchaseLoading()

        if coinProducts[coinPackage.productID] == nil {
            await loadCoinProducts()
        }

        guard let coinProduct = coinProducts[coinPackage.productID] else {
            isPurchasing = false
            hidePurchaseLoading()
            showPurchaseMessage("Product is not available yet.")
            return
        }

        do {
            let result = try await coinProduct.purchase()

            switch result {
            case .success(let verificationResult):
                let transaction = try Self.checkVerified(verificationResult)
                await transaction.finish()
                hidePurchaseLoading()
                playCoinPurchaseAnimation(from: cardView, coins: coinPackage.coins)

            case .userCancelled:
                isPurchasing = false
                hidePurchaseLoading()

            case .pending:
                isPurchasing = false
                hidePurchaseLoading()
                showPurchaseMessage("Purchase is pending.")

            @unknown default:
                isPurchasing = false
                hidePurchaseLoading()
            }
        } catch {
            isPurchasing = false
            hidePurchaseLoading()
            showPurchaseMessage("Purchase failed. Please try again.")
        }
    }

    private func setupPurchaseLoadingView() {
        purchaseLoadingView.backgroundColor = UIColor.black.withAlphaComponent(0.16)
        purchaseLoadingView.alpha = 0
        purchaseLoadingView.isHidden = true
        purchaseLoadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(purchaseLoadingView)

        let contentView = UIView()
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.96)
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        purchaseLoadingView.addSubview(contentView)

        purchaseLoadingIndicatorView.color = UIColor(red: 0.10, green: 0.12, blue: 0.10, alpha: 1)
        purchaseLoadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(purchaseLoadingIndicatorView)

        let titleLabel = UILabel()
        titleLabel.text = "Loading..."
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.21, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            purchaseLoadingView.topAnchor.constraint(equalTo: view.topAnchor),
            purchaseLoadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            purchaseLoadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            purchaseLoadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.centerXAnchor.constraint(equalTo: purchaseLoadingView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: purchaseLoadingView.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 132),
            contentView.heightAnchor.constraint(equalToConstant: 104),

            purchaseLoadingIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            purchaseLoadingIndicatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: purchaseLoadingIndicatorView.bottomAnchor, constant: 13)
        ])
    }

    private func showPurchaseLoading() {
        purchaseLoadingView.isHidden = false
        purchaseLoadingIndicatorView.startAnimating()

        UIView.animate(withDuration: 0.16) {
            self.purchaseLoadingView.alpha = 1
        }
    }

    private func hidePurchaseLoading() {
        UIView.animate(withDuration: 0.16) {
            self.purchaseLoadingView.alpha = 0
        } completion: { [weak self] _ in
            self?.purchaseLoadingIndicatorView.stopAnimating()
            self?.purchaseLoadingView.isHidden = true
        }
    }

    private func animatePackagePress(_ cardView: UIView) async {
        await withCheckedContinuation { continuation in
            UIView.animate(
                withDuration: 0.12,
                delay: 0,
                options: [.curveEaseOut]
            ) {
                cardView.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
            } completion: { _ in
                UIView.animate(
                    withDuration: 0.16,
                    delay: 0,
                    options: [.curveEaseOut]
                ) {
                    cardView.transform = .identity
                } completion: { _ in
                    continuation.resume()
                }
            }
        }
    }

    private func loadCoinProducts() async {
        do {
            let productIDs = Set(coinPackages.map(\.productID))
            let products = try await Product.products(for: productIDs)
            coinProducts = Dictionary(uniqueKeysWithValues: products.map { ($0.id, $0) })
        } catch {
            coinProducts = [:]
        }
    }

    private func listenForTransactions() -> Task<Void, Never> {
        Task { [weak self] in
            for await verificationResult in Transaction.updates {
                guard let self else { return }

                do {
                    let transaction = try Self.checkVerified(verificationResult)

                    guard let coinPackage = self.coinPackages.first(where: { $0.productID == transaction.productID }) else {
                        await transaction.finish()
                        continue
                    }

                    await transaction.finish()
                    self.finishConsumablePurchase(coins: coinPackage.coins)
                } catch {
                    continue
                }
            }
        }
    }

    private static func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let safeValue):
            return safeValue
        case .unverified:
            throw PurchaseVerificationError.failedVerification
        }
    }

    private func showPurchaseMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    private func playCoinPurchaseAnimation(from sourceView: UIView, coins: Int) {
        let startFrame = sourceView.convert(sourceView.bounds, to: view)
        let endFrame = balanceLabel.convert(balanceLabel.bounds, to: view)
        let coinView = makeFlyingCoinView()
        coinView.center = CGPoint(x: startFrame.midX, y: startFrame.midY)
        view.addSubview(coinView)

        UIView.animate(
            withDuration: 0.16,
            delay: 0,
            options: [.curveEaseOut]
        ) {
            coinView.transform = CGAffineTransform(scaleX: 1.18, y: 1.18)
        }

        UIView.animateKeyframes(
            withDuration: 0.72,
            delay: 0,
            options: [.calculationModeCubic]
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.35) {
                coinView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                coinView.center = CGPoint(x: startFrame.midX, y: startFrame.midY - 42)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
                coinView.transform = CGAffineTransform(scaleX: 0.45, y: 0.45)
                coinView.center = CGPoint(x: endFrame.midX + 18, y: endFrame.midY)
                coinView.alpha = 0.1
            }
        } completion: { [weak self, weak coinView] _ in
            coinView?.removeFromSuperview()
            self?.finishConsumablePurchase(coins: coins)
        }
    }

    private func makeFlyingCoinView() -> UIView {
        let coinView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        coinView.backgroundColor = UIColor(red: 1.00, green: 0.78, blue: 0.20, alpha: 1)
        coinView.layer.cornerRadius = 14
        coinView.layer.borderWidth = 2
        coinView.layer.borderColor = UIColor(red: 1.00, green: 0.89, blue: 0.39, alpha: 1).cgColor
        coinView.layer.shadowColor = UIColor(red: 0.96, green: 0.45, blue: 0.05, alpha: 0.35).cgColor
        coinView.layer.shadowOpacity = 1
        coinView.layer.shadowRadius = 8
        coinView.layer.shadowOffset = CGSize(width: 0, height: 3)

        let label = UILabel()
        label.text = "¥"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(red: 0.80, green: 0.46, blue: 0.04, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        coinView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: coinView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: coinView.centerYAnchor)
        ])

        return coinView
    }

    private func finishConsumablePurchase(coins: Int) {
        coinBalance = CoinBalanceStore.add(coins)
        balanceLabel.text = "\(coinBalance)"

        UIView.animate(
            withDuration: 0.14,
            delay: 0,
            options: [.curveEaseOut]
        ) {
            self.balanceLabel.transform = CGAffineTransform(scaleX: 1.18, y: 1.18)
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.16) {
                self?.balanceLabel.transform = .identity
            } completion: { [weak self] _ in
                self?.isPurchasing = false
            }
        }
    }

    @objc private func closePage() {
        dismiss(animated: true)
    }

}

extension RechargeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coinPackages.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RechargeCoinPackageCell.reuseIdentifier,
            for: indexPath
        ) as? RechargeCoinPackageCell else {
            return UICollectionViewCell()
        }

        let coinPackage = coinPackages[indexPath.item]
        cell.configure(
            coins: coinPackage.coins,
            priceText: coinPackage.priceText
        )
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isPurchasing,
              let cell = collectionView.cellForItem(at: indexPath) as? RechargeCoinPackageCell else {
            return
        }

        Task {
            let coinPackage = coinPackages[indexPath.item]
            await purchaseCoinPackage(coinPackage, from: cell.cardView)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = floor((collectionView.bounds.width - 40) / 3)
        let height = floor((collectionView.bounds.height - 40) / 3)
        return CGSize(width: width, height: height)
    }

}
