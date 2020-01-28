//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import Moya
import RxSwift

final class NewsAPI: NewsAPIProtocol {
    
    private let provider: MoyaProvider<NewsProvider>
    
    init(provider: MoyaProvider<NewsProvider>) {
        self.provider = provider
    }
    
    func getNewsFeed(page: Int) -> Single<Response> {
        return provider.rx.request(.getNewsFeed(page: page))
    }
}
