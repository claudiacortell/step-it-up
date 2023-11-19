//
//  FetchTestView.swift
//  HealthComp
//
//  Created by Claudia Cortell on 11/18/23.
//

import SwiftUI




struct FetchTestView: View {
    @EnvironmentObject var friendvm: FriendVM
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).onAppear{
            let testFriends = ["KBkokjN0ahUHhYC27PWTZg0NiPD2"]
            Task {
//                do {
                    let result = await friendvm.fetchFriends(friend_ids: testFriends)
//                    let result = try await friendvm.fetchHealthData(id: user_id)
                print(friendvm.user_friends)
//                    switch result {
//                    case .success(let friend):
//                        print(friend)
//                    case .failure(let error):
//                        print(error)
//                    }
//                } catch {
//                    print("Error fetching user friends, Error: \(error)")
//                }
            }
        }
    }
}

#Preview {
    FetchTestView()
}
