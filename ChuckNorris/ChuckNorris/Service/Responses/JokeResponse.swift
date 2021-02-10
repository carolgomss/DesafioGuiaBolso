//
//  JokeResponse.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 09/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import Foundation

struct JokeResponse: Decodable {
    let icon_url: String
    let value: String
}

extension JokeResponse {
    enum codingKeys: String, CodingKey {
        case icon_url
        case value
    }
}
