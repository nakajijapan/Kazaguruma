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
        _ = Kazaguruma.show(view)

        XCTAssert(view.subviews.count > 0)

        let indicatorView = view.subviews[0] as! Kazaguruma

        XCTAssert(indicatorView.messageLabel.isHidden)
        XCTAssert(!indicatorView.activityIndicatorView.isHidden)

    }

    func testDesignIsReflected() {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        _ = Kazaguruma.show(view, backgroundColor: .red, indicatorViewStyle: .white)

        XCTAssert(view.subviews.count > 0)

        let indicatorView = view.subviews[0] as! Kazaguruma

        XCTAssert(indicatorView.messageLabel.isHidden)
        XCTAssert(!indicatorView.activityIndicatorView.isHidden)
        XCTAssert(indicatorView.backgroundColor == .red)
        XCTAssert(indicatorView.activityIndicatorView.activityIndicatorViewStyle == .white)

    }

    func testMessageIsReflected() {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        _ = Kazaguruma.show(view, backgroundColor: .red, indicatorViewStyle: .white, message: "waiting", afterdelay: 0.0)

        XCTAssert(view.subviews.count > 0)

        let indicatorView = view.subviews[0] as! Kazaguruma

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {

            XCTAssert(indicatorView.messageLabel.text == "waiting ....", "町があががが")
            XCTAssert(!indicatorView.messageLabel.isHidden)
            XCTAssert(indicatorView.messageLabel.alpha == 1.0)
            XCTAssert(!indicatorView.activityIndicatorView.isHidden)
            XCTAssert(indicatorView.backgroundColor == .red)
            XCTAssert(indicatorView.activityIndicatorView.activityIndicatorViewStyle == .white)

        })

    }

    func testCanCloseIndicatorView() {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        _ = Kazaguruma.show(view)

        XCTAssert(view.subviews.count > 0)

        Kazaguruma.hide(view)
        XCTAssert(view.subviews.count == 0)

    }

    func testExecuteBlock() {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        _ = Kazaguruma.show(view)

        XCTAssert(view.subviews.count > 0)

        Kazaguruma.hide(view, animated: true) {

            XCTAssert(view.subviews.count == 0)

        }

    }

}
