//
//  StoriesComponentController.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 21/01/21.
//

import UIKit

class StoriesComponentViewModel {
    let imageCollection: [UIImage]
    var currentItem = 0

    var currentImage: UIImage {
        return imageCollection[currentItem]
    }

    init(imageCollection: [UIImage]) {
        self.imageCollection = imageCollection
    }

    func nextItem() {
        if currentItem == imageCollection.count - 1 {
            currentItem = 0
        } else {
            currentItem += 1
        }
    }

    func previousItem() {
        if currentItem == 0 {
            currentItem = imageCollection.count - 1
        } else {
            currentItem -= 1
        }
    }

}
//func nextItem(currentIndex: Int, array: [Any]) -> Int {
//    if currentIndex == array.count - 1 {
//        currentItem = 0
//        return currentItem
//    } else {
//        currentItem += 1
//        return currentItem
//    }
//}
