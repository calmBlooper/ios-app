//
//  Repository.swift
//  Levchuk06
//
//  Created by Admin on 08.11.2020.
//

import Foundation
public class Repository{
    func prepareTopPosts(posts: [ResponsePost],after: String?,before: String?,onCompletion: (_ results: ResponseTop)->Void){
       onCompletion(ResponseTop(after: after, before:before, posts: posts))
    }
    func demandTopPosts(subreddit: String,limit: UInt8,after: String?,onCompletion: @escaping(_ results: ResponseTop)->Void) {
        httpService.sendRequest(subreddit: subreddit, limit: limit, after: after, onCompletion: onCompletion)
    }
 
}
