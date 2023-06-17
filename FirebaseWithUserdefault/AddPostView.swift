//
//  AddPostView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

struct AddPostView: View {
    
    // MARK: - PROPERTY
    @ObservedObject var firebaseVM: FirebaseViewModel
    
    @State private var nickName: String = ""
    @State private var contents: String = ""
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            TextField("Enter your Name", text: $nickName) {

            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(
                Color(.gray)
                    .opacity(0.2)
            )
            .cornerRadius(5)
            
            TextField("Please fill out the contents", text: $contents) {

            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(
                Color(.gray)
                    .opacity(0.1)
            )
            .cornerRadius(5)
            
            Button(action: {
                firebaseVM.addPost(post: PostInfo(id: UUID().uuidString, nickName: nickName, contents: contents))
            }) {
                HStack {
                    Text("저장")
                }
            }
        }
        .padding()
    }
}

struct AddPostView_Previews: PreviewProvider {

    static var previews: some View {
        AddPostView(firebaseVM: FirebaseViewModel())
    }
}
