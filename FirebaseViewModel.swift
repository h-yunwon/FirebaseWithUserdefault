//
//  FirebaseViewModel.swift
//  FirebaseWithUserdefault
//
//  Created by Yunwon Han on 2023/06/16.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

class FirebaseViewModel: ObservableObject {
    // MARK: - PROPERTY
    
    // 변경 사항을 감지하기 위해 사용되는 Published 프로퍼티들
    @Published var posts: [PostInfo] = []  // 게시물 배열
    @Published var nickName: String = "Test nickname"  // 닉네임
    @Published var contents: String = "Text contents"  // 내용
    @Published var id:String = "" // 고유 아이디
    
    let ref: DatabaseReference? = Database.database().reference()  // Firebase Realtime Database에 대한 경로 참조
    
    private var encoder = JSONEncoder()  // JSON 데이터를 인코딩하기 위한 JSON 인코더
    private var decoder = JSONDecoder()  // JSON 데이터를 디코딩하기 위한 JSON 디코더
    
    // MARK: - FUNCTION
    
    func savePostInfo(myInfo: PostInfo) {
        if let encoderData = try? encoder.encode(myInfo) {
            UserDefaults.standard.set(encoderData, forKey: "MyInfo")
        }
    }
    
    func loadPostInfo() {
        if let encoderData = UserDefaults.standard.data(forKey: "MyInfo"),
            let myInfo = try? decoder.decode(PostInfo.self, from: encoderData) {
            id = myInfo.id
            nickName = myInfo.nickName
            contents = myInfo.contents
        }
    }
    
    func listenToRealtimeDatabase() {
        guard let databasePath = ref?.child("posts") else {
            return
        }
        
        // childAdded 이벤트를 관찰하여 새로 추가된 게시물을 받아옵니다.
        databasePath.observe(.childAdded) { [weak self] snapshot in
            guard let self = self, let json = snapshot.value as? [String: Any] else {
                return
            }
            
            do {
                // JSON 데이터를 PostInfo 객체로 변환합니다.
                let postData = try JSONSerialization.data(withJSONObject: json)
                let post = try self.decoder.decode(PostInfo.self, from: postData)
                
                // 게시물 배열을 메인 큐에서 업데이트합니다.
                DispatchQueue.main.async {
                    self.posts.append(post)
                }
            } catch {
                print("An error occurred - childAdded", error)
            }
        }
        
        // childChanged 이벤트를 관찰하여 게시물이 수정될 때 업데이트를 받아옵니다.
        databasePath.observe(.childChanged) { [weak self] snapshot in
            guard let self = self, let json = snapshot.value as? [String: Any] else {
                return
            }
            
            do {
                // JSON 데이터를 PostInfo 객체로 변환합니다.
                let postData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let post = try self.decoder.decode(PostInfo.self, from: postData)
                
                // 업데이트된 게시물의 인덱스를 게시물 배열에서 찾습니다.
                if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
                    // 게시물 배열을 메인 큐에서 업데이트합니다.
                    DispatchQueue.main.async {
                        self.posts[index] = post
                    }
                }
            } catch {
                print("An error occurred - childChanged", error)
            }
        }
        
        // childRemoved 이벤트를 관찰하여 게시물이 삭제될 때 업데이트를 받아옵니다.
        databasePath.observe(.childRemoved) { [weak self] snapshot in
            guard let self = self, let json = snapshot.value as? [String: Any] else {
                return
            }
            
            do {
                let postData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let post = try self.decoder.decode(PostInfo.self, from: postData)
                
                if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
                    DispatchQueue.main.async {
                        self.posts.remove(at: index)
                    }
                }
            } catch {
                print("An error occurred - childRemoved", error)
            }
        }
        
        // value 이벤트를 관찰하여 변경 횟수를 업데이트합니다.
//        databasePath.observe(.value) { [weak self] _ in
//            guard let self = self else {
//                return
//            }
//            // 변경 횟수를 메인 큐에서 업데이트합니다.
//            DispatchQueue.main.async {
//                self.changeCount += 1
//            }
//        }
    }
    
    // 데이터베이스 관찰을 중지합니다.
    func stopListening() {
        ref?.removeAllObservers()
    }
    
    // 게시물을 추가합니다.
    func addPost(post: PostInfo) {
        self.ref?.child("posts").child("\(post.id)").setValue([
            "id": post.id,
            "nickName": post.nickName,
            "contents": post.contents
        ])
    }
    
    // 게시물을 삭제합니다.
    func deletePost(key: String) {
        ref?.child("posts/\(key)").removeValue()
    }
    
    // 게시물을 수정합니다.
    func editPost(post: PostInfo) {
        let updates: [String: Any] = [
            "id": post.id,
            "nickName": post.nickName,
            "contents": post.contents
        ]
        
        let childUpdates = ["posts/\(post.id)": updates]
        
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index] = post
        }
        
        self.ref?.updateChildValues(childUpdates)
    }
}
