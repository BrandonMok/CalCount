//
//  ContentView.swift
//  CalCount
//
//  Created by Brandon MOk on 2020-10-05.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var status: LoggedInStatus
    
    var body: some View {
        if status.loggedIn {
            // logged in view
            HomeView().transition(.opacity)
        }
        else {
            LandingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LoggedInStatus()).environmentObject(TabManager())
    }
}
