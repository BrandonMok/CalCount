
import SwiftUI
import RealmSwift
import CryptoKit

struct ChangeAccountGenderView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var status : LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject
    
    @State private var showAlert = false
    @State private var selectedGender = 0
    var gendersList = ["Prefer not to say","Male", "Female"]
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Change Account Gender")
                .font(.title)
                .foregroundColor(Color("PrimaryBlue"))
                .fontWeight(.bold)
            
            Text("**The selection of a gender is voluntary. Gender is only used to set a baseline of settings for the user. Gender is by no means distributed or used for any other means without your acknowledgement.")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            VStack {
                Picker(selection: $selectedGender, label: Text("Select your gender")) {
                    ForEach(0 ..< gendersList.count) { index in
                        Text(self.gendersList[index])
                    }
                }
                .onAppear(perform: {
                    if let index = gendersList.firstIndex(of: self.status.currentUser.gender) {
                                self.selectedGender = index
                        }
                })
            }
            .padding()
            
            
            Button(action: {
                // Update
                do {
                    let userObj = self.status.currentUser

                    try realmObj.realm.write {
                        userObj.gender = gendersList[selectedGender]
                    }

                    showAlert.toggle()
                }
                catch {
                    print(error.localizedDescription)
                }                
            }, label: {
                Text("Submit")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: 20)
            })
            .padding()
            .background(Color("PrimaryBlue"))
            .cornerRadius(25)
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Selected gender changed sucessfully!"),
                      message: Text("Account gender changed!"),
                      dismissButton: .default(Text("Ok"), action: {
                            self.presentationMode.wrappedValue.dismiss()
                      }))
            })
            
            Spacer()
            Spacer()
        }
        .padding()
    }//body
}//struct

struct ChangeAccountGenderView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeAccountGenderView()
    }
}
