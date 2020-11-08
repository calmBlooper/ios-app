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
                          let json = try JSONDecoder().decode(APIResult.self, from: data! )
                print("here are supposed to be \(request.limit) results from \(request.subreddit)")
                httpService.passToDB(response: json, onCompletion: onCompletion)
                      } catch {
                          print("Error during JSON serialization: \(error.localizedDescription)")
                      }
        }
        task.resume()
    }
    func formRequestURL(_ request: RequestTop)->String{
        return "https://www.reddit.com/r/\(request.subreddit)/top.json?limit=\(request.limit)"+(request.after==nil ? "" : request.after!)
    }
}
