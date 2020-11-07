
import SwiftUI


struct HomeView: View {
    @ObservedObject var tabManager = TabManager()
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $tabManager.selectedTab) {

                    CalorieView()
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
                            Image(systemName: "doc")
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
            

            // FAB
            FloatingMenu()

        }//ZStack
    }//body
}//struct

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
