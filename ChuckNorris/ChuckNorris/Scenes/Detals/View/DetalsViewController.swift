//
//  DetalsViewController.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 08/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import UIKit
import RxSwift

class DetalsViewController: GBViewController {
    
    private let viewModel = DetalsViewModel()
    private let disposeBag = DisposeBag()
    var category: String?
    
    lazy var iconImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .large
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category
        view.backgroundColor = .white
        setupSubViews()
        setupConstraints()
        setupBinding()
    }
    
    private func showErrorMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Tentar novamente", style: .default, handler: { [weak self] (_) in
            self?.viewModel.randomBy(category: self?.category ?? "")
        }))
        alertController.addAction(UIAlertAction(title: "Voltar", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func hideLoading() {
        UIView.animate(withDuration: 0.5) {
            self.iconImageView.alpha = 1
            self.detailLabel.alpha = 1
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    private func showLoading() {
        UIView.animate(withDuration: 0.5) {
            self.iconImageView.alpha = 0
            self.detailLabel.alpha = 0
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func setupBinding() {
        self.viewModel.randomBy(category: category ?? "")
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
        viewModel.jokeDetail.bind(to: detailLabel.rx.text).disposed(by: disposeBag)
        viewModel.jokeURLImage.bind { [weak self] (url) in
            self?.iconImageView.setImage(url: url)
        }.disposed(by: disposeBag)
    }
    
    private func setupSubViews() {
        view.addSubview(iconImageView)
        view.addSubview(detailLabel)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    private func setupConstraints() {
        setupIconImageViewConstraints()
        setupDetailLabelConstraints()
        setupActivityIndicatorViewConstraints()
    }
    
    private func setupIconImageViewConstraints() {
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupDetailLabelConstraints() {
        detailLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 30).isActive = true
        detailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    private func setupActivityIndicatorViewConstraints() {
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
