//
//  StoriesProgressBar.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 22/01/21.
//

import UIKit

class StoriesProgressView: UIStackView {

    var numberOfProgressBars: Int
    var height: CGFloat = 2
    var progressTintColor: UIColor = .systemGreen
    let trackTintColor: UIColor = .gray

    init(numberOfProgressBars: Int, frame: CGRect) {
        self.numberOfProgressBars = numberOfProgressBars
        super.init(frame: frame)
        axis = .horizontal
        distribution = .fillEqually
        spacing = 8

        setupProgressViewsInsideStackView(self, numberOfProgressViews: numberOfProgressBars)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension StoriesProgressView {
    func progressViewFactory() -> UIProgressView {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progressTintColor = progressTintColor
        progressView.trackTintColor = trackTintColor
        progressView.layer.cornerRadius = height/2
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

extension StoriesProgressView {
    func startProgressing(currentItemIndex: Int, duration: Double, completionHandler: @escaping (Bool) -> Void) {
        stopProgressing()
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
    
    func pauseLayer() {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }

    func resumeLayer() {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
}
