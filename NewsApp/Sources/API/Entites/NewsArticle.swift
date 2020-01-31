//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import Foundation

struct NewsArticle: Codable {
    
    let title: String
    let description: String
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date
}
