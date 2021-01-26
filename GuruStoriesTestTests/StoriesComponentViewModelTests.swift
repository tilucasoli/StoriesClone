//
//  StoriesComponentViewModelTests.swift
//  GuruStoriesTestTests
//
//  Created by Lucas Oliveira on 26/01/21.
//

import XCTest
@testable import GuruStoriesTest

class StoriesComponentViewModelTests: XCTestCase {

    let newsArray = [News(title: "TitleTest", origin: .guru, link: "google.com",
                         externalLink: nil, isPriority: true, image: "1",
                         published: "1"),
                    News(title: "TitleTest2", origin: .suno, link: "google.com",
                         externalLink: nil, isPriority: true, image: "2",
                         published: "1")]

    func test_SCViewModel_titleCurrentItem() {

        let sut = StoriesComponentViewModel(newsCollection: newsArray)

        let output = sut.titleCurrentItem

        XCTAssertEqual(output, "TitleTest")
    }

    func test_SCViewModel_nextItem_if() {

        let sut = StoriesComponentViewModel(newsCollection: newsArray)

        sut.currentItem = 1
        sut.nextItem()

        let output = sut.currentItem

        XCTAssertEqual(output, 0)
    }

    func test_SCViewModel_nextItem_else() {

        let sut = StoriesComponentViewModel(newsCollection: newsArray)

        sut.nextItem()
        let output = sut.currentItem

        XCTAssertEqual(output, 1)
    }

    func test_SCViewModel_previousItem_if() {

        let sut = StoriesComponentViewModel(newsCollection: newsArray)
        sut.previousItem()

        let output = sut.currentItem
        XCTAssertEqual(output, 1)
    }

    func test_SCViewModel_previousItem_else() {

        let sut = StoriesComponentViewModel(newsCollection: newsArray)
        sut.currentItem = 1
        sut.previousItem()

        let output = sut.currentItem

        XCTAssertEqual(output, 0)
    }

}
