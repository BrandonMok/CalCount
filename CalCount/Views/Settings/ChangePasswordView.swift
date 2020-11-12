
import SwiftUI
import RealmSwift
import CryptoKit

/**
 * ChangePasswordView
 * VIew under the settings tab that allows the user to change their password
 */
struct ChangePasswordView: View {
    
    // Reference: https://stackoverflow.com/questions/56571349/custom-back-button-for-navigationviews-navigation-bar-in-swiftui
    // Used to send user back to navigationview
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject private var status: LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject
    
    @State private var password = ""
    @State private var passwordAgain = ""
    
    // Alert state variables
    @State private var showAlert = false
    @State private var msgTitle = ""
    @State private var msg = ""
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Change password")
                .font(.largeTitle)
                .foregroundColor(Color("PrimaryBlue"))
                .bold()

            VStack {
                SecureField("Password", text: $password)
                    .padding()
                    .keyboardType(.alphabet)
                    .textContentType(.password)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
                
                SecureField("Password Again", text: $passwordAgain)
                    .padding()
                    .keyboardType(.alphabet)
                    .textContentType(.password)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
            }
            .padding(.top)
            .padding(.bottom)
            
            
            // Submit button
            Button(action: {
                // Make sure both password fields aren't empty
                if !password.isEmpty || !passwordAgain.isEmpty {
                    // make sure that the password is the same on both inputs
                    if password == passwordAgain {
                        
                        do {
                            let inputData = Data(password.utf8)
                            let password = SHA256.hash(data: inputData)
                            
                            let userObj = self.status.currentUser
                            
                            try realmObj.realm.write {
                                userObj.password = password.compactMap { String(format: "%02x", $0) }.joined()
                            }
                            
                            showAlert.toggle()
                            msgTitle = "Password changed!"
                            msg = "Password changed successfully!"
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                        
                    }
                    else {
                        showAlert.toggle()
                        msgTitle = "Couldn't change password"
                        msg = "Please make sure the entered password matches!"
                    }
                }
                else {
                    showAlert.toggle()
                    msgTitle = "Couldn't change password"
                    msg = "Please enter a new password!"
                }
            }, label: {
                Text("Submit")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: 20)
            })
            .padding()
            .background(Color("PrimaryBlue"))
            .cornerRadius(25)
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("\(msgTitle)"),
                      message: Text("\(msg)"),
                      dismissButton: .default(Text("Ok"), action: {
                        if msgTitle == "Password changed!" {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                      }))
            })
            
            Spacer()
            Spacer()
        }//vstack
        .padding()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
