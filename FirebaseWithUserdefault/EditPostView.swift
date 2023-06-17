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


//struct DataInput: View {
//
//    var title: String
//    @Binding var userInput: String
//
//    var body: some View {
//        VStack(alignment: HorizontalAlignment.leading) {
//            Text(title)
//                .font(.headline)
//            TextField("Enter \(title)", text: $userInput)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//        }
//        .padding()
//    }
//}

//struct EditCarView: View {

//
//    var body: some View {
//        VStack {
//            DataInput(title: "Name", userInput: $selectedCar.name)
//            DataInput(title: "Description", userInput: $selectedCar.description)
//
//            Toggle(isOn: $selectedCar.isHybrid) {
//                Text("Hybrid").font(.headline)
//            }.padding()
//            Button  {
//                let editCar = Car(
//                    id: selectedCar.id,
//                    name: selectedCar.name,
//                    description: selectedCar.description,
//                    isHybrid: selectedCar.isHybrid
//                )
//                carStore.editCar(car: editCar)
//                self.mode.wrappedValue.dismiss()
//                isOnEditCarView.toggle()
//            } label: {
//                Text("확인")
//            }
//        }
//    }
//}

struct EditPostView_Previews: PreviewProvider {
    @State static var selectedPost = PostInfo(id: UUID().uuidString, nickName: "yun", contents: "won")
    @State static var isOnEditPostView = false
    static var previews: some View {
        EditPostView(firebaseVM: FirebaseViewModel(), selectedPost: $selectedPost, isOnEditPostView: $isOnEditPostView)
    }
}
