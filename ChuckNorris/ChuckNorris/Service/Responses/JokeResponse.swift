//
//  JokeResponse.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 09/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import Foundation

struct JokeResponse: Decodable {
    let iconURL: String
    let value: String
}

extension JokeResponse {
    
    enum CodingKeys: String, CodingKey {
        case iconURL = "icon_url"
        case value
    }
}
