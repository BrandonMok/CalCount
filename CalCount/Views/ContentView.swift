//
//  ContentView.swift
//  CalCount
//
//  Created by Brandon MOk on 2020-10-05.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var tabManager: TabManager
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObject: RealmObject
    
    
    var body: some View {
        // To switch between loggedIn and notLoggedIn views, have this environment variable to switch
        if status.loggedIn {
            // Logged in view
            HomeView()
                .transition(.opacity)
                .environmentObject(self.status)
                .environmentObject(self.realmObject)
                .environmentObject(self.tabManager)
        }
        else {
            // Not logged in!
            LandingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
