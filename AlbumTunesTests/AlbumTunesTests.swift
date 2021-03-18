//
//  AlbumTunesTests.swift
//  AlbumTunesTests
//
//  Created by Scott on 3/17/21.
//

import XCTest

@testable import AlbumTunes
class AlbumTunesTests: XCTestCase {
    
    let albums = Feed.allMocks.feed.results
    
    // MARK: - Model Tests
    
    func testJSONLoadsCorrectly() {
        XCTAssertTrue(albums.isEmpty == false, "Failed to load albums from JSON.")
    }
    
    func testAllResultsLoaded() {
        XCTAssertEqual(albums.count, 100, "All results was not 100.")
    }
    
    func testImageUrlsAreNotEmpty() {
        for album in albums {
            guard let url = album.artworkURL else { return }
            XCTAssertTrue(!url.isEmpty, "Album image url in mocks is empty.")
        }
    }
    
    func testGenreUrlsAreNotEmpty() {
        for album in albums {
            guard let url = album.albumUrl else { return }
            XCTAssertTrue(!url.isEmpty, "Album url in mocks is empty.")
        }
    }

}
