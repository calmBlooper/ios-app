//
//  ContentView.swift
//  Levchuk09
//
//  Created by Admin on 29.11.2020.
//

import SwiftUI



struct ContentView: View {
    let subreddit:String
    let postId: String
    @State var comments=Array(repeating: cComment, count:0)
    var body: some View {
        NavigationView {
        List(comments){ comment in
            NavigationLink(destination: CommentView(comment: comment)) {
        CommentCellView(comment: comment)
            }
        }
        .navigationBarTitle(Text("Comments"))
        .navigationBarHidden(true)
        }
        .onAppear(perform: {
            useCase.fetchComments(subreddit: self.subreddit, postId: self.postId, onCompletion: updateComments(_:))
        })
    }
    func updateComments(_ receivedComments:CommentsResponse){
       comments=receivedComments.comments
        print(comments.count)
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(subreddit: "EarthPorn", postId: "k2nxuv")
    }
}
