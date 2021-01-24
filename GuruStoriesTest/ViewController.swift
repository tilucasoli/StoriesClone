//
//  ViewController.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 21/01/21.
//

import UIKit

class ViewController: UIViewController {

//    let imageArray = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!,
//                      UIImage(named: "4")!, UIImage(named: "5")!, UIImage(named: "6")!]

    let newsList = [News(title: "O que o caso Jack Ma revela sobre a rígida regulação chinesa?", photo: UIImage(named: "1")!),
                    News(title: "1", photo: UIImage(named: "2")!),
                    News(title: "1", photo: UIImage(named: "3")!),
                    News(title: "1", photo: UIImage(named: "4")!),
                    News(title: "1", photo: UIImage(named: "5")!)]

    lazy var stories = StoriesComponent(newsCollection: newsList, frame: CGRect())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        stories.delegate = self

        view.addSubview(stories)
        stories.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stories.heightAnchor.constraint(equalToConstant: 300),
            stories.topAnchor.constraint(equalTo: view.topAnchor),
            stories.rightAnchor.constraint(equalTo: view.rightAnchor),
            stories.leftAnchor.constraint(equalTo: view.leftAnchor)

        ])
        // Do any additional setup after loading the view.
    }

}
extension ViewController: StoriesComponentDelegate {

}
