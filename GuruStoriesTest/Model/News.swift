//
//  Item.swift
//  GuruStoriesTest
//
//  Created by Lucas Oliveira on 24/01/21.
//

import UIKit

import Foundation

// MARK: - News
struct NewsRequest: Codable {
    let items: [News]
}

// MARK: - Item
struct News: Codable {
    let title: String
    let origin: Origin
    let link: String
    let externalLink: String?
    let isPriority: Bool
    let image: String
    let published: String

    enum CodingKeys: String, CodingKey {
        case title, origin, link
        case externalLink = "external-link"
        case isPriority = "is_priority"
        case image, published
    }
}

enum Origin: String, Codable {
    case guru = "Guru"
    case infoMoney = "InfoMoney"
    case suno = "Suno"
}
