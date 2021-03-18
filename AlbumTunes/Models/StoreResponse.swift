//
//  StoreResponse.swift
//  Albums
//
//  Created by Scott on 3/14/21.
//

import Foundation

struct StoreResponse: Codable {
    let results: [StoreItem]
}

struct Feed: Codable {
    let feed: StoreResponse
}

extension Feed {
    static var allMocks = Bundle.main.decode(Feed.self, from: "Mock.json")
}
