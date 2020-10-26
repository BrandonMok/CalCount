
import SwiftUI

// enum for tab navigation
enum Tabs: Hashable {
    case home
    case water
    case nutrition
    case settings
}

struct HomeView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                
                // TEMP - REplace with view instead of Text!
                Text("Tab Content 1")
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(Tabs.home)
                
                Text("Tab stuff")
                    .tabItem {
                        Image(systemName: "drop")
                        Text("Water")
                    }
                    .tag(Tabs.water)
                
                Text("Tab again")
                    .tabItem {
                        Image(systemName: "doc.on.clipboard")
                        Text("Nutrition")
                    }
                    .tag(Tabs.nutrition)

                
                Text("Tab Content 2")
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
                    .tag(Tabs.settings)
            }//tabview
        }//vstack
    }//body
}//struct

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
