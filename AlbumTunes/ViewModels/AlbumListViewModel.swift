//
//  AlbumListViewModel.swift
//  AlbumTunes
//
//  Created by Scott on 3/15/21.
//

import UIKit

final class AlbumListViewModel {
    static let shared = AlbumListViewModel()
    
    var albumVM = [AlbumViewModel]()
    let reuseID = "Album"
    
    func getAlbum(completion: @escaping ([AlbumViewModel]) -> Void) {
        NetworkManager.shared.fetchAlbums { [weak self] (result) in
            switch result {
            case .success(let items):
                let albumVM = items.map(AlbumViewModel.init)
                DispatchQueue.main.async {
                    self?.albumVM = albumVM
                    completion(albumVM)
                }
            case .failure(let error):
                self?.displayError(error, title: "Failed to load albums")
            }
        }
    }
    
    func displayError(_ error: Error, title: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title,
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss",
                                              style: .default,
                                              handler: nil))
                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    
}
