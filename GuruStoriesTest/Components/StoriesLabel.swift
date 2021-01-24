//
//  StoriesLabel.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 24/01/21.
//

import UIKit

class StoriesLabel: UIView, UIGestureRecognizerDelegate {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 2
        label.textColor = .white

        return label
    }()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addTitleLabel()
        addGradient()
        titleLabel.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
    }

    func addGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.black.withAlphaComponent(0.0).cgColor,
                           UIColor.black.withAlphaComponent(0.4).cgColor,
                           UIColor.black.cgColor]
        gradient.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 56)

        layer.insertSublayer(gradient, at: 0)
    }

    
}

extension StoriesLabel {
    func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
    }
}
