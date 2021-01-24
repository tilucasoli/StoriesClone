//
//  StoriesComponentController.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 21/01/21.
//

import Foundation

protocol StoriesComponentViewModelDelegate: class {
    func setPhotoInImageView(in index: Int)
}

class StoriesComponentViewModel {
    let newsList: [News]
    weak var delegate: StoriesComponentViewModelDelegate?

    var currentItem = 0
    var titleCurrentItem: String {
        return newsList[currentItem].title
    }

    init(newsCollection: [News]) {
        self.newsList = newsCollection
    }

    func nextItem() {
        if currentItem == newsList.count - 1 {
            currentItem = 0
        } else {
            currentItem += 1
        }
        delegate?.setPhotoInImageView(in: currentItem)
    }

    func previousItem() {
        if currentItem == 0 {
            currentItem = newsList.count - 1
        } else {
            currentItem -= 1
        }
        delegate?.setPhotoInImageView(in: currentItem)
    }

}
