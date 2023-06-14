//
//  writingView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/13.
//

import SwiftUI

struct WritingView: View {
    
    // MARK: - PROPERTY
    @Binding var nickName: String
    @Binding var contents: String
    
    @State private var text: String = ""
    
    
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
                // save info
            }) {
                HStack {
                    Text("저장")
                }
            }
        }
        .padding()
    }
}

struct WritingView_Previews: PreviewProvider {
    @State static var nickName = ""
    @State static var contents = ""
    
    static var previews: some View {
        WritingView(nickName: $nickName, contents: $contents)
    }
}
