//
//  HTTPServer.swift
//  Levchuk06
//
//  Created by Admin on 08.11.2020.
//

import Foundation
public class HTTPService{
    let httpRequester: HTTPRequester=HTTPRequester()
    let persistenceManager: PersistenceManager=PersistenceManager()
    func sendRequest(subreddit: String,limit: UInt8,after: String?,onCompletion: @escaping(_ results: ResponseTop)->Void){
        httpRequester.conductRequest(request: RequestTop(subreddit: subreddit, limit: limit, after: after), onCompletion: onCompletion)
    }
    func passToDB(response: APIResult,onCompletion: @escaping(_ results: ResponseTop)->Void){
        persistenceManager.updatePosts(response: response, onCompletion: onCompletion)
    }
}
