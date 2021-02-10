//
//  APIService.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 09/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//
import RxSwift
import Moya

protocol APIServiceProtocol {
    
    func allCategories() -> Single<Response>
    func randomBy(category: String) -> Single<Response>
}

class APIService: APIServiceProtocol {
    
    private let provider = MoyaProvider<APITarget>()
    
    func allCategories() -> Single<Response> {
        return provider.rx.request(.categories)
    }
    
    func randomBy(category: String) -> Single<Response> {
        return provider.rx.request(.randomBy(category: category))

    }
}


