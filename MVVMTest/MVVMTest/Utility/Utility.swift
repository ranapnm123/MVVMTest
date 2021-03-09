//
//  Utility.swift
//  MVVMTest
//
//  Created by Ravi Rana on 09/03/21.
//

import UIKit

let userData = "userDetail"
class Utility {
    
    
    static let shared = Utility()
    
    struct UserData: Codable {
        var email:String?
        var password:String?
        var favoriteData = [PostData]()
    }
    
    func saveUserDetails(email:String, pass:String) {
        let user = UserData(email: email, password: pass, favoriteData: Utility.shared.getUserDetails()?.favoriteData ?? [])
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userData)
        }
    }
    
    func getUserDetails() -> UserData? {
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: userData) as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(UserData.self, from: savedPerson) {
                return loadedPerson
            }
        }
        return nil
    }
    func savePosts(dataArr:[PostData]) {
        let cacheData = self.getUserDetails()?.favoriteData
        let email = getUserDetails()?.email
        let pass = getUserDetails()?.password
        var favData = [PostData]()
        for data in dataArr {
            
            if let first = cacheData?.firstIndex(where: {$0.id == data.id}) {
                let post = PostData(userId: data.userId, id: data.id, title: data.title, body: data.body, isFavorite: cacheData?[first].isFavorite)
                favData.append(post)
                
            } else {
                let post = PostData(userId: data.userId, id: data.id, title: data.title, body: data.body, isFavorite: false)
                favData.append(post)
            }
            
        }
        let user = UserData(email: email, password: pass, favoriteData: favData)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userData)
        }
    }
    
    func saveFavorite(data:PostData) {
        var cacheData = self.getUserDetails()?.favoriteData
        
        
        if let first = cacheData?.firstIndex(where: {$0.id == data.id}) {
            cacheData?[first].isFavorite = true
            
        }
        let email = getUserDetails()?.email
        let pass = getUserDetails()?.password
        let favData = cacheData
        let user = UserData(email: email, password: pass, favoriteData: favData!)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userData)
        }
    }
    
    func removeFavorite(data:PostData) {
        var cacheData = self.getUserDetails()?.favoriteData
        
        
        if let first = cacheData?.firstIndex(where: {$0.id == data.id}) {
            cacheData?[first].isFavorite = false
            
        }
        let email = getUserDetails()?.email
        let pass = getUserDetails()?.password
        let favData:[PostData] = cacheData!
        
        let user = UserData(email: email, password: pass, favoriteData: favData)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userData)
        }
    }
}














