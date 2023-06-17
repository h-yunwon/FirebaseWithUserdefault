//
//  File.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/17.
//

import Foundation

struct PostInfo: Codable, Identifiable, Hashable {
    var id: String
    var nickName: String
    var contents: String
}

