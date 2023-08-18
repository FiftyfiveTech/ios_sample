//
//  PostImageModel.swift
//  iOSAppTemplate
//
//  Created by apple on 10/08/23.
//

import Foundation

// MARK: - PostImage
struct PostImage: Decodable, Identifiable {
    let id, author: String
    let width, height: Int
    let url: URL
    let downloadURL: URL

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

typealias PostImages = [PostImage]
