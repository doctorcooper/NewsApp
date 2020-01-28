//
//  NewsItemTableViewCell.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class NewsItemTableViewCell: UITableViewCell {

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        label.textAlignment = .justified
        return label
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(from item: NewsArticle) {
        titleLabel.text = item.title
        dateLabel.text = dateFormatter.string(from: item.publishedAt)
        newsImageView.kf.setImage(with: item.urlToImage)
        descriptionLabel.text = item.description
    }
    
    private func setupUI() {
        let subviews = [titleLabel, dateLabel, newsImageView, descriptionLabel]
        subviews.forEach { contentView.addSubview($0)}
        selectionStyle = .none
    }
    
    private func makeConstraints() {
        dateLabel.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(dateLabel.snp.bottom).offset(4)
        }
        
        newsImageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(UIScreen.main.bounds.height / 4)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(newsImageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
