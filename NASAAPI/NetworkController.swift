//
//  NetworkController.swift
//  NASAAPI
//
//  Created by Ahmet Ali ÇETİN on 17.03.2023.
//

import Foundation

class NetworkController {
    open func fetchPhotos(completion: @escaping (DailyImageModel?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            "date": "2011-07-13"
        ]
        
        let queryURL = (baseURL?.withQueries(query))!
        let jsonQueryTask = URLSession.shared.dataTask(with: queryURL) { data, _, error in
            let jsonDecoder = JSONDecoder()
        
            if let data = data, let dailyImageObject = try? jsonDecoder.decode(DailyImageModel.self, from: data)  {
                completion(dailyImageObject)
            } else {
                completion(nil)
            }
        }
        jsonQueryTask.resume()
    }
}
