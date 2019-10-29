//
//  SongDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Надежда Морозова on 29/10/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class SongDetailHeaderViewController: UIViewController {
    
    // MARK: - Views
    
    private(set) lazy var artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var openButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Открыть", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        return button
    }()
    
    private(set) lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.contentMode = .left
        return label
    }()
    
    // MARK: - Properties
    
    private let song: ITunesSong
    
    private let imageDownloader = ImageDownloader()
    
    // MARK: - Init
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.fillData()
    }
    
    // MARK: - Private
    
    private func setupLayout() {
        self.view.addSubview(self.artworkImageView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.artistLabel)
        self.view.addSubview(self.openButton)
        self.view.addSubview(self.collectionNameLabel)
        
        NSLayoutConstraint.activate([
            self.artworkImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.artworkImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16.0),
            self.artworkImageView.widthAnchor.constraint(equalToConstant: 120.0),
            self.artworkImageView.heightAnchor.constraint(equalToConstant: 120.0),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.artworkImageView.rightAnchor, constant: 16.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),
            
            self.artistLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0),
            self.artistLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            self.artistLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor),
            
            self.openButton.leftAnchor.constraint(equalTo: self.artworkImageView.rightAnchor, constant: 16.0),
            self.openButton.bottomAnchor.constraint(equalTo: self.artworkImageView.bottomAnchor),
            self.openButton.widthAnchor.constraint(equalToConstant: 80.0),
            self.openButton.heightAnchor.constraint(equalToConstant: 32.0),
            
            self.collectionNameLabel.topAnchor.constraint(equalTo: self.artworkImageView.bottomAnchor, constant: 24.0),
            self.collectionNameLabel.leftAnchor.constraint(equalTo: self.artworkImageView.leftAnchor),
            self.collectionNameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16.0),
            self.collectionNameLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    private func fillData() {
        self.downloadImage()
        self.titleLabel.text = song.trackName
        self.artistLabel.text = song.artistName
        self.collectionNameLabel.text = song.collectionName
    }
    
    private func downloadImage() {
        guard let url = self.song.artwork else { return }
        self.imageDownloader.getImage(fromUrl: url) { (image, _) in
            self.artworkImageView.image = image
        }
    }
}

