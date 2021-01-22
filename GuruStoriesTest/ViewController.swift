//
//  ViewController.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 21/01/21.
//

import UIKit

class ViewController: UIViewController {

    let stories = StoriesComponent(imageCollection: [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!], frame: CGRect())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        view.addSubview(stories)
        stories.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stories.heightAnchor.constraint(equalToConstant: 300),
            stories.topAnchor.constraint(equalTo: view.topAnchor),
            stories.rightAnchor.constraint(equalTo: view.rightAnchor),
            stories.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
        // Do any additional setup after loading the view.
    }

}
