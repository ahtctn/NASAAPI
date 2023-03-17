//
//  ViewController.swift
//  NASAAPI
//
//  Created by Ahmet Ali ÇETİN on 17.03.2023.
//

import UIKit

class ViewController: UIViewController {
    //MARK: YAPILMASI GEREKEN
    /// BU PROJE İÇERİSİNDE YAPILMASI GEREKEN NETWORKING'DE GELEN BU DICTIONARY ÖĞELERİNİN YERLEŞTİRİLMESİ

    //MARK: OUTLETS
    @IBOutlet weak var img: UIImageView!
    
    //MARK: LIFECYLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networking()
    }
    //MARK: FUNCTIONS
    private func networking() {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            "date": "2011-07-13"
        ]
        
        let queryURL = (baseURL?.withQueries(query))!
        let queryTask = URLSession.shared.dataTask(with: queryURL) { data, _, error in
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8){
                    print(responseString)
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
        queryTask.resume()
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
