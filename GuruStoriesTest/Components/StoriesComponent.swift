//
//  StoriesComponent.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 21/01/21.
//

import UIKit

class StoriesComponent: UIView {

    var viewModel: StoriesComponentViewModel
    weak var delegate: StoriesComponentDelegate?
    var imageCollection: [UIImage]?
    var transitionDuration: Double = 5

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = viewModel.newsList[0].photo
        imageView.isUserInteractionEnabled = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        let longTapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longtapAction(sender:)))
        longTapRecognizer.minimumPressDuration = 0.5
        
        imageView.addGestureRecognizer(tapRecognizer)
        imageView.addGestureRecognizer(longTapRecognizer)

        return imageView
    }()

    lazy var progressViews: StoriesProgressView = {
        let progressView = StoriesProgressView(numberOfProgressBars: viewModel.newsList.count, frame: CGRect())
        progressView.numberOfProgressBars = viewModel.newsList.count
        progressView.progressTintColor = .yellow
        return progressView
    }()

    lazy var newsTitleLabel: StoriesLabel = {
        let storiesLabel = StoriesLabel()
        storiesLabel.titleLabel.text = viewModel.titleCurrentItem
        return storiesLabel
    }()

    init(newsCollection: [News], frame: CGRect) {
        self.viewModel = StoriesComponentViewModel(newsCollection: newsCollection)
        super.init(frame: frame)
        viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addImageView()
        addStoriesProgressView()
        addNewsTitleLabel()
        startAnimation()
        
    }

    @objc func tapAction(sender: UITapGestureRecognizer) {
        let widthImageView = imageView.frame.width/2

        if sender.location(in: imageView).x > widthImageView {
            viewModel.nextItem()
            progressViews.stopProgressing()
        } else {
            viewModel.previousItem()
            progressViews.stopProgressing()
        }
    }

    @objc func longtapAction(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            progressViews.pauseLayer()
        } else if sender.state == .ended {
            progressViews.resumeLayer()
        }
    }

    func startAnimation() {
        progressViews.startProgressing(currentItemIndex: viewModel.currentItem,
                                       duration: transitionDuration) { wasForcedInterruption in
            if wasForcedInterruption {
                self.startAnimation()
            } else {
                self.viewModel.nextItem()
                self.startAnimation()
            }
        }
    }

}

// MARK: StoriesProgressViewDelegate
extension StoriesComponent: StoriesComponentViewModelDelegate {

    func setPhotoInImageView(in index: Int) {
        imageView.image = viewModel.newsList[index].photo
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

    func addStoriesProgressView() {
        progressViews.draw(CGRect())
        
        addSubview(progressViews)
        progressViews.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progressViews.topAnchor.constraint(equalTo: (delegate?.view.safeAreaLayoutGuide.topAnchor)!),
            progressViews.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            progressViews.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            progressViews.heightAnchor.constraint(equalToConstant: progressViews.height)
        ])
    }

    func addNewsTitleLabel() {
        newsTitleLabel.draw(CGRect())

        addSubview(newsTitleLabel)
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            newsTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            newsTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            newsTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
