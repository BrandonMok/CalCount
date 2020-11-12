
import SwiftUI


/**
 * HomeView
 * The view that first shows when user logs in
 * This view acts as the FOOD view
 */
struct HomeView: View {
    
    /**
     * DO I really need the tabManager?
     * Bc it's only here that I change the tab by doing an onTapGesture
     *
     */
    @EnvironmentObject var tabManager: TabManager
    @EnvironmentObject var realmObject: RealmObject
    @EnvironmentObject var status: LoggedInStatus
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $tabManager.selectedTab) {

                    FoodView()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(Tabs.home)
                        .onTapGesture {
                            self.tabManager.selectedTab = Tabs.home
                        }
                    
                    Text("Tab stuff")
                        .tabItem {
                            Image(systemName: "drop")
                            Text("Water")
                        }
                        .tag(Tabs.water)
                        .onTapGesture {
                            self.tabManager.selectedTab = Tabs.water
                        }
                    
                    Text("Tab again")
                        .tabItem {
                            Image(systemName: "doc")
                            Text("Nutrition")
                        }
                        .tag(Tabs.nutrition)
                        .onTapGesture {
                            self.tabManager.selectedTab = Tabs.nutrition
                        }
                    
                    SettingsView()
                        .environmentObject(self.status)
                        .environmentObject(self.realmObject)
//                        .onTapGesture {
//                            self.tabManager.selectedTab = Tabs.settings
//                            print(self.tabManager.selectedTab)
//                        }
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
