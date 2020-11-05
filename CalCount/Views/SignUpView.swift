
import SwiftUI
import CryptoKit
import RealmSwift

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var realmObj: RealmObject
    
    @State private var username = ""
    @State private var password = ""
    @State private var passwordAgain = ""
    @State private var selectedGender = 0
    
    @State private var showAlert = false
    @State private var msgTitle = ""
    @State private var msg = ""
    
    var genders = ["Prefer not to say","Male", "Female"]
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .keyboardType(.alphabet)
                .textContentType(.username)
                .foregroundColor(.black)
                .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                .cornerRadius(5.0)
            
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
            

            
            VStack {
                Picker(selection: $selectedGender, label: Text("Select your gender")) {
                    ForEach(0 ..< genders.count) { index in
                        Text(self.genders[index])
                    }
                }
                
                Text("**The selection of a gender is voluntary. Gender is only used to create base settings (i.e. typical calories per day). If no gender is selected, you can simply set all user settings later.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            .padding()
            
            
            Button(action: {
                // Create User(), check input, store in Realm
                if !username.isEmpty || !password.isEmpty || !passwordAgain.isEmpty {
                    // Make sure passwords match
                    if password == passwordAgain {
                        // Hash password to store
                        let inputData = Data(password.utf8)
                        let password = SHA256.hash(data: inputData)
                        
                        // First check if they aren't already signed up!
                        let existentUser = realmObj.realm.objects(User.self)
                            .filter("username = %@ AND password = %@", username, password.compactMap { String(format: "%02x", $0) }.joined())
                        
                        
                        // if no user found, error
                        if existentUser.count > 0 {
                            showAlert.toggle()
                            msgTitle = "Signup Failed!"
                            msg = "You're already registered!"
                        }
                        else {
                            // Object to save
                            // NOTE: Realm doens't seem to allow to pass all as parameters when creating!
                            let user = User()
                            user.username = username
                            user.password = password.compactMap { String(format: "%02x", $0) }.joined()
                            user.gender = genders[selectedGender]

                            // Write user to realm
                            try! realmObj.realm.write {
                                realmObj.realm.add(user)
                            }
                            
                            
                            showAlert.toggle()
                            msgTitle = "Signup Successful!"
                            msg = "Thanks for joining!"
                        }
                    }
                    else {
                        showAlert.toggle()
                        msgTitle = "Signup Failed!"
                        msg = "Entered passwords do not match!"
                    }
                }
                else {
                    showAlert.toggle()
                    msgTitle = "Signup Failed!"
                    msg = "Please enter input for all fields!"
                }
            }, label: {
                Text("Submit")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20)
            })
            .padding()
            .background(Color("PrimaryBlue"))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("\(msgTitle)"),
                  message: Text("\(msg)"),
                  dismissButton: .default(Text("Ok"), action: {
                    if msgTitle == "Signup Successful!" {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                  }))
            }

            .cornerRadius(25)
            
            
            Spacer()
        }//VStack
        .padding()
        
    }//body
}//contentview

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
