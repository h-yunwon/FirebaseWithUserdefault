//
//  AddPostView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

struct AddPostView: View {
    
    // MARK: - PROPERTY
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var firebaseVM: FirebaseViewModel
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 10) {
                Text("내 이름")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                Text(firebaseVM.nickName)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(
                    Color(.gray)
                        .opacity(0.2)
                )
                .cornerRadius(5)
                .padding(.bottom, 20)
                
                Text("내 정보")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                Text(firebaseVM.contents)
                .lineLimit(4)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .background(
                    Color(.gray)
                        .opacity(0.1)
                )
                .cornerRadius(5)
                
                Button(action: {
                    firebaseVM.addPost(post: PostInfo(id: UUID().uuidString, nickName: firebaseVM.nickName, contents: firebaseVM.contents))
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text("업로드")
                        }
                    }
            }
            .padding()
        }
        .navigationTitle("내 정보")
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink(destination: EditPostView(), label: {
//                    Text("Edit")
//                })
//            }
//        }
    }
}

struct AddPostView_Previews: PreviewProvider {

    static var previews: some View {
        AddPostView(firebaseVM: FirebaseViewModel())
    }
}
