//
//  DailyImageModel.swift
//  NASAAPI
//
//  Created by Ahmet Ali ÇETİN on 17.03.2023.
//

import Foundation

struct DailyImageModel: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "explanation"
        case url = "url"
        case copyright = "copyright"
    }
}
