//
//  ContentView.swift
//  CalCount
//
//  Created by Brandon MOk on 2020-10-05.
//

import SwiftUI

struct ContentView: View {
    
    @State private var loggedIn = false;
    
    var body: some View {
        if loggedIn {
            // logged in view
            
        }
        else {
            LandingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
