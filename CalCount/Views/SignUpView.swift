
import SwiftUI
import CryptoKit
import RealmSwift

struct SignUpView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var passwordAgain = ""
    @State private var gender = ""
    @State private var error = false
    @State private var errorMsg = ""
    
    let genders = ["Prefer not to say","Male", "Female"]
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .keyboardType(.alphabet)
                .textContentType(.username)
                .foregroundColor(.black)
                .border(Color.black)
                .cornerRadius(5.0)
            
            TextField("Password", text: $password)
                .padding()
                .keyboardType(.alphabet)
                .textContentType(.password)
                .border(Color.black)
                .cornerRadius(5.0)
            
            TextField("Password Again", text: $passwordAgain)
                .padding()
                .keyboardType(.alphabet)
                .textContentType(.password)
                .border(Color.black)
                .cornerRadius(5.0)
            

            
            VStack {
                Picker(selection: $gender, label:
                        Text("Select your gender")) {
                            ForEach(0 ..< genders.count) { index in
                                Text(self.genders[index])
                            }
                        }
                
                Text("**The selection of a gender is voluntary. Gender is only utilized to create base settings for the account (i.e. typical calories per day). If no gender is selected, you can simply set all user settings later.")
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
                        
                        let realm = try! Realm()
                        
                        // Object to save
                        // NOTE: Realm doens't seem to allow to pass all as parameters when creating!
                        var user = User()
                        user.username = username
                        user.password = password.compactMap { String(format: "%02x", $0) }.joined()
                        user.gender = gender

                        // Write user to realm
                        try! realm.write {
                            realm.add(user)
                        }                
                    }
                    else {
                        // set error to true - error occurred
                        error = true
                        errorMsg = "Entered passwords do not match!"
                    }
                }
                else {
                    error = true
                    errorMsg = "Please enter input for all fields!"
                }
            }, label: {
                Text("Submit")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
            })
            
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 20)
            .padding()
            .background(Color("PrimaryBlue"))
            .alert(isPresented: $error) {
                Alert(title: Text("Login failed!"),
                  message: Text("\(errorMsg)"),
                  dismissButton: .default(Text("Ok"), action: {
                    username = ""
                    password = ""
                    passwordAgain = ""
                  }))
            }
            
            
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
