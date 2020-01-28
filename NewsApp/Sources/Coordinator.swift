//
//  Coordinator.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import Swinject
import UIKit
import SafariServices

protocol CoordinatorDelegate: AnyObject {
    func openNews(from url: URL)
}

final class Coordinator {
    
    private var container: Container
    
    private var navigationController: UINavigationController?
    
    init(container: Container) {
        self.container = container
    }
    
    func start() {
        navigationController = UINavigationController()
        
        let newsFeedVC = container.resolve(NewsFeedViewController.self)!
        newsFeedVC.delegate = self
        
        navigationController?.viewControllers = [newsFeedVC]
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
    }
}

extension Coordinator: CoordinatorDelegate {
    func openNews(from url: URL) {
        let safariVC = SFSafariViewController(url: url)
        navigationController?.present(safariVC, animated: true, completion: nil)
    }
}

