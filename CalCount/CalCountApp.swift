//
//  CalCountApp.swift
//  CalCount
//
//  Created by XCodeClub on 2020-10-05.
//

import SwiftUI

@main
struct CalCountApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LoggedInStatus())
                .environmentObject(RealmObject())
                .environmentObject(ModalManager())
                .environmentObject(TabManager())
        }
    }
}
