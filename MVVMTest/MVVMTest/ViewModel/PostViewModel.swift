//
//  PostViewModel.swift
//  MVVMTest
//
//  Created by Ravi Rana on 09/03/21.
//

import UIKit

public class PostViewModel {
    
    let posts: Box<[PostData]?> = Box(nil)

    init() {
        fetchPosts()
    }
    private func fetchPosts() {
        NetworkManager.getPostSData(completion: { [weak self] (data, error) in
           
        guard
          let self = self,
          let postData = data
          else {
            return
          }
        self.posts.value = postData
        
      })
    }
    
}
