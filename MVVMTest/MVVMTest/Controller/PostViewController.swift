//
//  ViewController.swift
//  MVVMTest
//
//  Created by Ravi Rana on 09/03/21.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postTable:UITableView!
    var postArray = [PostData]()
    private let viewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        viewModel.posts.bind { [weak self] (postData) in
            if let _ = postData {
                Utility.shared.savePosts(dataArr: postData!)
            }
            self?.postArray = Utility.shared.getUserDetails()!.favoriteData
            self?.postTable.reloadData()
        }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
    

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        Utility.shared.getUserDetails()!.favoriteData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let data = Utility.shared.getUserDetails()!.favoriteData[indexPath.row]
        cell.titlLabel.text = data.title
        cell.descLabel.text = data.body
        
        if data.isFavorite == true {
            cell.favoriteButton.isHidden = false
        } else {
            cell.favoriteButton.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = Utility.shared.getUserDetails()!.favoriteData[indexPath.row]
        if data.isFavorite == true {
            Utility.shared.removeFavorite(data: data)
        } else {
            Utility.shared.saveFavorite(data: data)
        }
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
    }
    
}

class PostCell: UITableViewCell {
    @IBOutlet weak var titlLabel:UILabel!
    @IBOutlet weak var descLabel:UILabel!
    @IBOutlet weak var favoriteButton:UIButton!
}

