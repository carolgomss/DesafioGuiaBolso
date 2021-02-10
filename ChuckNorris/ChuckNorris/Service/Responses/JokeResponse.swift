//
//  JokeResponse.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 09/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import Foundation

struct JokeResponse: Decodable {
    let categories: [String]
    let createdAt: String
    let iconURL: String
    let id: String
    let updatedAt: String
    let URL: String
    let value: String
}

extension JokeResponse {
    enum codingKeys: String, CodingKey {
        case categories
        case createdAt = "created_at"
        case iconURL = "icon_url"
        case id
        case updatedAt = "updated_at"
        case URL = "url"
        case value
    }
}
