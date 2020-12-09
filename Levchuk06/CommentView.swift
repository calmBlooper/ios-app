//
//  CommentView.swift
//  Levchuk09
//
//  Created by Admin on 29.11.2020.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var comment: Comment
    var body: some View {
        ScrollView (.vertical){
        VStack(alignment: .leading)  {
       CommentCellView(comment: comment)
            Spacer()
                .frame(height: 9, alignment: .center)
            Button(action:{
                guard let data = URL(string: "https://www.reddit.com\(comment.permalink)") else { return }
                let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
             
                UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true)
                print("Shared")
            }) {
                HStack {
                    Spacer()
                Text("Share")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.white)
                    .padding(.horizontal,0)
                    Spacer()
                }
                .frame(height: 55.0)
                .background(Color.blue)
            }
            Spacer()
        }
        
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(comment: cComment)
    }
}
