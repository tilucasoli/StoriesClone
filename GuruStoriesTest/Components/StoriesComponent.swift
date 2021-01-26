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

    var imageCollection: [StoriesImage] = [] {
        didSet {
            if imageCollection.count == viewModel.newsList.count {
                imageCollection.sort(by: {$0.index<$1.index})
                startStoriesComponent()
            }
        }
    }

    var transitionDuration: Double = 5

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageViewAction(sender:)))
        let longTapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longtapAction(sender:)))
        longTapRecognizer.minimumPressDuration = 0.2

        imageView.addGestureRecognizer(tapRecognizer)
        imageView.addGestureRecognizer(longTapRecognizer)

        return imageView
    }()

    lazy var activityIndicator = UIActivityIndicatorView.init(style: .large)

    lazy var progressViews = StoriesProgressView(numberOfProgressBars: viewModel.newsList.count, frame: CGRect())

    lazy var titleView: StoriesTitleView = {
        let storiesTitleView = StoriesTitleView()
        storiesTitleView.isUserInteractionEnabled = true

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTitleViewAction(sender:)))
        storiesTitleView.addGestureRecognizer(tapRecognizer)

        return storiesTitleView
    }()

    init(newsCollection: [News], frame: CGRect) {
        self.viewModel = StoriesComponentViewModel(newsCollection: newsCollection)

        super.init(frame: frame)

        viewModel.delegate = self

        activityIndicator.startAnimating()
        titleView.isHidden = true
        progressViews.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addImageView()
        addActivityIndicator()
        addStoriesProgressView()
        addTitleView()
    }

    @objc func tapImageViewAction(sender: UITapGestureRecognizer) {
        let widthImageView = imageView.frame.width/2

        if sender.location(in: imageView).x > widthImageView {
            viewModel.nextItem()
            progressViews.stopProgressing()
        } else {
            viewModel.previousItem()
            progressViews.stopProgressing()
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    @objc func tapTitleViewAction(sender: UITapGestureRecognizer) {
        delegate?.presentSafari(string: viewModel.newsList[viewModel.currentItem].link)
    }

    @objc func longtapAction(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            progressViews.pauseLayer()
        } else if sender.state == .ended {
            progressViews.resumeLayer()
        }
        
        if !(sender.state == .changed) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }

    }

}

// MARK: ViewLogic
extension StoriesComponent {
    func startAnimation() {
        progressViews.startProgressing(currentItemIndex: viewModel.currentItem,
                                       duration: transitionDuration) { wasForcedInterruption in
            if wasForcedInterruption {
                self.startAnimation()
                self.progressViews.layoutIfNeeded()
            } else {
                self.viewModel.nextItem()
                self.startAnimation()
            }
        }
    }

    func startStoriesComponent() {
        activityIndicator.stopAnimating()

        setNews(index: 0)

        titleView.isHidden = false
        progressViews.isHidden = false

        startAnimation()
    }
}

// MARK: StoriesProgressViewDelegate
extension StoriesComponent: StoriesComponentViewModelDelegate {
    func addImage(index: Int, data: Data) {
        let image = UIImage(data: data)!
        let newStoriesImage = StoriesImage(index: index, image: image)
        imageCollection.append(newStoriesImage)
    }

    func setNews(index: Int) {

        UIView.transition(with: imageView,
                          duration: 0.3,
                          options: [.curveEaseInOut, .transitionCrossDissolve],
                          animations: {
                            self.imageView.image = self.imageCollection[index].image
                          })

        UIView.animate(withDuration: 1, animations: {
            self.titleView.titleLabel.alpha = 0
            self.titleView.titleLabel.alpha = 1
            self.titleView.titleLabel.text = self.viewModel.newsList[index].title
        })

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

    func addActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func addStoriesProgressView() {
        addSubview(progressViews)
        progressViews.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progressViews.topAnchor.constraint(equalTo: (delegate?.view.safeAreaLayoutGuide.topAnchor)!),
            progressViews.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            progressViews.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            progressViews.heightAnchor.constraint(equalToConstant: progressViews.height)
        ])
    }

    func addTitleView() {
        addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleView.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
