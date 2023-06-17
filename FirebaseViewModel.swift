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
    @Published var posts: [PostInfo] = []
    @Published var nickName: String = ""
    @Published var contents: String = ""
    @Published var changeCount: Int = 0
    
    let ref: DatabaseReference? = Database.database().reference()
    
    private var encoder = JSONEncoder()
    private var decoder = JSONDecoder()
    
    // MARK: - FUNCTION
    
    func listenToRealtimeDatabase() {
        guard let databasePath = ref?.child("posts") else {
            return
        }
        
        databasePath.observe(.childAdded) { [weak self] snapshot in
            guard let self = self, let json = snapshot.value as? [String: Any] else {
                return
            }
            
            do {
                let postData = try JSONSerialization.data(withJSONObject: json)
                let post = try self.decoder.decode(PostInfo.self, from: postData)
                DispatchQueue.main.async {
                    self.posts.append(post)
                }
            } catch {
                print("An error occurred - childAdded", error)
            }
        }
        
        databasePath.observe(.childChanged) { [weak self] snapshot in
            guard let self = self, let json = snapshot.value as? [String: Any] else {
                return
            }
            
            do {
                let postData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let post = try self.decoder.decode(PostInfo.self, from: postData)
                
                if let index = self.posts.firstIndex(where: { $0.id == post.id }) {
                    DispatchQueue.main.async {
                        self.posts[index] = post
                    }
                }
            } catch {
                print("An error occurred - childChanged", error)
            }
        }
        
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
        
        databasePath.observe(.value) { [weak self] _ in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.changeCount += 1
            }
        }
    }
    
    func stopListening() {
        ref?.removeAllObservers()
    }
    
    func addPost(post: PostInfo) {
        self.ref?.child("posts").child("\(post.id)").setValue([
            "id": post.id,
            "nickName": post.nickName,
            "contents": post.contents
        ])
    }
    
    func deletePost(key: String) {
        ref?.child("posts/\(key)").removeValue()
    }
    
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
