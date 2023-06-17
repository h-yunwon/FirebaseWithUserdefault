//
//  PostDetailView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

@available(iOS 15.0, *)
struct PostDetailView: View {
    // MARK: - PROPERTY
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var firebaseVM: FirebaseViewModel
    @State private var isOnEditPostView: Bool = false
    @State var selectedPost: PostInfo
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(selectedPost.nickName)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(
                Color(.gray)
                    .opacity(0.2)
            )
            .cornerRadius(5)
            
            Text(selectedPost.contents)
            .lineLimit(4)
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(
                Color(.gray)
                    .opacity(0.1)
            )
            .cornerRadius(5)
            
            HStack {
                NavigationLink("수정", destination: {
                    EditPostView(firebaseVM: firebaseVM, selectedPost: $selectedPost, isOnEditPostView: $isOnEditPostView)
                })
                
                Button(action: {
                    firebaseVM.deletePost(key: selectedPost.id)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text("삭제")
                    }
                }
            }
        }
        .padding()
    }
}

@available(iOS 15.0, *)
struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(firebaseVM: FirebaseViewModel(), selectedPost: PostInfo(id: UUID().uuidString, nickName: "yun", contents: "won"))
    }
}
