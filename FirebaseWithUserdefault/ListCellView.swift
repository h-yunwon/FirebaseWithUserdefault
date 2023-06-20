//
//  SwiftUIView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

struct ListCellView: View {
    let post: PostInfo
    let id: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack {
                Text(post.nickName)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.accentColor)
                
                if post.id == id {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                }
            }
            
            Text(post.contents)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineLimit(4)
                .padding(.trailing, 8)
        }
    }
}

struct ListCellView_Previews: PreviewProvider {
    static var post: PostInfo = PostInfo(id: "0", nickName: "nick", contents: "good")
    static let id = ""
    static var previews: some View {
        ListCellView(post: post, id: id)
    }
}
