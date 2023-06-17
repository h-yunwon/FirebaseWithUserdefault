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
        ScrollView(showsIndicators: false) {
            NavigationView {
                LazyVStack{
                    Text("데이터베이스 변경사항: \(firebaseVM.changeCount)")
                    List {
                        ForEach(firebaseVM.posts, id: \.self) { post in
                            NavigationLink {
                                PostDetailView()
                            } label: {
                                ListCellView(post: post)
                            }
                        }
                    }
                    .navigationBarTitle(Text("유저 정보"))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: AddPostView(firebaseVM: firebaseVM)) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }
            }.onAppear {
                firebaseVM.listenToRealtimeDatabase()
            }
            .onDisappear {
                firebaseVM.stopListening()
            }
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
