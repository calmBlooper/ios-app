//
//  PersistanceManager.swift
//  Levchuk06
//
//  Created by Admin on 08.11.2020.
//

import Foundation
public class PersistenceManager{
  var loadedPosts: [ResponsePost]=[]
    var loadedComments: [Comment]=[]
    func passPostsToRepo(after:String?,before:String?,onCompletion: @escaping(_ results: ResponseTop)->Void){
        repository.prepareTopPosts(posts:loadedPosts,after:after,before:before,onCompletion:onCompletion)
    }
    func passCommentsToRepo(after:String?,before:String?,onCompletion: @escaping(_ results: CommentsResponse)->Void){
        repository.prepareComments(comments: loadedComments, after: after, before: before, onCompletion: onCompletion)
    }
    func childToComment(_ child: APICommentDataChildData)->Comment {
        
        return Comment(id: loadedComments.count+1,commentId:(child.id ?? "default id"), author: (child.author ?? "default author"), timeCreated: Double(child.timeCreated ?? 0.0), rating: (child.ups ?? 1), text: String(child.body ?? "default text"), permalink: String(child.permalink ?? "default link"))
    }
    func childToResponsePost(_ child: APIDataChildData)->ResponsePost{
        return ResponsePost(id: child.id, title: child.title, ups: child.ups, author: child.author, domain: child.domain, imageUrl: child.imageUrl, numComments: child.numComments, timeCreated: child.timeCreated)
    }
    func updateComments(response: APIResultComments,onCompletion: @escaping(_ results: CommentsResponse)->Void){
        loadedComments=[]
        guard let actualData=response.data else {
            print("Corrupted data received!!!")
            return
        }
        guard let children=actualData.children else {
            print("Corrupted data received!!!")
            return
        }
        for comment in children {
            guard let commentData=comment.data else {
                print("Corrupted data received!!!")
                return
            }
            loadedComments.append(childToComment(commentData))
        }
        passCommentsToRepo(after: actualData.after, before: actualData.before, onCompletion: onCompletion)
    }
    func updatePosts(response: APIResult,onCompletion: @escaping(_ results: ResponseTop)->Void){
        loadedPosts=[]
        for child in response.data.children{
            loadedPosts.append(childToResponsePost(child.data))
    }
        passPostsToRepo(after:response.data.after,before:response.data.before,onCompletion: onCompletion)
}
}
