
import SwiftUI

/**
 * SettingsView
 * View for the settings tab that allows for administrative account actions
 */
struct SettingsView: View {
    
    // EnvironmentObjects necessary for the application
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObject: RealmObject
    
    @EnvironmentObject var foodManager: FoodManager
    @EnvironmentObject var waterManager: WaterManager
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)){
                    NavigationLink(destination:
                                    ChangePasswordView()
                                    .environmentObject(self.status)
                                    .environmentObject(self.realmObject)
                    
                    ) {
                            Text("Change password")
                    }
                    
                    NavigationLink(destination: ChangeAccountGenderView()) {
                            Text("Change account gender")
                    }
                }
                
                Section(header: Text("Goals")
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)){
                        NavigationLink(destination: GoalView()) {
                                Text("Manage goals")
                        }
                }


//                Section(header: Text("Data")
//                            .fontWeight(.heavy)
//                            .foregroundColor(.blue)){
//                        NavigationLink(destination: ()) {
//                                Text("Manage your data")
//                        }
//                }
                
                
                // Logout Section
                Section(){
                    Button(action: {
                        // logout
                        self.status.loggedIn = false
                        self.status.currentUser = User()
                        
                        // clear all foodManager info
                        self.foodManager.foodsList = []
                        self.foodManager.foodsListCopy = []
                        
                        // clear all waterManager info
                        self.waterManager.waterList = []
                        self.waterManager.totalConsumed = 0
                        self.waterManager.username = ""
                        
                    
                        
//                        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
//                        UserDefaults.standard.set(nil, forKey: "curUser")
//                        UserDefaults.standard.synchronize()

                    }, label: {
                        Text("Logout")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 20)
                    })
                    .padding()
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(15)
                }
            }
            .navigationBarTitle("Settings")
        } // navigationView        
        
    }// body
}//struct

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
