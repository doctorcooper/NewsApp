//
//  NewsFeedViewModel.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import RxSwift
import ReactorKit

final class NewsFeedViewModel: Reactor {
    
    private let repository: NewsRepositoryProtocol
    
    private let disposeBag = DisposeBag()
    
    let initialState: State
    
    init(repository: NewsRepositoryProtocol) {
        self.repository = repository
        initialState = State()
    }
    
    enum Action {
        case getNews
    }
    
    enum Mutation {
        case setNews(news: [NewsSection])
    }
    
    struct State {
        var currentPage: Int = 1
        var newsList: [NewsSection] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getNews:
            return getNews().map { .setNews(news: $0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setNews(let news):
            newState.newsList = news
        }
        return newState
    }
    
    func getNews() -> Observable<[NewsSection]> {
        return repository.getNewsFeed(page: 1).asObservable()
            .map { guard !$0.isEmpty else { return [] }
                return [NewsSection(header: "", items: $0)] }
    }
}
