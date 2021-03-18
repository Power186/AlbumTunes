//
//  ViewController.swift
//  AlbumTunes
//
//  Created by Scott on 3/15/21.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = AlbumListViewModel()
    
    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.register(AlbumTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        v.dataSource = self
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAlbums()
        configureTableView()
    }
    
    private func configureTableView() {
        self.title = "Album Tunes"
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.pin(to: view)
    }
    
    private func fetchAlbums() {
        viewModel.getAlbum { [weak self] (_) in
            self?.tableView.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albumVM.count
//        return Feed.allMocks.feed.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? AlbumTableViewCell
        
        let albums = viewModel.albumVM[indexPath.row]
        cell?.albumVM = albums
//        let mock = Feed.allMocks.feed.results[indexPath.row]
//        cell?.update(with: mock)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let mockAlbumItem = Feed.allMocks.feed.results[indexPath.row]
        let albumItem = viewModel.albumVM[indexPath.row]
        let detailVC = DetailViewController(viewModel: albumItem) // vc params would change to storeItem for mock data
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
