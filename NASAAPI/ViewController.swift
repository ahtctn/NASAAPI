//
//  ViewController.swift
//  NASAAPI
//
//  Created by Ahmet Ali ÇETİN on 17.03.2023.
//

import UIKit

class ViewController: UIViewController {
    //MARK: PROPERTIES
    let networkController = NetworkController()
    
    // @escaping araştır
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
    
    private func updateUI() {
        
        self.imgView.layer.cornerRadius = 100
        self.imgView.layer.masksToBounds = true
        view.addSubview(imgView)
        
        networkController.fetchPhotos { photoInformations in
            guard let urlWithDataFormat = try? Data(contentsOf: photoInformations!.url) else { return } 
            DispatchQueue.main.async {
                self.titleLabel.text = photoInformations?.title
                self.descriptionLabel.text = photoInformations?.description
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
