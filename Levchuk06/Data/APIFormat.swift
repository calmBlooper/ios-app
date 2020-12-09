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
public struct APIResultComments: Codable {
    let kind: String
    let data:APICommentData?
    init(kind: String,data:APICommentData) {
          self.kind = kind
        self.data=data
      }
}

public struct APICommentData: Codable{
    let after: String?
    let before: String?
    let children: [APICommentDataChild]?

}

public struct APIData: Codable{
    let after: String?
    let before: String?
    let children: [APIDataChild]

}

public struct APICommentDataChild: Codable {
    let data: APICommentDataChildData?

}

public struct APICommentDataChildData: Codable {
    let id: String?
    let ups: Int?
    let author: String?
    let body: String?
    let permalink: String?
    let timeCreated: Double?
    enum CodingKeys: String,CodingKey {
        case ups
        case author
        case id
        case body
        case permalink
        case timeCreated="created_utc"
    }
    init(id: String,ups:Int,author:String,body: String,permalink: String,timeCreated:Double) {
        self.id=id
          self.ups = ups
        self.author=author
        self.body=body
        self.permalink=permalink
        self.timeCreated=timeCreated
        
      }
}

public struct APIDataChild: Codable {
    let data: APIDataChildData

}
public struct APIDataChildData: Codable {
    let id: String
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
        case id
        case domain
        case imageUrl = "url"
        case timeCreated="created_utc"
    }
    init(id: String,ups:Int,author:String,title:String,domain:String,numComments:Int,timeCreated:Double,imageUrl:String) {
        self.id=id
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

public struct CommentsRequest {
    let subreddit: String
    let postId: String
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
 Serves to store and represent info about response from reddit comments (for individual post)
 */
public struct CommentsResponse{
    let after:String?
    let before:String?
    let comments:[Comment]
}

/**
 Serves to store and represent info about one post
 */
public struct ResponsePost{
    let id: String
    let title: String
    let ups: Int
    let author: String
    let domain: String
    let imageUrl: String
    let numComments: Int
    let timeCreated: Double
}
public class Comment: Identifiable, ObservableObject {
    @Published public var id: Int
    @Published   var commentId: String
    @Published  var author: String
    @Published   var timeCreated: Double
    @Published  var rating: Int
    @Published  var text: String
    @Published  var permalink:String
     init(id: Int,commentId:String,author:String,timeCreated:Double,rating:Int,text:String,permalink:String){
        self.id=id
        self.commentId=commentId
        self.author=author
        self.timeCreated=timeCreated
        self.rating=rating
        self.text=text
        self.permalink=permalink
    }
}
