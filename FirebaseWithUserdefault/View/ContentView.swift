//
//  ContentView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/12.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTY
    @State private var nickName: String = ""
    @State private var contents: String = ""
    @State private var isPresented: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack {
            Button(action: {
                isPresented = true
            }) {
                Text("작성하기")
            }
            .sheet(isPresented: $isPresented, content: {
                WritingView(nickName: $nickName, contents: $contents)
            })
        }
        .padding()
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
