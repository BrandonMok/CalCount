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
    
    @EnvironmentObject var foodManager: FoodManager
    
    
    var body: some View {
        VStack {
            // To switch between loggedIn and notLoggedIn views, have this environment variable to switch
            if self.status.loggedIn || UserDefaults.standard.bool(forKey: "isUserLoggedIn") {
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
        }//VSTack
        .onAppear {
            let loggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
            
            if loggedIn {
                self.status.loggedIn = true
                self.status.currentUser = UserDefaults.standard.object(forKey: "curUser") as? User ?? User()
                let theUser = UserDefaults.standard.object(forKey: "curUser") as? User ?? User()
                self.foodManager.username = theUser.username
            }
        }//onAppear
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
