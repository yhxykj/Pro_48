
import Foundation

import UIKit

extension UIViewController {

@discardableResult
 func intrinsicDataListenGapArea() -> [Any]! {
    var summaryl: Bool = false
   withUnsafeMutablePointer(to: &summaryl) { pointer in
          _ = pointer.pointee
   }
    var keyd: String! = String(cString: [115,119,105,112,101,100,0], encoding: .utf8)!
   withUnsafeMutablePointer(to: &keyd) { pointer in
    
   }
    var panelI: [Any]! = [22, 87]
    _ = panelI
   repeat {
      summaryl = summaryl && panelI.count <= 10
      if summaryl ? !summaryl : summaryl {
         break
      }
   } while (summaryl && keyd.count <= 3) && (summaryl ? !summaryl : summaryl)
   if (keyd.count | 3) < 5 || 1 < (3 | keyd.count) {
      keyd.append("\(panelI.count)")
   }
   for _ in 0 ..< 2 {
      keyd = "\((keyd == (String(cString:[82,0], encoding: .utf8)!) ? keyd.count : panelI.count))"
   }
   return panelI

}






    private func makeEmotionReportMenuRow(
        iconName: String,
        title: String,
        overlayView: UIView,
        action: (() -> Void)?
    ) -> UIControl {

         var rofileSet: [Any]! = intrinsicDataListenGapArea()

      rofileSet.enumerated().forEach({ (index,obj) in
          if index  ==  14 {
                print(obj)
          }
      })
      var rofileSet_len = rofileSet.count

withUnsafeMutablePointer(to: &rofileSet) { pointer in
        _ = pointer.pointee
}


       var stackK: Int = 2
    var urlr: String! = String(cString: [104,111,108,101,0], encoding: .utf8)!
   while (2 < (stackK * 1)) {
      stackK += stackK & urlr.count
      break
   }

   if urlr.count <= stackK {
      stackK &= 3
   }
        let rechargeView = UIControl()
        rechargeView.backgroundColor = .white
        rechargeView.addAction(UIAction { [weak overlayView] _ in
            UIView.animate(withDuration: 0.18) {
                overlayView?.alpha = 0
            } completion: { _ in
                overlayView?.removeFromSuperview()
                action?()
            }
        }, for: .touchUpInside)
        rechargeView.translatesAutoresizingMaskIntoConstraints = false

        let baseView = UIImageView(image: UIImage(named: iconName))
        baseView.contentMode = .scaleAspectFit
        baseView.translatesAutoresizingMaskIntoConstraints = false
        rechargeView.addSubview(baseView)

        let znewsLabel = UILabel()
        znewsLabel.text = title
        znewsLabel.font = .systemFont(ofSize: 16, weight: .regular)
        znewsLabel.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.20, alpha: 1)
        znewsLabel.translatesAutoresizingMaskIntoConstraints = false
        rechargeView.addSubview(znewsLabel)

        NSLayoutConstraint.activate([
            rechargeView.heightAnchor.constraint(equalToConstant: 36),

            baseView.leadingAnchor.constraint(equalTo: rechargeView.leadingAnchor, constant: 20),
            baseView.centerYAnchor.constraint(equalTo: rechargeView.centerYAnchor),
            baseView.widthAnchor.constraint(equalToConstant: 16),
            baseView.heightAnchor.constraint(equalToConstant: 16),

            znewsLabel.leadingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: 13),
            znewsLabel.centerYAnchor.constraint(equalTo: rechargeView.centerYAnchor)
        ])

        return rechargeView
    }


    func showEmotionReportMenu(
        from sourceView: UIView,
        onReport: (() -> Void)? = nil,
        onBlock: (() -> Void)? = nil
    ) {
       var connectinga: String! = String(cString: [105,104,116,120,0], encoding: .utf8)!
    _ = connectinga
      connectinga.append("\(connectinga.count)")

        view.endEditing(true)

        let savedView = UIView()
        savedView.backgroundColor = UIColor.black.withAlphaComponent(0.42)
        savedView.alpha = 0
        savedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(savedView)

        let comment = UIControl()
        comment.addAction(UIAction { [weak savedView] _ in
            UIView.animate(withDuration: 0.18) {
                savedView?.alpha = 0
            } completion: { _ in
                savedView?.removeFromSuperview()
            }
        }, for: .touchUpInside)
        comment.translatesAutoresizingMaskIntoConstraints = false
        savedView.addSubview(comment)

        let default_d6View = UIView()
        default_d6View.backgroundColor = .white
        default_d6View.layer.cornerRadius = 10
        default_d6View.layer.masksToBounds = true
        default_d6View.translatesAutoresizingMaskIntoConstraints = false
        savedView.addSubview(default_d6View)

        let z_playerView = UIStackView(arrangedSubviews: [
            makeEmotionReportMenuRow(
                iconName: "EmotionSync/ReportMenu/report_menu_report_icon",
                title: "Report",
                overlayView: savedView,
                action: onReport
            ),
            makeEmotionReportMenuRow(
                iconName: "EmotionSync/ReportMenu/report_menu_block_icon",
                title: "Block",
                overlayView: savedView,
                action: onBlock
            )
        ])
        z_playerView.axis = .vertical
        z_playerView.spacing = 0
        z_playerView.translatesAutoresizingMaskIntoConstraints = false
        default_d6View.addSubview(z_playerView)

        let library = sourceView.convert(sourceView.bounds, to: view)
        let anxious: CGFloat = 132
        let screen = max(15, view.bounds.width - library.maxX)
        let options = min(library.maxY + 12, view.bounds.height - 150)

        NSLayoutConstraint.activate([
            savedView.topAnchor.constraint(equalTo: view.topAnchor),
            savedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            comment.topAnchor.constraint(equalTo: savedView.topAnchor),
            comment.leadingAnchor.constraint(equalTo: savedView.leadingAnchor),
            comment.trailingAnchor.constraint(equalTo: savedView.trailingAnchor),
            comment.bottomAnchor.constraint(equalTo: savedView.bottomAnchor),

            default_d6View.topAnchor.constraint(equalTo: savedView.topAnchor, constant: options),
            default_d6View.trailingAnchor.constraint(equalTo: savedView.trailingAnchor, constant: -screen),
            default_d6View.widthAnchor.constraint(equalToConstant: anxious),

            z_playerView.topAnchor.constraint(equalTo: default_d6View.topAnchor, constant: 9),
            z_playerView.leadingAnchor.constraint(equalTo: default_d6View.leadingAnchor),
            z_playerView.trailingAnchor.constraint(equalTo: default_d6View.trailingAnchor),
            z_playerView.bottomAnchor.constraint(equalTo: default_d6View.bottomAnchor, constant: -9)
        ])

        UIView.animate(withDuration: 0.18) {
            savedView.alpha = 1
        }
    }

}
