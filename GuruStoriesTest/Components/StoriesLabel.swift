//
//  StoriesLabel.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 24/01/21.
//

import UIKit

class StoriesLabel: UIView, UIGestureRecognizerDelegate {
    let height: CGFloat = 72.5

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 3
        label.textColor = .white

        return label
    }()

    required init() {
        super.init(frame: CGRect())
        addTitleLabel()
        addGradient(layer: layer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension StoriesLabel {
    func addGradient(layer: CALayer) {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: height)

        gradient.colors = [UIColor.black.withAlphaComponent(0.0).cgColor,
                           UIColor.black.withAlphaComponent(0.4).cgColor,
                           UIColor.black.cgColor]

        layer.insertSublayer(gradient, at: 0)
    }
}

extension StoriesLabel {
    func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
