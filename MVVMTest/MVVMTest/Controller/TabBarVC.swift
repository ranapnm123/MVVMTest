//
//  TabBarVC.swift
//  MVVMTest
//
//  Created by Ravi Rana on 09/03/21.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem=nil
        self.navigationItem.hidesBackButton=true
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutAction))
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func logoutAction() {
        let yes = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.navigationController?.popViewController(animated: false)
            UserDefaults.standard.removeObject(forKey: userData)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        alert.addAction(yes)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
       
    }
}
