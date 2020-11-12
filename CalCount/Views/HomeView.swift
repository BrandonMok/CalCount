
import SwiftUI


/**
 * HomeView
 * The view that first shows when user logs in
 * This view acts as the FOOD view
 */
struct HomeView: View {
    
    @EnvironmentObject var tabManager: TabManager
    @EnvironmentObject var realmObject: RealmObject
    @EnvironmentObject var status: LoggedInStatus
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $tabManager.selectedTab) {

                    FoodView()
                        .environmentObject(self.status)
                        .environmentObject(self.realmObject)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(Tabs.home)
                    
                    Text("Tab stuff")
                        .environmentObject(self.status)
                        .environmentObject(self.realmObject)
                        .tabItem {
                            Image(systemName: "drop")
                            Text("Water")
                        }
                        .tag(Tabs.water)
                    
                    Text("Tab again")
                        .environmentObject(self.status)
                        .environmentObject(self.realmObject)
                        .tabItem {
                            Image(systemName: "doc")
                            Text("Nutrition")
                        }
                        .tag(Tabs.nutrition)
                    
                    SettingsView()
                        .environmentObject(self.status)
                        .environmentObject(self.realmObject)
                        .tabItem {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                        .tag(Tabs.settings)

                }//tabview
            }//vstack
            

            // Only show the FAB on the home/food and water tabs!
            if tabManager.selectedTab == Tabs.home || tabManager.selectedTab == Tabs.water {
                // FAB
                FloatingMenu()
            }
        }//ZStack
    }//body
}//struct

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
