//
//  KazagurumaTests.swift
//  KazagurumaTests
//
//  Created by nakajijapan on 2015/12/30.
//  Copyright (c) 2015 nakajijapan. All rights reserved.
//

import XCTest
@testable import Kazaguruma

class KazagurumaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExistsIndicatorView() {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        Kazaguruma.show(view)
        
        XCTAssert(view.subviews.count > 0)
        
        let indicatorView = view.subviews[0] as! Kazaguruma
        
        XCTAssert(indicatorView.messageLabel.hidden)
        XCTAssert(!indicatorView.activityIndicatorView.hidden)

    }

    func testDesignIsReflected() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        Kazaguruma.show(view, backgroundColor: UIColor.redColor(), indicatorViewStyle: .White)
        
        XCTAssert(view.subviews.count > 0)
        
        let indicatorView = view.subviews[0] as! Kazaguruma
        
        XCTAssert(indicatorView.messageLabel.hidden)
        XCTAssert(!indicatorView.activityIndicatorView.hidden)
        XCTAssert(indicatorView.backgroundColor == UIColor.redColor())
        XCTAssert(indicatorView.activityIndicatorView.activityIndicatorViewStyle == .White)
        
    }
    
    func testMessageIsReflected() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        Kazaguruma.show(view, backgroundColor: UIColor.redColor(), indicatorViewStyle: .White, message:"waiting", afterdelay: 0.0)
        
        XCTAssert(view.subviews.count > 0)
        
        let indicatorView = view.subviews[0] as! Kazaguruma
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {

            XCTAssert(indicatorView.messageLabel.text == "waiting ....", "町があががが")
            XCTAssert(!indicatorView.messageLabel.hidden)
            XCTAssert(indicatorView.messageLabel.alpha == 1.0)
            XCTAssert(!indicatorView.activityIndicatorView.hidden)
            XCTAssert(indicatorView.backgroundColor == UIColor.redColor())
            XCTAssert(indicatorView.activityIndicatorView.activityIndicatorViewStyle == .White)

        })

        
    }

    func testCanCloseIndicatorView() {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        Kazaguruma.show(view)
        
        XCTAssert(view.subviews.count > 0)
        
        Kazaguruma.hide(view)
        XCTAssert(view.subviews.count == 0)

    }
    
    func testExecuteBlock() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        Kazaguruma.show(view)
        
        XCTAssert(view.subviews.count > 0)
        
        Kazaguruma.hide(view, animated: true) { () -> Void in

            XCTAssert(view.subviews.count == 0)

        }

        
    }

    
}
