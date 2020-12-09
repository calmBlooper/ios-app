//
//  CommentCellView.swift
//  Levchuk09
//
//  Created by Admin on 29.11.2020.
//

import SwiftUI

struct CommentCellView: View {
    @ObservedObject var comment: Comment

    var body: some View {
      
        VStack(alignment: .leading){
            HStack {
                Text("u/"+comment.author)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                    .frame(width: 5)
                Text("\(   (Calendar.current.dateComponents([.hour], from: NSDate(timeIntervalSince1970:self.comment.timeCreated) as Date, to: NSDate() as Date).hour!))h")
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
            }
            Spacer()
                .frame(height: 3, alignment: .center)
            Text(comment.text)
                .lineLimit(nil)
            Spacer()
                .frame(height: 7, alignment: .center)
            Button(action:{print("Sadly, you can`t upvote yet")
            }) {
                HStack {
                Image(systemName: "arrow.up")
                Text("\(comment.rating)")
                .font(.footnote)
                .fontWeight(.semibold)
                }

     
            
            
        }
        .padding(.leading, 9.0)
        .padding(.trailing, 9.0)
        }
    }
}

struct CommentCellView_Previews: PreviewProvider {
    static var previews: some View {
        CommentCellView(comment: cComment)
    }
}
