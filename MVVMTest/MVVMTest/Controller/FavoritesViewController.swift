//
//  FavoritesViewController.swift
//  MVVMTest
//
//  Created by Ravi Rana on 09/03/21.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoriteTable:UITableView!

    var favoriteArray:[PostData]?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteArray = Utility.shared.getUserDetails()?.favoriteData.filter({$0.isFavorite == true }) ?? []
        favoriteTable.reloadData()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        favoriteArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavCell
        let data = favoriteArray?[indexPath.row]
        cell.titlLabel.text = data?.title
        cell.descLabel.text = data?.body
        
        return cell
    }
    
    
}

class FavCell: UITableViewCell {
    @IBOutlet weak var titlLabel:UILabel!
    @IBOutlet weak var descLabel:UILabel!
    @IBOutlet weak var favoriteButton:UIButton!
}

