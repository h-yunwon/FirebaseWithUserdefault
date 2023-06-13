//
//  writingView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/13.
//

import SwiftUI

struct WritingView: View {
    @Binding var nickName: String
    @Binding var contents: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            TextField("닉네임", text: $nickName) {

            }

            TextField("내용", text: $contents) {

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
