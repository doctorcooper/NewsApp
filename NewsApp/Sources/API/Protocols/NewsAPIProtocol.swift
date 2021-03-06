//
//  NewsAPIProtocol.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import Moya
import RxSwift

protocol NewsAPIProtocol {
    
    init(provider: MoyaProvider<NewsProvider>)
    
    func getNewsFeed(page: Int) -> Single<Response>
}
