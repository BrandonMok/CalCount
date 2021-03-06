
import SwiftUI
import CryptoKit
import RealmSwift

/**
 * LoginView
 * View displayed to allow the user to login into the application
 */
struct LoginView: View {
    
    // EnvironmentObjects necessary for the application
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject
    
    @EnvironmentObject var foodManager: FoodManager
    @EnvironmentObject var waterManager: WaterManager
    
    // Login State Variables
    @State private var username = ""
    @State private var password = ""
    @State private var error = false

    @State private var phidden = false
    @State private var userFound = false
    
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .keyboardType(.alphabet)
                .textContentType(.username)
                .foregroundColor(.black)
                .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(5.0)
            
            ZStack {
                HStack {
                    // Hiding/toggling of either showing the password or hiding it based on tapping an image
                    // source: https://www.youtube.com/watch?v=84uwH4DVPJg&ab_channel=AppDesigner2
                    if phidden {
                        TextField("Password", text: $password)
                            .padding()
                            .keyboardType(.alphabet)
                            .textContentType(.password)
                            .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                            .cornerRadius(5.0)
                    }
                    else {
                        SecureField("Password", text: $password)
                            .padding()
                            .keyboardType(.alphabet)
                            .textContentType(.password)
                            .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                            .cornerRadius(5.0)
                    }
                    
                    Button(action: {
                        self.phidden.toggle()
                    }, label: {
                        Image(systemName: self.phidden ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(self.phidden ? Color.blue : Color.secondary)
                    })
                    
                }
            }.padding(.bottom , 15)
            
            
            // Login Button
            Button(action: {
                if !username.isEmpty || !password.isEmpty {
                    let inputData = Data(password.utf8)
                    let hash = SHA256.hash(data: inputData)
                    let password = hash.compactMap { String(format: "%02x", $0) }.joined()
                
                    let user = realmObj.realm.objects(User.self)
                        .filter("username = %@ AND password = %@", username, password)
                    
                    if user.count == 0 {
                        error = true
                    }
                    else {
                        self.status.loggedIn = true
                        self.status.currentUser = user.first!
                        self.foodManager.username = user.first!.username    // store username for foodManger! - Had issues with trying to use username from LoggedInStatus so had to do it this way
                        self.waterManager.username = user.first!.username
                        
                        
//                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
//                        
//                        
//                        let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: self.status.currentUser, requiringSecureCoding: false)
//                        
//                        UserDefaults.standard.set(encodedData, forKey: "curUser")
////                        UserDefaults.standard.set(self.status.currentUser, forKey: "curUser")
//                        
//                        
//                        
//                        UserDefaults.standard.synchronize()
                    }
                }
                else {
                    error = true
                }
                
            }, label: {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20)
            })
            .padding()
            .background(Color("PrimaryBlue"))
            .alert(isPresented: $error) {
                Alert(title: Text("Login failed!"),
                  message: Text("Please enter a valid username/password!"),
                  dismissButton: .default(Text("Ok"), action: {}))
            }
            .cornerRadius(25)
            
            
            Spacer()
        }//VStack
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
