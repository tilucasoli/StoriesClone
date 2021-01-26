//
//  StoriesProgressViewTests.swift
//  GuruStoriesTestTests
//
//  Created by Lucas Oliveira on 26/01/21.
//

import XCTest
@testable import GuruStoriesTest

class StoriesProgressViewTests: XCTestCase {

    func test_StoriesProgressView_startProgressing_WithIndex0() {
        let index = 0

        let sut = StoriesProgressView(numberOfProgressBars: 3, frame: CGRect())
        sut.startProgressing(currentItemIndex: index, duration: 0) {_ in

        }

        let progressView = sut.arrangedSubviews[index] as? UIProgressView

        let state = progressView?.progress

        XCTAssertEqual(state, 1)
    }

    func test_StoriesProgressView_startProgressing() {

        let sut = StoriesProgressView(numberOfProgressBars: 3, frame: CGRect())
        sut.startProgressing(currentItemIndex: 2, duration: 0) {_ in

        }

        let progressView = sut.arrangedSubviews[1] as? UIProgressView

        let state = progressView?.progress

        XCTAssertEqual(state, 1)
    }

    func test_StoriesProgressView_pauseLayer() {

        let sut = StoriesProgressView(numberOfProgressBars: 3, frame: CGRect())
        sut.pauseLayer()

        let state = sut.layer.speed

        XCTAssertEqual(state, 0)
    }

    func test_StoriesProgressView_resumeLayer() {

        let sut = StoriesProgressView(numberOfProgressBars: 3, frame: CGRect())
        sut.pauseLayer()
        sut.resumeLayer()

        let state = sut.layer.speed

        XCTAssertEqual(state, 1)
    }
}
