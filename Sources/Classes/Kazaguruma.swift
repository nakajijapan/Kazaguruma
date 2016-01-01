//
//  Kazaguruma.swift
//  Kazaguruma
//
//  Created by nakajijapan on 2016/01/01.
//
//

import UIKit

public class Kazaguruma: UIView {

    var activityIndicatorView: UIActivityIndicatorView
    var messageLabel: UILabel
    
    override init(frame: CGRect) {

        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.messageLabel = UILabel()
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.activityIndicatorView)
        
        self.messageLabel.hidden = true
        self.messageLabel.font = UIFont.systemFontOfSize(14.0)
        self.addSubview(self.messageLabel)
        
        // AutoLayout
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let views = [
            "self": self,
            "activityIndicatorView": self.activityIndicatorView,
            "messageLabel": self.messageLabel,
        ]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[self]-(<=0)-[activityIndicatorView]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[self]-(<=0)-[activityIndicatorView]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[self]-(<=0)-[messageLabel]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[activityIndicatorView]-(16)-[messageLabel]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: views))
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public class func show(toView:UIView) -> Kazaguruma {
        return Kazaguruma.show(toView, backgroundColor: UIColor.whiteColor(), indicatorViewStyle: .Gray, message: nil, afterdelay: 0.0)
    }

    public class func show(toView:UIView, backgroundColor:UIColor, indicatorViewStyle:UIActivityIndicatorViewStyle) -> Kazaguruma {
        return Kazaguruma.show(toView, backgroundColor: backgroundColor, indicatorViewStyle: indicatorViewStyle, message: nil, afterdelay: 0.0)
    }
    
    public class func show(toView:UIView, backgroundColor:UIColor, indicatorViewStyle:UIActivityIndicatorViewStyle, message:String?, afterdelay:NSTimeInterval) -> Kazaguruma {

        let indicatorView = Kazaguruma(frame: toView.bounds)
        
        indicatorView.backgroundColor = backgroundColor
        indicatorView.activityIndicatorView.activityIndicatorViewStyle = indicatorViewStyle
        indicatorView.startAnimating()
        toView.addSubview(indicatorView)
        
        // AoutoLayout
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["indicatorView": indicatorView]
        toView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[indicatorView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        toView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[indicatorView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))

        // Show Message
        if 0.0 < afterdelay && message != nil {
            
            indicatorView.messageLabel.text = message
            indicatorView.messageLabel.alpha = 0.0
            indicatorView.messageLabel.hidden = false

            UIView.animateWithDuration(
                0.8,
                delay: afterdelay,
                options: .CurveEaseIn,
                animations: { () -> Void in
                    
                    // optimize messageLabel of position
                    let transform = CGAffineTransformMakeTranslation(0.0, -16.0)
                    indicatorView.activityIndicatorView.transform = transform
                    indicatorView.messageLabel.transform          = transform
                    indicatorView.messageLabel.alpha              = 1.0
                    
                },
                completion: nil
            )

        }

        return indicatorView

    }

    public class func hide(forView:UIView) {
        self.hide(forView, animated: false, completion: nil)
    }

    public class func hide(forView:UIView, animated:Bool, completion:(() -> Void)?) {

       
        if let indicatorView = self.indicatorView(forView) {
            if animated {
                
                UIView.animateWithDuration(
                    0.3,
                    delay: 0.0,
                    options: .CurveEaseOut,
                    animations: { () -> Void in
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

    public class func indicatorView(forView:UIView) -> Kazaguruma? {

        for subview in forView.subviews.reverse() {

            if subview.isKindOfClass(Kazaguruma.self) {
                return subview as? Kazaguruma
            }
        }
        
        return nil
    }



    // MARK: - Private Method

    func startAnimating() {
        self.activityIndicatorView.hidden = false
        if !self.activityIndicatorView.isAnimating() {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func stopAnimating() {
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.hidden = true
    }
    
    
    func removeViewWithCompletion(completion: (() -> Void)?) {
        self.stopAnimating()
        self.removeFromSuperview()
        
        completion?()
    }
    
    


}
