//
//  StoriesComponent.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 21/01/21.
//

import UIKit

class StoriesComponent: UIView {

    let viewModel: StoriesComponentViewModel

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = viewModel.currentImage
        imageView.isUserInteractionEnabled = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        imageView.addGestureRecognizer(tapRecognizer)

        return imageView
    }()

    lazy var storiesProgressView = StoriesProgressBar(numberOfProgressBars: viewModel.count, frame: CGRect())

    init(imageCollection: [UIImage], frame: CGRect) {
        self.viewModel = StoriesComponentViewModel(imageCollection: imageCollection)
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addImageView()
        addProgressView()
        imageViewAutomaticProgress()

    }

    func imageViewAutomaticProgress() {
        storiesProgressView.startProgressing(currentItemIndex: viewModel.currentItem, duration: 5) { wasForcedInterruption in
            if wasForcedInterruption {
                self.imageViewAutomaticProgress()
            } else {
                self.viewModel.nextItem()
                self.imageView.image = self.viewModel.currentImage
                self.imageViewAutomaticProgress()
            }
        }

    }

    @objc func tapAction(sender: UITapGestureRecognizer) {
        let widthImageView = imageView.frame.width/2

        if sender.location(in: imageView).x > widthImageView {
            viewModel.nextItem()
            imageView.image = viewModel.currentImage
            storiesProgressView.stopProgressing()
        } else {
            viewModel.previousItem()
            imageView.image = viewModel.currentImage
            storiesProgressView.stopProgressing()
        }
    }

}

// MARK: Constraints
extension StoriesComponent: UIGestureRecognizerDelegate {
    func addImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }

    func addProgressView() {
        addSubview(storiesProgressView)
        storiesProgressView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            storiesProgressView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8),
            storiesProgressView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            storiesProgressView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            storiesProgressView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
