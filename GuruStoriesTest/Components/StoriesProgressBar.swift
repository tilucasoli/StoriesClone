//
//  StoriesProgressBar.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 22/01/21.
//

import UIKit

class StoriesProgressBar: UIStackView {
    let numberOfProgressBars: Int

    init(numberOfProgressBars: Int, frame: CGRect) {
        self.numberOfProgressBars = numberOfProgressBars
        super.init(frame: frame)
        // draw doesnt work auto
        draw(frame)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        axis = .horizontal
        distribution = .fillEqually
        spacing = 8

        setupProgressViewsInsideStackView(self, numberOfProgressViews: numberOfProgressBars)
    }
}

extension StoriesProgressBar {
    func progressViewFactory() -> UIProgressView {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progressTintColor = .systemGreen
        progressView.trackTintColor = .gray
        progressView.layer.cornerRadius = 2
        progressView.clipsToBounds = true
        return progressView
    }

    func setupProgressViewsInsideStackView(_ stackView: UIStackView, numberOfProgressViews: Int) {

        for _ in 0..<numberOfProgressViews {
            let progressView = progressViewFactory()

            stackView.addArrangedSubview(progressView)
        }

    }
}

extension StoriesProgressBar {
    func startProgressing(currentItemIndex: Int, duration: Double, completionHandler: @escaping (Bool) -> Void) {
        guard let progressViewArray = arrangedSubviews as? [UIProgressView] else {
            return
        }

        for index in 0..<currentItemIndex {
            let progressView = progressViewArray[index]

            progressView.progress = 1
            progressView.layoutIfNeeded()
        }

        for index in currentItemIndex..<numberOfProgressBars {
            let progressView = progressViewArray[index]

            progressView.progress = 0
            progressView.layoutIfNeeded()
        }

        let currentProgressView = progressViewArray[currentItemIndex]
        currentProgressView.progress = 0
        currentProgressView.layoutIfNeeded()

        currentProgressView.progress = 1
        UIView.animate(withDuration: duration, animations: {
            currentProgressView.layoutIfNeeded()

        }) { finished in
            completionHandler(!finished)
        }
    }

    func stopProgressing() {
        let progressViewArray = arrangedSubviews
        progressViewArray.forEach({ view in
            view.layer.sublayers?.forEach { $0.removeAllAnimations()}
        })
    }
}
