
import SwiftUI

/**
 * WaterEditModal
 * Struct to act as a "modal" to show the user a form in which they can edit a Water Entry
 */
struct WaterEditModal: View {
    @State private var water: WaterEntry
    var showWaterAlertModal: Binding<Bool>
    
    
    // EnvironmentObjects needed for application
    @EnvironmentObject var realmObj: RealmObject
    @EnvironmentObject var foodManager: FoodManager
    @EnvironmentObject var waterManager: WaterManager
    
    @State private var amount = ""
    
    // Alert state variables
    @State private var showAlert = false                // bool var for CONFIRM edit button alert
    @State private var showAreYouSureAlert = false      // bool var for DELETE edit button alert
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    init(water: WaterEntry, showWaterAlertModal: Binding<Bool>) {
        self.showWaterAlertModal = showWaterAlertModal
        self._water = State(initialValue: water)
        self._amount = State(initialValue: String(water.amount))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // TOP SECTION
            HStack {
                Text("Edit Water")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                
                Spacer()
                
                // X-button to leave the "modal"
                Button(action: {
                    self.showWaterAlertModal.wrappedValue.toggle()
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
                TextField("Quantity (oz)", text: $amount)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
            }
            
            Section(){
                HStack {
                    Button(action: {
                        if amount.isEmpty {
                            showError()
                        }
                        else {
                            if amount.isNumeric {
                                
                                // Edit amount
                                try! realmObj.realm.write {
                                    water.amount = Int(amount)!
                                }
                                
                                waterManager.updateWaterList()

                                alertTitle = "Success"
                                alertMsg = "Water log edited successfully!"
                                showAlert.toggle()
                                
                            }
                            else {
                                showError()
                            }
                        }
                    }, label: {
                        Text("Confirm")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                    })
                    .padding()
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(15)
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("\(alertTitle)"),
                              message: Text("\(alertMsg)"),
                              dismissButton: .default(Text("OK"), action: {
                                if alertTitle == "Success" {
                                    self.showWaterAlertModal.wrappedValue.toggle()
                                }
                              }))
                    })
                    
                    
                    // Delete button
                    Button(action: {
                        showAreYouSureAlert.toggle()
                    }, label: {
                        Text("Delete")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                    })
                    .padding()
                    .background(Color(red: 230/255, green: 57/255, blue: 70/255))
                    .cornerRadius(15)
                    .alert(isPresented: $showAreYouSureAlert) {
                        Alert(title: Text("Delete Water"),
                              message: Text("Are you sure you wnat to delete this water entry?"),
                              primaryButton: .default(Text("Confirm"), action: {
                
                            
                            if let waterIndex = waterManager.waterList.firstIndex(
                                where: {$0.id == water.id }) {
                                waterManager.waterList.remove(at: waterIndex)
                            }

                            try! realmObj.realm.write {
                                realmObj.realm.delete(self.water)
                            }
                                
                            waterManager.updateWaterList()
                                
                            alertTitle = "Success"
                            alertMsg = "Water log deleted successfully!"
                            showAreYouSureAlert.toggle()

                          }),
                          secondaryButton: .default(Text("Cancel"), action: {
                            showAreYouSureAlert.toggle()
                          }
                        ))//Alert
                    }//alert
                }//hstack
            }//section
            .padding(.top)
            
            Spacer()
        }// Vstack
        .padding()
        .onTapGesture {
            self.hideKeyboard()
        }
    }//body
        
        
    func showError() {
        alertTitle = "Error"
        alertMsg = "There was an error logging water! Please make sure all inputs are entered accordingly."
        showAlert.toggle()
    }
}

struct WaterEditModal_Previews: PreviewProvider {
    static var previews: some View {
        Text("Food Water Modal")
//        WaterEditModal()  // couldn't figure out what I would pass to this preview to show for the Binding value
    }
}
