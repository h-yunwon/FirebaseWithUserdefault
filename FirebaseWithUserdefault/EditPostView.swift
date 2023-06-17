//
//  EditPostView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

struct EditPostView: View {
    // MARK: - PROPERTY
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var firebaseVM : FirebaseViewModel
    @State private var nickName: String = ""
    @State private var contents: String = ""
    @Binding var selectedPost: PostInfo
    @Binding var isOnEditPostView: Bool

    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            TextField("Enter your Name", text: $selectedPost.nickName) {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(
                Color(.gray)
                    .opacity(0.2)
            )
            .cornerRadius(5)
            
            TextField("Please fill out the contents", text: $selectedPost.contents) {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(
                Color(.gray)
                    .opacity(0.1)
            )
            .cornerRadius(5)
            
            Button  {
                let editPost = PostInfo(
                    id: selectedPost.id,
                    nickName: selectedPost.nickName,
                    contents: selectedPost.contents
                )
                firebaseVM.editPost(post: editPost)
                self.mode.wrappedValue.dismiss()
                isOnEditPostView.toggle()
            } label: {
                Text("확인")
            }
        }
        .padding()
    }
}

struct EditPostView_Previews: PreviewProvider {
    @State static var selectedPost = PostInfo(id: UUID().uuidString, nickName: "yun", contents: "won")
    @State static var isOnEditPostView = false
    static var previews: some View {
        EditPostView(firebaseVM: FirebaseViewModel(), selectedPost: $selectedPost, isOnEditPostView: $isOnEditPostView)
    }
}
