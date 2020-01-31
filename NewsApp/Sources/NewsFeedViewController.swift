//
//  NewsFeedViewController.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class NewsFeedViewController: UIViewController, UITableViewDelegate {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let disposeBag = DisposeBag()

    var viewModel: NewsFeedViewModel!
    
    weak var delegate: CoordinatorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        makeConstraints()
        setupRx()
        viewModel.action.onNext(.getNews)
    }
    
    private func setupView() {
        
        title = "News App"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.register(UINib(nibName: "NewsItemTableViewCell", bundle: .main),
                           forCellReuseIdentifier: "NewsItemTableViewCell")
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func makeConstraints() {
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupRx() {
        
        viewModel.state.map { $0.newsList }
            .bind(to: tableView.rx.items(cellIdentifier: String(describing: NewsItemTableViewCell.self),
                                         cellType: NewsItemTableViewCell.self)) { _, item, cell in
                                            cell.configure(from: item)
                                            
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(NewsArticle.self)
            .subscribe(onNext: { [weak self] item in
                self?.delegate?.openNews(from: item.url)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .filter { [weak self] offset in
                guard let `self` = self else { return false }
                guard self.tableView.frame.height > 0 else { return false }
                return offset.y + self.tableView.frame.height >= self.tableView.contentSize.height - 100
        }
        .map { _ in NewsFeedViewModel.Action.getMoreNews }
        .bind(to: viewModel.action)
        .disposed(by: disposeBag)
    }
}
