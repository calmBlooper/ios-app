//
//  APIFormat.swift
//  Levchuk06
//
//  Created by Admin on 08.11.2020.
//

import Foundation
public struct APIResult: Codable {
    let kind: String
    let data:APIData
    init(kind: String,data:APIData) {
          self.kind = kind
        self.data=data
      }
}
public struct APIData: Codable{
    let after: String?
    let before: String?
    let children: [APIDataChild]

}

public struct APIDataChild: Codable {
    let data: APIDataChildData

}
public struct APIDataChildData: Codable {
    let ups: Int
    let author: String
    let title: String
    let domain: String
    let imageUrl: String
    let numComments: Int
    let timeCreated: Double
    enum CodingKeys: String,CodingKey {
        case numComments="num_comments"
        case ups
        case author
        case title
        case domain
        case imageUrl = "url"
        case timeCreated="created_utc"
    }
    init(ups:Int,author:String,title:String,domain:String,numComments:Int,timeCreated:Double,imageUrl:String) {
          self.ups = ups
        self.author=author
        self.title=title
        self.domain=domain
        self.numComments=numComments
        self.timeCreated=timeCreated
        self.imageUrl=imageUrl
        
      }
}
/**
 Currently serves only for top posts retrieval, may later have name changed and be extended
 */
public struct RequestTop {
    let subreddit: String
    let limit: UInt8
    let after: String?
}
/**
 Serves to store and represent info about response from reddit top
 */
public struct ResponseTop{
    let after: String?
    let before: String?
    let posts: [ResponsePost]
}
/**
 Serves to store and represent info about one post
 */
public struct ResponsePost{
    let title: String
    let ups: Int
    let author: String
    let domain: String
    let imageUrl: String
    let numComments: Int
    let timeCreated: Double
}
