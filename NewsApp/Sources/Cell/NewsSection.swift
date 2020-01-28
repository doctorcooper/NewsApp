//
//  NewsSection.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import RxDataSources

struct NewsSection {
    var header: String
    var items: [Item]
}

extension NewsSection: SectionModelType {
    
    typealias Item = NewsArticle
    
    init(original: Self, items: [Self.Item]) {
        self = original
        self.items = items
    }
}
