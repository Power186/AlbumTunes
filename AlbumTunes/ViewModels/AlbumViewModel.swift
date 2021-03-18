//
//  AlbumViewModel.swift
//  AlbumTunes
//
//  Created by Scott on 3/15/21.
//

import UIKit

struct AlbumViewModel {
    let storeItem: StoreItem
    
    var artist: String {
        return storeItem.artist ?? "Unknown artist"
    }
    
    var albumName: String {
        return storeItem.albumName ?? "Unknown album"
    }
    
    var artworkUrl: String {
        return storeItem.artworkURL ?? ""
    }
    
    var copyright: String {
        return storeItem.copyright ?? "No copyright found"
    }
    
    var releaseDate: String {
        return storeItem.releaseDate ?? "Unknown release date"
    }
    
    var genreName: String {
        var result = ""
        guard let genres = storeItem.genres else { return "" }
        for item in genres {
            result = item.genreName
        }
        return result
    }
    
    var albumUrl: String {
        return storeItem.albumUrl ?? ""
    }
    
}
