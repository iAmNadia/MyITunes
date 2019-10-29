//
//  AppReleaseNotesViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Надежда Морозова on 29/10/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class AppReleaseNotesViewController: UIViewController {
    
    // MARK: - Views
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Что нового"
        return label
    }()
    
    private(set) lazy var versionNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var versionHistoryButtonMock: UIButton = {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("История версий", for: .normal)
        return button
    }()
    
    private(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Stack views
    
    private(set) var titleAndVersionNumberStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    private(set) var versionHistoryAndDateStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .trailing
        stackView.spacing = 0
        return stackView
    }()
    
    private(set) var topElementsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private(set) var allElementsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Properties
    
    private let app: ITunesApp
    
    // MARK: - Init
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fillData()
    }
    
    // MARK: - Private
    
    private func setupLayout() {
        self.view.addSubview(titleAndVersionNumberStack)
        self.titleAndVersionNumberStack.addArrangedSubview(titleLabel)
        self.titleAndVersionNumberStack.addArrangedSubview(versionNumberLabel)
        
        self.view.addSubview(versionHistoryAndDateStack)
        self.versionHistoryAndDateStack.addArrangedSubview(versionHistoryButtonMock)
        self.versionHistoryAndDateStack.addArrangedSubview(releaseDateLabel)
        
        self.view.addSubview(topElementsStack)
        self.topElementsStack.addArrangedSubview(titleAndVersionNumberStack)
        self.topElementsStack.addArrangedSubview(versionHistoryAndDateStack)
        
        self.view.addSubview(allElementsStack)
        self.allElementsStack.addArrangedSubview(topElementsStack)
        self.allElementsStack.addArrangedSubview(releaseNotesLabel)
        
        NSLayoutConstraint.activate([
            self.allElementsStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.allElementsStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 12.0),
            self.allElementsStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -12.0),
            self.allElementsStack.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    private func fillData() {
        self.versionNumberLabel.text = "Версия \(app.version ?? "")"
        self.releaseNotesLabel.text = app.releaseNotes
        self.releaseDateLabel.text = "Дата выхода: \(readableDate(fromAPIDate: app.currentVersionReleaseDate ?? ""))"
    }
    
    private func readableDate(fromAPIDate dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
        let newFormat = DateFormatter()
        newFormat.locale = .init(identifier: "RU")
        newFormat.dateFormat = "dd MMM"
        if let date = dateFormatter.date(from: dateString) {
            return newFormat.string(from: date)
        } else {
            return ""
        }
    }
    
}

