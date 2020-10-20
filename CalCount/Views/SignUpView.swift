
import SwiftUI

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
                
                if password == passwordAgain {
                    
                }
                else {
                    // set error to true - error occurred
                    error = true
                    errorMsg = "Entered passwords do not match!"
                }
                
                
                // TODO - Create User() and store in Realm
               // var user = User(username: username, password: password, gender: gender)
//                realm.write {
//                    realm.add();
//                }
                
                
                
            }, label: {
                Text("Login")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
            })
            
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 20)
            .padding()
            .background(Color("PrimaryBlue"))
            .alert(isPresented: $error) {
                Alert(title: Text("Login failed!"),
                  message: Text(errorMsg),
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
