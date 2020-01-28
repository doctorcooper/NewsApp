//
//  NewsRepositoryProtocol.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import RxSwift

protocol NewsRepositoryProtocol {
    
    func getNewsFeed(page: Int) -> Single<[NewsArticle]>
}
