
import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationView {
            Color("PrimaryBlue").overlay(
                VStack {
                    Image("logo")

                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 50)
                            .padding(2)
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .background(Color.white)
                    }
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 50)
                            .padding(2)
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .background(Color.white)
                    }
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
