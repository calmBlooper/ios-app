//
//  PersistanceManager.swift
//  Levchuk06
//
//  Created by Admin on 08.11.2020.
//

import Foundation
public class PersistenceManager{
  var loadedPosts: [ResponsePost]=[]
    func passPostsToRepo(after:String?,before:String?,onCompletion: @escaping(_ results: ResponseTop)->Void){
        repository.prepareTopPosts(posts:loadedPosts,after:after,before:before,onCompletion:onCompletion)
    }

    func childToResponsePost(_ child: APIDataChildData)->ResponsePost{
        return ResponsePost(title: child.title, ups: child.ups, author: child.author, domain: child.domain, imageUrl: child.imageUrl, numComments: child.numComments, timeCreated: child.timeCreated)
    }
    func updatePosts(response: APIResult,onCompletion: @escaping(_ results: ResponseTop)->Void){
        loadedPosts=[]
        for child in response.data.children{
            loadedPosts.append(childToResponsePost(child.data))
    }
        passPostsToRepo(after:response.data.after,before:response.data.before,onCompletion: onCompletion)
}
}
