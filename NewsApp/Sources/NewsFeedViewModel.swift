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
    
    private let maximumPages = 5
    
    let initialState: State
    
    init(repository: NewsRepositoryProtocol) {
        self.repository = repository
        initialState = State()
    }
    
    enum Action {
        case getNews
        case getMoreNews
    }
    
    enum Mutation {
        case setNews(news: [NewsArticle], nextPage: Int?)
        case appendNews(news: [NewsArticle], nextPage: Int?)
        case setLoadingNextPage(Bool)
    }
    
    struct State {
        var nextPage: Int?
        var newsList: [NewsArticle] = []
        var isLoadingNextPage: Bool = false
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getNews:
            return loadNews(page: 1).map { Mutation.setNews(news: $0, nextPage: $1) }
        case .getMoreNews:
            guard !self.currentState.isLoadingNextPage else {
                return Observable.empty()
            }
            guard let page = self.currentState.nextPage else {
                return Observable.empty()
            }
            return Observable.concat([
                Observable.just(Mutation.setLoadingNextPage(true)),
                loadNews(page: page).map { Mutation.appendNews(news: $0, nextPage: $1) },
                Observable.just(Mutation.setLoadingNextPage(false)),
            ])
                
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {

        case .setNews(let news, let nextPage):
            newState.newsList = news
            newState.nextPage = nextPage
        case .appendNews(let news, let nextPage):
            newState.newsList.append(contentsOf: news)
            newState.nextPage = nextPage
        case .setLoadingNextPage(let isLoadingNextPage):
            newState.isLoadingNextPage = isLoadingNextPage
        }
        return newState
    }

    func loadNews(page: Int) -> Observable<([NewsArticle], Int?)> {
        let emptyResult: ([NewsArticle], Int?) = ([], nil)
        guard page < maximumPages else {
            return .just(emptyResult)
        }
        return repository.getNewsFeed(page: page).asObservable()
            .map { news in
                let page = news.isEmpty ? nil : page + 1
                return (news, page)
        }
    }
}
