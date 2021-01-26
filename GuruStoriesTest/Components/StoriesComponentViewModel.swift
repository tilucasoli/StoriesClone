//
//  StoriesComponentController.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 21/01/21.
//

import Foundation

protocol StoriesComponentViewModelDelegate: class {
    func setNews(index: Int)
    func addImage(index: Int, data: Data)
}

class StoriesComponentViewModel {
    var newsList: [News]
    weak var delegate: StoriesComponentViewModelDelegate?

    var currentItem = 0
    var titleCurrentItem: String {
        return newsList[currentItem].title
    }

    init(newsCollection: [News]) {

        let nonPriority = newsCollection.filter({!$0.isPriority})
        let priority = newsCollection.filter({$0.isPriority})
        self.newsList = priority + nonPriority

        fetchImages()
    }

    func nextItem() {
        if currentItem == newsList.count - 1 {
            currentItem = 0
        } else {
            currentItem += 1
        }
        delegate?.setNews(index: currentItem)
    }

    func previousItem() {
        if currentItem == 0 {
            currentItem = newsList.count - 1
        } else {
            currentItem -= 1
        }
        delegate?.setNews(index: currentItem)
    }

    func fetchImages() {
        DispatchQueue.main.async {
            for index in 0..<self.newsList.count {
                self.downloadImages(news: self.newsList[index], index: index)
            }
        }
    }

    func downloadImages(news: News, index: Int) {
        let url = URL(string: news.image)!
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self?.delegate?.addImage(index: index, data: data)
                }
            }
        }.resume()
    }

}
