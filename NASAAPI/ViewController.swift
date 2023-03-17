//
//  ViewController.swift
//  NASAAPI
//
//  Created by Ahmet Ali ÇETİN on 17.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: LIFECYLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    //MARK: FUNCTIONS
    private func fetchPhotos(completion: @escaping (DailyImageModel) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            "date": "2011-07-13"
        ]
        
        let queryURL = (baseURL?.withQueries(query))!
        let jsonQueryTask = URLSession.shared.dataTask(with: queryURL) { data, _, error in
            let jsonDecoder = JSONDecoder()
        
            if let data = data {
                do {
                    let dailyImageObject = try jsonDecoder.decode(DailyImageModel.self, from: data)
                    completion(dailyImageObject)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        jsonQueryTask.resume()
    }
    
    private func updateUI() {
        
        self.imgView.layer.cornerRadius = 100
        self.imgView.layer.masksToBounds = true
        view.addSubview(imgView)
        
        fetchPhotos { photoInformations in
            guard let urlWithDataFormat = try? Data(contentsOf: photoInformations.url) else { return }
            DispatchQueue.main.async {
                self.titleLabel.text = photoInformations.title
                self.descriptionLabel.text = photoInformations.description
                self.imgView.image = UIImage(data: urlWithDataFormat)
            }
        }
        
    }
    //MARK: ACTIONS
}

//MARK: EXTENSIONS
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value)}
        return components?.url
    }
}
