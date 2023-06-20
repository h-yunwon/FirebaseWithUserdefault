//
//  EditPostView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import SwiftUI

struct EditProfileView: View {
    // MARK: - PROPERTY
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var firebaseVM : FirebaseViewModel
    
    // MARK: - FUNCTION
    
    func saveEditPost() {
        if firebaseVM.id.isEmpty {
            firebaseVM.id = UUID().uuidString
        }
        
        let editInfo = PostInfo(
            id: firebaseVM.id,
            nickName: firebaseVM.nickName,
            contents: firebaseVM.contents
        )
        
        firebaseVM.savePostInfo(myInfo: editInfo)
        self.mode.wrappedValue.dismiss()
    }

    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("내 이름")
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity ,alignment: .leading)
            TextField("Enter your Name", text: $firebaseVM.nickName)
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
            TextField("Please fill out the contents", text: $firebaseVM.contents)
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(
                Color(.gray)
                    .opacity(0.1)
            )
            .cornerRadius(5)
            
            Button  {
                saveEditPost()
            } label: {
                Text("저장")
            }
        }
        .padding()
    }
}

struct EditProfileView_Previews: PreviewProvider {

    static var previews: some View {
        EditProfileView(firebaseVM: FirebaseViewModel())
    }
}
