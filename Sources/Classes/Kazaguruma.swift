//
//  Kazaguruma.swift
//  Kazaguruma
//
//  Created by nakajijapan on 2016/01/01.
//
//

import UIKit

open class Kazaguruma: UIView {

    var activityIndicatorView: UIActivityIndicatorView
    var messageLabel: UILabel

    override init(frame: CGRect) {

        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        messageLabel = UILabel()

        super.init(frame: frame)

        backgroundColor = .white
        addSubview(activityIndicatorView)

        messageLabel.isHidden = true
        messageLabel.font = UIFont.systemFont(ofSize: 14.0)
        addSubview(messageLabel)

        // AutoLayout
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        let views = [
            "self": self,
            "activityIndicatorView": activityIndicatorView,
            "messageLabel": messageLabel,
            ] as [String : Any]

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[self]-(<=0)-[activityIndicatorView]", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[self]-(<=0)-[activityIndicatorView]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[self]-(<=0)-[messageLabel]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[activityIndicatorView]-(16)-[messageLabel]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views))

    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open class func show(_ toView: UIView) -> Kazaguruma {
        return Kazaguruma.show(toView, backgroundColor: .white, indicatorViewStyle: .gray, message: nil, afterdelay: 0.0)
    }

    open class func show(_ toView: UIView, backgroundColor: UIColor, indicatorViewStyle: UIActivityIndicatorViewStyle) -> Kazaguruma {
        return Kazaguruma.show(toView, backgroundColor: backgroundColor, indicatorViewStyle: indicatorViewStyle, message: nil, afterdelay: 0.0, enableAutolayout: true)
    }

    open class func show(_ toView: UIView, backgroundColor: UIColor, indicatorViewStyle: UIActivityIndicatorViewStyle, message:String?, afterdelay:TimeInterval) -> Kazaguruma {
        return Kazaguruma.show(toView, backgroundColor: backgroundColor, indicatorViewStyle: indicatorViewStyle, message: nil, afterdelay: 0.0, enableAutolayout: true)
    }

    open class func show(_ toView: UIView, backgroundColor: UIColor, indicatorViewStyle: UIActivityIndicatorViewStyle, message:String?, afterdelay:TimeInterval, enableAutolayout:Bool) -> Kazaguruma {
        let indicatorView = Kazaguruma(frame: toView.bounds)

        indicatorView.backgroundColor = backgroundColor
        indicatorView.activityIndicatorView.activityIndicatorViewStyle = indicatorViewStyle
        indicatorView.startAnimating()
        toView.addSubview(indicatorView)

        if (enableAutolayout) {

            // AoutoLayout
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            let views = ["indicatorView": indicatorView]
            toView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[indicatorView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
            toView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[indicatorView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

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
