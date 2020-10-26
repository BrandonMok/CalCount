
import SwiftUI
import RealmSwift
import CryptoKit

struct ChangePasswordView: View {
    
    @EnvironmentObject private var status: LoggedInStatus
    
    @State private var password = ""
    @State private var passwordAgain = ""
    
    @State private var showAlert = false
    @State private var msgTitle = ""
    @State private var msg = ""
    
    
    var body: some View {
        VStack {
            Text("Change password")
                .font(.largeTitle)
                .foregroundColor(Color("PrimaryBlue"))
                .fontWeight(.bold)

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
            
            
            Button(action: {
                if !password.isEmpty || !passwordAgain.isEmpty {
                    if password == passwordAgain {
                        
                        do {
                            let realm = try Realm()
                            
                            
                            let inputData = Data(password.utf8)
                            let password = SHA256.hash(data: inputData)
                            
                            var userObj = self.status.currentUser

                            try realm.write {
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
                      dismissButton:  .default(Text("Ok")))
            })
        }//vstack
        .padding()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
