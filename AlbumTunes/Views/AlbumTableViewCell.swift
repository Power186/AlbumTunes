//
//  AlbumTableViewCell.swift
//  AlbumTunes
//
//  Created by Scott on 3/15/21.
//

import UIKit

final class AlbumTableViewCell: UITableViewCell {
    
    var albumVM: AlbumViewModel? {
        didSet {
            if let albumVM = albumVM {
                albumLabel.text = albumVM.albumName
                artistLabel.text = albumVM.artist
                
                NetworkManager.shared.fetchImage(urlString: albumVM.artworkUrl) { [weak self] (result) in
                    switch result {
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            self?.albumImage.image = UIImage(data: imageData)
                        }
                    case .failure(let error):
                        AlbumListViewModel.shared.displayError(error, title: "Failed to fetch image(s)")
                    }
                }
            }
        }
    }
    
    private lazy var albumImage: UIImageView = {
       let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var albumLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.adjustsFontSizeToFitWidth = true
        v.font = .boldSystemFont(ofSize: 14)
        v.textColor = UIColor.systemPink
        return v
    }()
    
    private lazy var artistLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.font = .italicSystemFont(ofSize: 12)
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with mock: StoreItem) {
        albumLabel.text = mock.albumName ?? ""
        artistLabel.text = mock.artist ?? ""
        
        NetworkManager.shared.fetchImage(urlString: mock.artworkURL ?? "") { (result) in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.albumImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                AlbumListViewModel.shared.displayError(error, title: "Failed to load image(s)")
            }
        }
    }
    
    private func setupView() {
        selectionStyle = .none
        
        addSubview(albumImage)
        setImageConstraints()
        
        addSubview(albumLabel)
        setAlbumConstraints()
        
        addSubview(artistLabel)
        setArtistConstraints()
    }
    
    private func setImageConstraints() {
        albumImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        albumImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        albumImage.widthAnchor.constraint(equalTo: albumImage.heightAnchor, multiplier: 14/9).isActive = true
    }
    
    private func setAlbumConstraints() {
        albumLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        albumLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 10).isActive = true
        albumLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
    
    private func setArtistConstraints() {
        artistLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 10).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        artistLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
}
