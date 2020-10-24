
import SwiftUI
import CryptoKit
import RealmSwift

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var error = false
    
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
            
            Button(action: {
                if !username.isEmpty || !password.isEmpty {
                    let inputData = Data(password.utf8)
                    let hash = SHA256.hash(data: inputData)
                    let password = hash.compactMap { String(format: "%02x", $0) }.joined()
                    
                    let realm = try! Realm()
                    
                    let user = realm.objects(User.self)
                        .filter("username = %@ AND password = %@", username, password)

                    
                    if user.count == 0 {
                        error = true
                    }
                }
                else {
                    error = true
                }
                
            }, label: {
                Text("Login")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: 20)
            })
            .padding()
            .background(Color("PrimaryBlue"))
            .alert(isPresented: $error) {
                Alert(title: Text("Login failed!"),
                  message: Text("Please enter a valid username/password!"),
                  dismissButton: .default(Text("Ok"), action: {
                    // Set values in the textfields back to ""
                    username = ""
                    password = ""
                  }))
            }
            
            
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
