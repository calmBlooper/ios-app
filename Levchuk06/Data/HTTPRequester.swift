//
//  HTTPRequester.swift
//  Levchuk06
//
//  Created by Admin on 08.11.2020.
//

import Foundation


public class HTTPRequester {
    func conductRequest(request: RequestTop,onCompletion:@escaping(_ results: ResponseTop)->Void){
        let task = URLSession.shared.dataTask(with: URL(string: formRequestURL(request))!) { (data,response,error) in
            do {
                guard let document=data else {
                    print("No actual response received!")
                    return
                }
                          let json = try JSONDecoder().decode(APIResult.self, from: document )
                print("here are supposed to be \(request.limit) results from \(request.subreddit)")
                
                httpService.passToDB(response: json, onCompletion: onCompletion)
                      } catch {
                          print("Error during JSON serialization: \(error.localizedDescription)")
                      }
        }
        task.resume()
    }
    
    func conductCommentsRequest(request: CommentsRequest,onCompletion:@escaping(_ results: CommentsResponse)->Void){
        let task = URLSession.shared.dataTask(with: URL(string: formCommentsRequestURL(request))!) { (data,response,error) in
            do {
                guard let document=data else {
                    print("No actual response received!")
                    return
                }

                          let json = try JSONDecoder().decode([APIResultComments].self, from: document )
                //print(firstSentence)
               // print(json[1].kind+"1")
                print("here are supposed to be comments from post \(request.postId) in r/ \(request.subreddit)")
                
                httpService.passCommentsToDB(response: json[1], onCompletion: onCompletion)
                      } catch {
                          print("Error during JSON serialization: \(error.localizedDescription)")
                      }
        }
        task.resume()
    }
    
    func formCommentsRequestURL(_ request: CommentsRequest)->String{
        return "https://www.reddit.com/r/\(request.subreddit)/comments/\(request.postId)/.json"
    }
    func formRequestURL(_ request: RequestTop)->String{
        return /*"https://www.reddit.com/r/EarthPorn/comments/k2nxuv/.json"*/ "https://www.reddit.com/r/\(request.subreddit)/top.json?count=\(request.limit)"+(request.after==nil ? "" : request.after!)
 
    }

}

