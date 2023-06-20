//
//  PostDetailView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

struct ProfileDetailView: View {
    // MARK: - PROPERTY
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var firebaseVM: FirebaseViewModel
    @State private var isOnEditPostView: Bool = false
    @State var selectedPost: PostInfo
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("이름")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity ,alignment: .leading)
            Text(selectedPost.nickName)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(
                Color(.gray)
                    .opacity(0.2)
            )
            .cornerRadius(5)
            .padding(.bottom, 20)
            
            Text("정보")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity ,alignment: .leading)
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
                    EditProfileView(firebaseVM: firebaseVM)
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

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(firebaseVM: FirebaseViewModel(), selectedPost: PostInfo(id: UUID().uuidString, nickName: "yun", contents: "won"))
    }
}
