//
//  SwiftUIView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

struct ListCellView: View {
    var post: PostInfo
    
    var body: some View {
        HStack{
            Text(post.nickName)
        }
    }
}

struct ListCellView_Previews: PreviewProvider {
    static var post: PostInfo = PostInfo(id: "0", nickName: "nick", contents: "good")
    static var previews: some View {
        ListCellView(post: post)
    }
}
