//
//  ContentView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userModel: UserVM
    
    var body: some View {
        Group {
            if userModel.userSession != nil {
                BaseView()
            } else {
                StartupView()
            }
        }.onAppear {
            userModel.checkUserSession()
        }
    }
}

