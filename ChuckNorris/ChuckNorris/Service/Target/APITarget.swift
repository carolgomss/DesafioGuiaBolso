//
//  APITarget.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 09/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import Moya

enum APITarget {
    case categories
    case randomBy(category: String)
}

extension APITarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.chucknorris.io/") else {
            fatalError("Formato de URL inválido")
        }
        return url
    }
    
    var path: String{
        switch self {
        case .categories:
            return "jokes/categories"
        case .randomBy:
            return "jokes/random"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .categories:
            return .requestPlain
        case .randomBy(let category):
            return .requestParameters(parameters: ["category": category],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
