
import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationView {
            Color("PrimaryBlue").overlay(
                VStack {

                    Text("Cal Count")
                        .fontWeight(.bold)
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .padding(.bottom, 50)
                    

                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 50)
                            .foregroundColor(.black)
                            .font(.title)
                            .background(Color(red: 248/255, green: 249/255, blue: 250/250))
                    }
                    .cornerRadius(15)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 50)
                            .foregroundColor(.black)
                            .font(.title)
                            .background(Color.white)
                    }
                    .cornerRadius(15)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.top)
                }//Vstack
            )
            .edgesIgnoringSafeArea(.all)
        }//navigationView
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
