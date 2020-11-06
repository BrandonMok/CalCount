
import SwiftUI


struct HomeView: View {
    @ObservedObject var tabManager = TabManager()
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $tabManager.selectedTab) {

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
            
            
            VStack {
                FloatingMenu()
                    .padding(.bottom, 20)
                
//                Spacer()
//                HStack {
//                    Button(action: {
//                        // TODO - show items (add food, add water icons)
//
//
//                    }, label: {
//                        Image(systemName: "plus")       // maybe on click, change this to an X
//                        .font(.system(.title))
//                        .frame(width: 77, height: 70)
//                        .foregroundColor(Color.white)
//                    })
//                    .background(Color("PrimaryBlue"))
//                    .cornerRadius(38.5)
//                    .padding(.bottom, 20)
//                    .shadow(color: Color.black.opacity(0.3),
//                            radius: 3,
//                            x: 3,
//                            y: 3)
//                }
            }
            
        }//ZStack
    }//body
}//struct

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
