//
//  HomeViewModel.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 08/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import UIKit
import RxSwift

protocol HomeViewModelProtocol {
    func loadCategories()
    
}

class HomeViewModel: HomeViewModelProtocol {
   
    private var apiService: APIServiceProtocol?
    private var disposeBag = DisposeBag()
    
    let categories: PublishSubject<[String]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let isLoading: PublishSubject<Bool> = PublishSubject()
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func loadCategories() {
        isLoading.onNext(true)
        apiService?.allCategories().subscribe(onSuccess: { [weak self] (response) in
            self?.isLoading.onNext(false)
            do {
                let categoriesResponse = try response.map([String].self)
                if !categoriesResponse.isEmpty {
                    self?.categories.onNext(categoriesResponse)
                } else {
                    self?.error.onNext("Não conseguimos encontrar as categorias.")
                }
            } catch {
                self?.error.onNext("Não foi possível buscar as categorias.")
            }
        }, onError: { [weak self]  (error) in
            self?.isLoading.onNext(false)
            self?.error.onNext("Não foi possível buscar as categorias.")
        }).disposed(by: disposeBag)
    }
}
