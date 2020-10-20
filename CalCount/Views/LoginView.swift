
import SwiftUI
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
                // TODO - Check with coredata!
                // if login fails, set error = true
//                error = true
                
            }, label: {
                Text("Login")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.bold)
            })
            
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 20)
            .padding()
            .background(Color("PrimaryBlue"))
            .alert(isPresented: $error) {
                Alert(title: Text("Login failed!"),
                  message: Text("Please make sure that the username and password entered are valid!"),
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
