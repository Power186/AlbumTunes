//
//  NetworkManager.swift
//  Albums
//
//  Created by Scott on 3/14/21.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    let imageCache = NSCache<NSString, NSData>()
    
    private let baseUrlString = "https://paceline-public-danger-danger-danger.s3-us-west-2.amazonaws.com/"
    private let USTopAlbums = "iOS-Coding-Test-Itunes-100.json"
    
    func fetchAlbums(completion: @escaping (Result<[StoreItem], Error>) -> Void) {
        let urlString = "\(baseUrlString)\(USTopAlbums)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    let storeItems = try JSONDecoder().decode(Feed.self, from: data)
                    completion(.success(storeItems.feed.results))
                } catch {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func fetchImage(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(.success(cachedImage as Data))
        } else {
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let data = data {
                    self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                    completion(.success(data))
                } else {
                    if let error = error {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
}
