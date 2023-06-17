//
//  SwiftUIView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

struct ListCellView: View {
    let post: PostInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(post.nickName)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.accentColor)
            
            
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
    static var previews: some View {
        ListCellView(post: post)
    }
}
