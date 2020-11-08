//
//  UseCase.swift
//  Levchuk06
//
//  Created by Admin on 08.11.2020.
//

import Foundation
public class UseCase{
    /**
     Handles the results received  from Repository, currently just prints them.
     */
    func processTopPosts(_ results: ResponseTop){
      printResults(results)
    }

    func fetchTopPosts(subreddit: String,limit: UInt8,after: String?,onCompletion: @escaping(_ results: ResponseTop)->Void){
        repository.demandTopPosts(subreddit: subreddit, limit: limit, after: after, onCompletion: onCompletion)
    }
    func printResults(_ results: ResponseTop) {
        print("Received results(\(results.posts.count) posts):")
        if let after=results.after {
            print("After: \(after)")
        }
        if let before=results.before {
            print("Before: \(before)")
        }
        for post in results.posts {
            print("""


##########
Title: \(post.title)
Author: \(post.author)
Domain: \(post.domain)
Ups: \(post.ups)
Number of comments: \(post.numComments)
\(post.imageUrl.contains(".jpg")||post.imageUrl.contains(".png")||post.imageUrl.contains(".jpeg")||post.imageUrl.contains(".tiff")||post.imageUrl.contains(".gif") ? "Image URL: \(post.imageUrl)" : "This is a text post.")
""")
            let date = NSDate(timeIntervalSince1970: post.timeCreated)
            print("Posted \(Calendar.current.dateComponents([.hour], from: date as Date, to: NSDate() as Date).hour!) hours ago.")
            print("##########")
        }
    }
}
public var httpRequester=HTTPRequester()
public var httpService = HTTPService()
public var persistenceManager = PersistenceManager()
public var repository = Repository()
public var useCase=UseCase()



