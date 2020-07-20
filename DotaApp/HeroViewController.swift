//
//  HeroViewController.swift
//  DotaApp
//
//  Created by Emin Bari on 18.07.2020.
//  Copyright © 2020 Emin Bari. All rights reserved.
//

import UIKit

class HeroViewController: UIViewController {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroHealth: UILabel!
    @IBOutlet weak var heroAttack: UILabel!
    
    var hero: HeroModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroName.text = hero?.localized_name.capitalized
        heroHealth.text = "\((hero?.base_health)!) XP"
        heroAttack.text = "\((hero?.attack_type)!)"
        
        let urlString: String = "https://api.opendota.com" + "\(hero!.img)"
        guard let imageUrl: URL = URL(string: urlString) else{return}
        
//        if let data = try? Data(contentsOf: imageUrl) {
//            heroImage.image = UIImage(data: data)
//        }
        
        downloadImage(from: imageUrl)
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.heroImage.image = UIImage(data: data)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
