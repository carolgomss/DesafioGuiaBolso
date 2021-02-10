//
//  DetalsViewModel.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 08/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import Foundation
import RxSwift

protocol DetalsViewModelProtocol {
    func randomBy(category: String)
}

class DetalsViewModel: DetalsViewModelProtocol {
    
    private var apiService: APIServiceProtocol?
    private let disposeBag = DisposeBag()
    
    let jokeDetail: PublishSubject<String> = PublishSubject()
    let jokeURLImage: PublishSubject<String> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func randomBy(category: String) {
       isLoading.onNext(true)
        apiService?.randomBy(category: category).subscribe(onSuccess: { [weak self] (response) in
            self?.isLoading.onNext(false)
            do {
                let joke = try response.map(JokeResponse.self)
                self?.jokeDetail.onNext(joke.value)
                self?.jokeURLImage.onNext(joke.iconURL)
            } catch let error {
                print(error)
                self?.error.onNext("Não foi possível buscar a piada dessa categoria.")
            }
        }, onError: { [weak self]  (error) in
            self?.isLoading.onNext(false)
            self?.error.onNext("Não foi possível buscar a piada.")
        }).disposed(by: disposeBag)
    }
}
