//
//  NewsParameters.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import Foundation

struct NewsParameters: Encodable {
    let query: String
    let from: String
    let sortBy: String
    let apiKey: String
    let page: Int
    
    init(page: Int) {
        self.query = "android"
        self.from = "2019-04-00"
        self.sortBy = "publishedAt"
        self.apiKey = Constants.apiKey
        self.page = page
    }
    
    enum CodingKeys: String, CodingKey {
        case query = "q"
        case from, sortBy, apiKey, page
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
