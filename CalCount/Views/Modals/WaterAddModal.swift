
import SwiftUI
import UIKit

/**
 * WaterAddModal
 * Struct to act as a "modal" to show the user a form in which they can enter inputs to create a Water Entry
 * Created / called from either the action of the FAB (i.e. tap the FAB button and tap the Water button) OR from the "water" tab
 */
struct WaterAddModal: View {
    
    // EnvironmentObjects necessary for the application
    @EnvironmentObject var mm: ModalManager
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject
    @EnvironmentObject var waterManager: WaterManager
    
    @State private var amount = ""
    
    // Alert state variables
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    
    var body: some View {
        VStack(alignment: .leading) {
            // TOP SECTION
            HStack {
                Text("Add Water")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                
                Spacer()
                
                // X-button to leave the "modal"
                Button(action: {
                    mm.showWaterModal.toggle()
                    mm.showModal.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.black)
                })
            }
            .padding(.bottom)
            .onTapGesture {
                self.hideKeyboard() // hide the keyboard if tapped elsewhere
            }
            
           
            Section(header: Text("Quantity")
                        .fontWeight(.heavy)
                        .foregroundColor(.blue)){
                TextField("Quantity (g)", text: $amount)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
            }
            
            Section(){
                // Submit button - TODO: not showing!
//                Button(action: {
//                    // CHECK input && add to realm!
//                    if amount.isEmpty {
//                        // ERROR - invalid input (blank)
//                        showError()
//                    }
//                    else {
//                        if amount.isNumeric {
//
//                            // Create a WaterEntry
//                            let waterEntry = WaterEntry()
//                            waterEntry.user = self.status.currentUser
//                            waterEntry.amount = Int(amount)!
//
//                            // SAVE the object
//                            try! realmObj.realm.write {
//                                realmObj.realm.add(waterEntry)
//                            }
//
//                            waterManager.updateWaterList()
//
//                            // show alert for success
//                            showSuccess()
//                        }
//                        else {
//                            // Non numeric input for the numeric only fields
//                            showError()
//                        }
//                    }
//                }, label: {
//                    Text("Submit")
//                        .foregroundColor(.white)
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 20)
//                })
            
            }
            .padding(.top)
        }// Vstack
        .padding()
        .onTapGesture {
            self.hideKeyboard()
        }
        
        Spacer()
        
    }//body
        
        
    // Reusable showError function
    // Sets and toggles the necessary fields
    func showError() {
        alertTitle = "Error"
        alertMsg = "There was an error logging water! Please make sure all inputs are entered accordingly."
        showAlert.toggle()
    }

    func showSuccess() {
        alertTitle = "Success"
        alertMsg = "Water logged successfully!"
        showAlert.toggle()
    }
        
}// struct

struct WaterAddModal_Previews: PreviewProvider {
    static var previews: some View {
        WaterAddModal()
    }
}
