//
//  StoriesComponentDelegate.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 24/01/21.
//

import UIKit
import SafariServices

protocol StoriesComponentDelegate: UIViewController, SFSafariViewControllerDelegate {
    func presentSafari(string: String)
}
extension StoriesComponentDelegate {
    func presentSafari(string: String) {

        guard let url = URL(string: string) else {
            return
        }

        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        safariVC.configuration.entersReaderIfAvailable = true
        safariVC.delegate = self
        present(safariVC, animated: true)
    }

}
