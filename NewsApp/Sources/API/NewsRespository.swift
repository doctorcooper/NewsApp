//
//  NewsRespository.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import RxSwift
import Alamofire

final class NewsRepository: NewsRepositoryProtocol {
    
    private let api: NewsAPIProtocol
    
    init(api: NewsAPIProtocol) {
        self.api = api
    }
    
    func getNewsFeed(page: Int) -> Single<[NewsArticle]> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return api.getNewsFeed(page: page).map([NewsArticle].self,
                                               atKeyPath: "articles",
                                               using: decoder,
                                               failsOnEmptyData: false)
    }
}
