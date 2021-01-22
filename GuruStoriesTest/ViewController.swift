//
//  ViewController.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 21/01/21.
//

import UIKit

class ViewController: UIViewController {
    let imageArray = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!]
    lazy var stories = StoriesComponent(imageCollection: imageArray, frame: CGRect())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

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
