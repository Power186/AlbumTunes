//
//  DetailViewController.swift
//  AlbumTunes
//
//  Created by Scott on 3/17/21.
//

import UIKit

class DetailViewController: UIViewController {
    
//    let storeItem: StoreItem
    let viewModel: AlbumViewModel
    
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
        v.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
//        v.text = storeItem.albumName
        v.text = viewModel.albumName
        return v
    }()
    
    private lazy var artistLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.adjustsFontSizeToFitWidth = true
        v.font = UIFont.systemFont(ofSize: 17, weight: .medium)
//        v.text = storeItem.artist
        v.text = viewModel.artist
        return v
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.adjustsFontSizeToFitWidth = true
        v.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        v.text = storeItem.releaseDate
        v.text = viewModel.releaseDate
        return v
    }()
    
    private lazy var genreLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.adjustsFontSizeToFitWidth = true
        v.font = UIFont.systemFont(ofSize: 17, weight: .light)
//        guard let albumGenres = storeItem.genres else { return UILabel() }
//        for genre in albumGenres {
//            v.text = genre.genreName
//        }
        v.text = viewModel.genreName
        return v
    }()
    
    private lazy var copyrightLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.numberOfLines = 0
        v.adjustsFontSizeToFitWidth = true
        v.font = UIFont.systemFont(ofSize: 17, weight: .thin)
//        v.text = storeItem.copyright
        v.text = viewModel.copyright
        return v
    }()
    
    private lazy var albumButton: UIButton = {
        let v = UIButton(type: .custom)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemPink
        v.setTitle("Go to Album", for: .normal)
        v.setTitleColor(.white, for: .normal)
        v.layer.cornerRadius = 8
        v.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return v
    }()
    
    init(viewModel: AlbumViewModel) {
//        self.storeItem = storeItem
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(albumImage)
        setAlbumImageConstraints()
        
        view.addSubview(albumLabel)
        setAlbumLabelConstraints()
        
        view.addSubview(artistLabel)
        setArtistLabelConstraints()
        
        view.addSubview(releaseDateLabel)
        setReleaseDateLabelConstraints()
        
        view.addSubview(genreLabel)
        setGenreLabelConstraints()
        
        view.addSubview(copyrightLabel)
        setCopyrightLabelConstraints()
        
        view.addSubview(albumButton)
        setAlbumButtonConstraints()
    }
    
    private func getImage() {
//        guard let url = storeItem.artworkURL else { return }
        NetworkManager.shared.fetchImage(urlString: viewModel.artworkUrl) { [weak self] (result) in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self?.albumImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                AlbumListViewModel.shared.displayError(error, title: "Failed to get image.")
            }
        }
    }
    
    @objc func buttonTapped() {
        UIView.animate(withDuration: 1.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.1, options: [], animations: { [weak self] in
            self?.albumButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self?.albumButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        
//        let albumStringUrl = storeItem.albumUrl ?? ""
        guard let albumUrl = URL(string: viewModel.albumUrl) else { return }
        UIApplication.shared.open(albumUrl)
    }
    
    private func setAlbumImageConstraints() {
        albumImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        albumImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setAlbumLabelConstraints() {
        albumLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 16).isActive = true
        albumLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        albumLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setArtistLabelConstraints() {
        artistLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 16).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setReleaseDateLabelConstraints() {
        releaseDateLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 16).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setGenreLabelConstraints() {
        genreLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 16).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setCopyrightLabelConstraints() {
        copyrightLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 16).isActive = true
        copyrightLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        copyrightLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setAlbumButtonConstraints() {
        albumButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        albumButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        albumButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }

}
