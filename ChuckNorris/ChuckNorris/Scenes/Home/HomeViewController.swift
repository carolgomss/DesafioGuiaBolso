//
//  HomeViewController.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 08/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: GBViewController {

    private let viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()

    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        return tableView
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        if #available(iOS 13, *) {
            activityIndicatorView.style = .large
        } else {
            activityIndicatorView.style = .gray
        }
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        view.backgroundColor = .white
        setupSubViews()
        setupConstraints()
        setupBinding()
        viewModel.loadCategories()
    }
    
    private func setupBinding() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        viewModel.categories.bind(to: tableView.rx.items(cellIdentifier: "cellIdentifier")) { (_, category: String, cell) in
            cell.textLabel?.text = category.capitalized
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self).subscribe(onNext: { [weak self] category in
            self?.navigateToDetail(category: category)
        }).disposed(by: disposeBag)
        
        viewModel.isLoading.bind { [weak self]  (isLoading) in
            if isLoading {
                self?.showLoading()
            } else {
                self?.hideLoading()
            }
        }.disposed(by: disposeBag)
        
        viewModel.error.bind { [weak self] (message) in
            self?.showErrorMessage(message)
        }.disposed(by: disposeBag)
    }
    
    private func navigateToDetail(category: String) {
        let controller = DetalsViewController()
        controller.category = category
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { [weak self] (_) in
            self?.viewModel.loadCategories()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func hideLoading() {
        UIView.animate(withDuration: 0.5) {
            self.tableView.alpha = 1
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    private func showLoading() {
        UIView.animate(withDuration: 0.5) {
            self.tableView.alpha = 0
            self.activityIndicatorView.startAnimating()
        }
    }
    
    private func setupSubViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
    }
    
    private func setupConstraints() {
        self.setupTableViewConstraints()
        self.setupActivityIndicatorViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func setupActivityIndicatorViewConstraints() {
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
