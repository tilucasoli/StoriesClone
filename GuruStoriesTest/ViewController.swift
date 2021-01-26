//
//  ViewController.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 21/01/21.
//

import UIKit

class ViewController: UIViewController {
    var newsList = [News]()

    lazy var stories = StoriesComponent(newsCollection: newsList, frame: CGRect())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        guard let request = loadJson() else {
            return
        }

        newsList = request.items

        stories.delegate = self
        addStoriesImageView()
        // Do any additional setup after loading the view.
    }

    func addStoriesImageView() {
        view.addSubview(stories)
        stories.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stories.heightAnchor.constraint(equalToConstant: 350),
            stories.topAnchor.constraint(equalTo: view.topAnchor),
            stories.rightAnchor.constraint(equalTo: view.rightAnchor),
            stories.leftAnchor.constraint(equalTo: view.leftAnchor)

        ])
    }
}
extension ViewController: StoriesComponentDelegate {
    func loadJson() -> NewsRequest? {
        let decoder = JSONDecoder()
        guard
            let url = Bundle.main.url(forResource: "message", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let items = try? decoder.decode(NewsRequest.self, from: data)
              else {
            return nil
        }
        return items
    }

}
