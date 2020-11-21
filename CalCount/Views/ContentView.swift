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
    @EnvironmentObject var waterManager: WaterManager
    
//    @State var decoded = UserDefaults.standard.object(forKey: "curUser") as! Data
//    @State var userObj = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! User

    
    var body: some View {
        VStack {
            // To switch between loggedIn and notLoggedIn views, have this environment variable to switch
            if self.status.loggedIn { //UserDefaults.standard.bool(forKey: "isUserLoggedIn")
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
//        .onAppear {
////            let isTheUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
////
//////            let decoded  = UserDefaults.standard.object(forKey: "curUser") as! Data
//////            let userObj = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! User
////
////            if isTheUserLoggedIn {
////                self.status.loggedIn = true
////
////                guard let currUser = UserDefaults.standard.object(forKey: "curUser") as? User else {return}
////                self.status.currentUser = currUser
////                self.foodManager.username = currUser.username
////                self.waterManager.username = currUser.username
////            }
//        }//onAppear
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
