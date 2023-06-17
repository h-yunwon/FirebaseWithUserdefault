//
//  writingView.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/13.
//

import SwiftUI

struct WritingView: View {
    

struct WritingView_Previews: PreviewProvider {
    @State static var nickName = ""
    @State static var contents = ""
    
    static var previews: some View {
        WritingView(nickName: $nickName, contents: $contents)
    }
}
