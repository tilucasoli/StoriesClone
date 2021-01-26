//
//  CustomProgressBar.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 22/01/21.
// https://stackoverflow.com/questions/40588879/reset-uiprogressview-and-begin-animating-immediately-with-swift-3

import UIKit
extension UIProgressView {

    func startProgressing(duration: TimeInterval, resetProgress: Bool, completion: @escaping (Bool) -> Void) {
        stopProgressing()

        // Reset to 0
        progress = 0.0
        layoutIfNeeded()

        // Set the 'destination' progress
        progress = 1.0

        // Animate the progress
        UIView.animate(withDuration: duration, animations: {
            self.layoutIfNeeded()

        }) { finished in
            // Remove this guard-block, if you want the completion to be called all the time - even when the progression was interrupted
//            guard finished else { return }
            print(finished)

            if resetProgress { self.progress = 0.0 }
            //was forced interruption?
            completion(!finished)
        }
    }

    func stopProgressing() {
        // Because the 'track' layer has animations on it, we'll try to remove them
        layer.sublayers?.forEach { $0.removeAllAnimations()}
    }
}
