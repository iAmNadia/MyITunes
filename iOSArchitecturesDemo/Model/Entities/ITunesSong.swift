//
//  ITunesSong.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

public struct ITunesSong: Codable {
    
    public var trackName: String
    public var artistName: String?
    public var collectionName: String?
    public var artwork: String?
    public var artistViewUrl: String?
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case trackName =      "trackName"
        case artistName =     "artistName"
        case collectionName = "collectionName"
        case artwork =        "artworkUrl100"
        case artistViewUrl =  "artistViewUrl"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.artistName = try? container.decode(String.self, forKey: .artistName)
        self.collectionName = try? container.decode(String.self, forKey: .collectionName)
        self.artistViewUrl = try? container.decode(String.self, forKey: .artistViewUrl)
        self.artwork = try? container.decode(String.self, forKey: .artwork)
    }
    
    // MARK: - Init
    
    internal init(trackName: String,
                  artistName: String?,
                  collectionName: String?,
                  artwork: String?,
                  artistViewUrl: String?) {
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.artwork = artwork
        self.artistViewUrl = artistViewUrl
    }
}
