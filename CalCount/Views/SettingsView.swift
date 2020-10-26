
import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var status: LoggedInStatus
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account")
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)){
                        NavigationLink(destination: ChangePasswordView()) {
                                Text("Change password")
                        }
                }
                
//                Section(header: Text("Goals")
//                            .fontWeight(.heavy)
//                            .foregroundColor(.blue)){
//                        NavigationLink(destination: ()) {
//                                Text("Manager goals")
//                        }
//                }
//
//
//                Section(header: Text("Data")
//                            .fontWeight(.heavy)
//                            .foregroundColor(.blue)){
//                        NavigationLink(destination: ()) {
//                                Text("Manage your data")
//                        }
//                }
                
                
                Section(){
                    Button(action: {
                        // logout
                        self.status.loggedIn = false
                        self.status.currentUser = User()
                    }, label: {
                        Text("Logout")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20)
                    })
                    .padding()
                    .background(Color("PrimaryBlue"))
                }
            }
        } // navigationView
    }// body
}//struct

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(LoggedInStatus())
    }
}
