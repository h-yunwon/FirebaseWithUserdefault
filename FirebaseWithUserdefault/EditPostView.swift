//
//  EditPostView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

struct EditPostView: View {
    // MARK: - PROPERTY
    @ObservedObject var firebaseVM : FirebaseViewModel
    @State private var nickName: String = ""
    @State private var contents: String = ""
    @Binding var isOnEditPostView: Bool

    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("내 이름")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity ,alignment: .leading)
            TextField("Enter your Name", text: $firebaseVM.nickName) {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(
                Color(.gray)
                    .opacity(0.2)
            )
            .cornerRadius(5)
            
            Text("내 정보")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity ,alignment: .leading)
            TextField("Please fill out the contents", text: $firebaseVM.contents) {
                
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(
                Color(.gray)
                    .opacity(0.1)
            )
            .cornerRadius(5)
            
            Button  {
                isOnEditPostView.toggle()
            } label: {
                Text("저장")
            }
        }
        .padding()
    }
}

struct EditPostView_Previews: PreviewProvider {
    @State static var selectedPost = PostInfo(id: UUID().uuidString, nickName: "yun", contents: "won")
    @State static var isOnEditPostView = false
    static var previews: some View {
        EditPostView(firebaseVM: FirebaseViewModel(), isOnEditPostView: $isOnEditPostView)
    }
}
