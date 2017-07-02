//
//  Kazaguruma.swift
//  Kazaguruma
//
//  Created by nakajijapan on 2016/01/01.
//
//

import UIKit

open class Kazaguruma: UIView {

    var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var messageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        addSubview(activityIndicatorView)

        messageLabel.isHidden = true
        messageLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(messageLabel)

        // AutoLayout
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            self.centerXAnchor.constraint(greaterThanOrEqualTo: activityIndicatorView.centerXAnchor),
            self.centerYAnchor.constraint(greaterThanOrEqualTo: activityIndicatorView.centerYAnchor),
            self.centerXAnchor.constraint(greaterThanOrEqualTo: messageLabel.centerXAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8.0)
        ].forEach { $0.isActive = true }
    }

    required public convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect.zero)
    }

    open class func show(_ toView: UIView,
                         backgroundColor: UIColor = .white,
                         indicatorViewStyle: UIActivityIndicatorViewStyle = .gray,
                         message: String? = nil, afterdelay: TimeInterval = 0.0,
                         enableAutolayout: Bool = true) -> Kazaguruma {
        let indicatorView = Kazaguruma(frame: toView.bounds)

        indicatorView.backgroundColor = backgroundColor
        indicatorView.activityIndicatorView.activityIndicatorViewStyle = indicatorViewStyle
        indicatorView.startAnimating()
        toView.addSubview(indicatorView)

        if enableAutolayout {
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            [
                toView.topAnchor.constraint(equalTo: indicatorView.topAnchor),
                toView.bottomAnchor.constraint(equalTo: indicatorView.bottomAnchor),
                toView.leadingAnchor.constraint(equalTo: indicatorView.leadingAnchor),
                toView.trailingAnchor.constraint(equalTo: indicatorView.trailingAnchor)
            ].forEach { $0.isActive = true }

        }

        // Show Message
        if 0.0 < afterdelay && message != nil {
            indicatorView.messageLabel.text = message
            indicatorView.messageLabel.alpha = 0.0
            indicatorView.messageLabel.isHidden = false

            UIView.animate(
                withDuration: 0.8,
                delay: afterdelay,
                options: .curveEaseIn,
                animations: {

                    // optimize messageLabel of position
                    let transform = CGAffineTransform(translationX: 0.0, y: -16.0)
                    indicatorView.activityIndicatorView.transform = transform
                    indicatorView.messageLabel.transform          = transform
                    indicatorView.messageLabel.alpha              = 1.0

                },
                completion: nil
            )
        }

        return indicatorView

    }

    open class func hide(_ forView: UIView) {
        hide(forView, animated: false, completion: nil)
    }

    open class func hide(_ forView: UIView, animated: Bool, completion: (() -> Void)?) {
        if let indicatorView = indicatorView(forView) {
            if animated {
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.0,
                    options: .curveEaseOut,
                    animations: {
                        indicatorView.alpha = 0.0
                    },
                    completion: { (finished) -> Void in
                        indicatorView.removeViewWithCompletion(completion)
                    }
                )
            } else {

                indicatorView.removeViewWithCompletion(completion)
            }
        }
    }

    open class func indicatorView(_ forView: UIView) -> Kazaguruma? {
        for subview in forView.subviews.reversed() {
            if subview.isKind(of: Kazaguruma.self) {
                return subview as? Kazaguruma
            }
        }
        return nil
    }

    // MARK: - Private Method

    func startAnimating() {
        activityIndicatorView.isHidden = false
        if !activityIndicatorView.isAnimating {
            activityIndicatorView.startAnimating()
        }
    }

    func stopAnimating() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }

    func removeViewWithCompletion(_ completion: (() -> Void)?) {
        stopAnimating()
        removeFromSuperview()

        completion?()
    }

}
