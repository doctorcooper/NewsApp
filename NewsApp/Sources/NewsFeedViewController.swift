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
import RxDataSources

final class NewsFeedViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private let disposeBag = DisposeBag()

    var viewModel: NewsFeedViewModel!
    
    weak var delegate: CoordinatorDelegate?
    
    var dataSource: RxTableViewSectionedReloadDataSource<NewsSection>!
    
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
        tableView.register(NewsItemTableViewCell.self,
                           forCellReuseIdentifier: String(describing: NewsItemTableViewCell.self))
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
        
        dataSource = RxTableViewSectionedReloadDataSource<NewsSection>(configureCell: { (_, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsItemTableViewCell.self),
                                                     for: indexPath) as! NewsItemTableViewCell
            cell.configure(from: item)
            return cell
        })
        
        viewModel.state.map { $0.newsList }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(NewsArticle.self)
            .subscribe(onNext: { [weak self] item in
                self?.delegate?.openNews(from: item.url)
            })
        .disposed(by: disposeBag)
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let
    }
}
