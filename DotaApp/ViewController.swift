//
//  ViewController.swift
//  DotaApp
//
//  Created by Emin Bari on 18.07.2020.
//  Copyright © 2020 Emin Bari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    var heroes = [HeroModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dota-2 characters"

        setupTableView()
        fetchData {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView(){
        let nibItemCell = UINib(nibName: "ItemTableViewCell", bundle: nil)
        tableView.register(nibItemCell, forCellReuseIdentifier: "itemCellIdentifier")
    }
    
    func fetchData(complited: @escaping () -> ()){
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!){ (data, respons, error) in
            if error == nil {
                do{
                    self.heroes = try JSONDecoder().decode([HeroModel].self, from: data!)
                    DispatchQueue.main.async {
                        complited()
                    }
                }
                catch{
                    print("Error")
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCellIdentifier", for: indexPath) as! ItemTableViewCell
        cell.initCell(
            imageName: heroes[indexPath.row].icon,
            title: heroes[indexPath.row].localized_name.capitalized
        )
       
        return cell
    }
}

extension ViewController: UITableViewDelegate{
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? HeroViewController{
            dest.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}

