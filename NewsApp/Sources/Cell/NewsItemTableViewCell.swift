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
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func configure(from item: NewsArticle) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        titleLabel.text = item.title
        dateLabel.text = dateFormatter.string(from: item.publishedAt)
        newsImageView.kf.setImage(with: item.urlToImage)
        descriptionLabel.text = item.description
    }
    
    private func setupUI() {

        selectionStyle = .none
        imageView?.kf.indicatorType = .activity
        
        newsImageView.snp.makeConstraints { (make) in
            make.height.equalTo(UIScreen.main.bounds.height / 4)
        }
    }
}
