//
//  ContentView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/12.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTY
    @ObservedObject var firebaseVM: FirebaseViewModel = FirebaseViewModel()
 
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack{
                List {
                    ForEach(firebaseVM.posts, id: \.self) { post in
                        NavigationLink {
                            ProfileDetailView(firebaseVM: firebaseVM, selectedPost: post)
                        } label: {
                            ListCellView(post: post, id: firebaseVM.id)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("프로필 리스트"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        
                        NavigationLink(destination: MyProfileView(firebaseVM: firebaseVM, myProfile:PostInfo(id: firebaseVM.id, nickName: firebaseVM.nickName, contents: firebaseVM.contents))) {
                            Image(systemName: "person.crop.circle")
                        }
                        .onAppear {
                            firebaseVM.loadPostInfo()
                        }
                    }
                }
            }
        }
        .onAppear {
            firebaseVM.listenToRealtimeDatabase()
        }
        .onDisappear {
            firebaseVM.stopListening()
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
