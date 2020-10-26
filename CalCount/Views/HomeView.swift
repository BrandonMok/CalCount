
import SwiftUI


struct HomeView: View {
//    @EnvironmentObject var selectedTab: TabManager
    
    // TEMP
    @State var selectedTab = Tabs.home
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {

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
                
                SettingsView()
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
        HomeView().environmentObject(TabManager())
    }
}
