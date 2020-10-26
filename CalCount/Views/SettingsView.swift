
import SwiftUI

struct SettingsView: View {
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
            }
        } // navigationView
    }// body
}//struct

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
