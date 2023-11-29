//
//  FeedVM.swift
//  HealthComp
//
//  Created by Phillip Le on 11/13/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage
import SwiftUI


class FeedVM: ObservableObject {
    var userModel: UserVM
    var friendModel: FriendVM
    let dateFormatter = DateFormatter()
    let imageUtil = ImageUtils()
    @Published var user_feed: [Post] = []
    
    init(userModel: UserVM, friendModel: FriendVM){
        self.userModel = userModel
        self.friendModel = friendModel
        self.dateFormatter.dateFormat = "yyy-MM-dd HH:mm:ss"
//        Task{
//            if let user = self.userModel.currentUser?.id{
//                if var user_ids = self.userModel.currentUser?.friends{
//                    user_ids.append(user)
//                    await fetchFeed(users: user_ids)
//                }
//            }
//        }
    }
    
    func sortPost(){
        self.user_feed.sort {$0.date_swift! < $1.date_swift!}
    }
    
    func makePost(id: String, caption: String, image: UIImage?) {
        do {
            let today_date = Date()
            let date_string = dateFormatter.string(from: today_date)
            let post_id = UUID().uuidString
            var data = Post(id: post_id, userId: id, date: date_string, likes: 0, caption: caption)
            let encoded_data = try Firestore.Encoder().encode(data)
            Firestore.firestore().collection("users").document(id).collection("posts").document(post_id).setData(encoded_data)
            data.date = nil
            data.date_swift = today_date
            self.user_feed.append(data)
            self.sortPost()
        } catch {
            print(error.localizedDescription)
        }
    }

    
    func fetchFeed(users: [String]) async {
        await withTaskGroup(of: [Post].self) { group in
            for user in users {
                group.addTask {
                    do {
                        let postsCollection = Firestore.firestore().collection("users").document(user).collection("posts")
                        let querySnapshot = try await postsCollection.getDocuments()
                        var userPosts: [Post] = []
                        for document in querySnapshot.documents {
                            if var post = try? document.data(as: Post.self) {
                                post.date_swift = self.dateFormatter.date(from: post.date!)
                                userPosts.append(post)
                            }
                        }

                        return userPosts
                    } catch {
                        print("Error: \(error.localizedDescription)")
                        return []
                    }
                }
            }

            for await userPosts in group {
                self.user_feed.append(contentsOf: userPosts)
            }
        }
        self.sortPost()
    }

    
}

