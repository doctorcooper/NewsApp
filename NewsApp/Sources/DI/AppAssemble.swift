//
//  AppAssemble.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import Swinject
import Moya

final class AppAssemble: Assembly {
    
    func assemble(container: Container) {
        
        // Регистрируем API
        container.register(NewsAPIProtocol.self) { _ in
            
            var logger: NetworkLoggerPlugin { // logger выпилить
                var configuration = NetworkLoggerPlugin.Configuration()
                configuration.logOptions = .verbose
                
                let networkLoggerPlugin = NetworkLoggerPlugin(configuration: configuration)
                return networkLoggerPlugin
            }
            
            let provider = MoyaProvider<NewsProvider>(plugins: [])
            return NewsAPI(provider: provider)
        }
        
        // Регистрируем Репозиторий
        container.register(NewsRepositoryProtocol.self) { resolver in
            let api = resolver.resolve(NewsAPIProtocol.self)!
            return NewsRepository(api: api)
        }
        
        // Регистрируем Вьюмодель
        container.register(NewsFeedViewModel.self) { resolver in
            let repository = resolver.resolve(NewsRepositoryProtocol.self)!
            return NewsFeedViewModel(repository: repository)
        }
        
        // Регистрируем Контроллер
        container.register(NewsFeedViewController.self) { resolver in
            let viewModel = resolver.resolve(NewsFeedViewModel.self)!
            let viewController = NewsFeedViewController()
            viewController.viewModel = viewModel
            return viewController
        }
        
        // Регистрируем координатор
        container.register(Coordinator.self) { _ in
            return Coordinator(container: container)
        }
    }
}
