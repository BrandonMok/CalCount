
import SwiftUI

/**
 * FoodEditModal
 * Struct to act as a "modal" to show the user a form in which they can edit a Food Entry
 * Created / called from either the action of the FAB (i.e. tap the FAB button and tap the Food button) OR from the "home" tab
 */
struct FoodEditModal: View {
    
    var food: FoodEntry?
    @Binding var showEditModal: Bool
    
    // EnvironmentObjects needed for application
    @EnvironmentObject var realmObj: RealmObject
    @EnvironmentObject var foodManager: FoodManager
    
    // Food Entry state variables
    @State private var foodName = ""
    @State private var calories = ""
    @State private var carbs = ""
    @State private var fats = ""
    @State private var protein = ""
    
    // Alert state variables
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    // TODO
    // Preload all the textfields/inputs w/ this food's values
    
    
    var body: some View {
        VStack(alignment: .leading) {

            // TOP SECTION
            HStack {
                Text("Edit Food - \(food!.name)")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)

                Spacer()

                // X-button to leave the "modal"
                Button(action: {
                    showEditModal.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.black)
                })
            }
            .padding(.bottom)
            .onTapGesture {
                self.hideKeyboard()
            }


            // INPUTS/SECTION
//            Section(header: Text("Name")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)){
//
//                TextField("Name", text: $foodName)
//                    .padding()
//                    .keyboardType(.alphabet)
//                    .foregroundColor(.black)
//                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
//                    .cornerRadius(5.0)
//            }//section
//
//
//            Section(header: Text("Calories")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)) {
//                TextField("Calories", text: $calories)
//                    .padding()
//                    .keyboardType(.numberPad)
//                    .foregroundColor(.black)
//                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
//                    .cornerRadius(5.0)
//            }
//
//
//
//            Section(header: Text("Macronutrients")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.black)) {
//
//
//                TextField("Carbohydrates (g)", text: $carbs)
//                    .padding()
//                    .keyboardType(.numberPad)
//                    .foregroundColor(.black)
//                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
//                    .cornerRadius(5.0)
//
//
//                TextField("Fat (g)", text: $fats)
//                    .padding()
//                    .keyboardType(.numberPad)
//                    .foregroundColor(.black)
//                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
//                    .cornerRadius(5.0)
//
//
//                TextField("Protein (g)", text: $protein)
//                    .padding()
//                    .keyboardType(.numberPad)
//                    .foregroundColor(.black)
//                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
//                    .cornerRadius(5.0)
//            }
//
//            Section(){
//                HStack {
//                    // Edit Button
//                    Button(action: {
//                        if foodName.isEmpty || calories.isEmpty || carbs.isEmpty || fats.isEmpty || protein.isEmpty {
//                            showError()
//                        }
//                        else {
//                            // There was input, now validate that the respective fields are numeric
//                            if calories.isNumeric && carbs.isNumeric && fats.isNumeric && protein.isNumeric {
//
//                                // Edit the food object
//                                try! realmObj.realm.write {
//                                    // change the property in here!
//                                    // TODO
//
//                                }
//
//                                foodManager.updateFoodsList()
//
//                                // show alert for success
//                                showSuccess(whichSuccess: "edit")
//                            }
//                            else {
//                                // Non numeric input for the numeric only fields
//                                showError()
//                            }
//                        }
//                    }, label: {
//                        Text("Confirm")
//                            .foregroundColor(.white)
//                            .font(.title2)
//                            .fontWeight(.bold)
////                            .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 20)
//                    })
//                    .padding()
//                    .background(Color("PrimaryBlue"))
//                    .cornerRadius(15)
//
//
//                    // Delete button
//                    Button(action: {
//                        // delete the food item!
//
//
//
//                    }, label: {
//                        Text("Delete")
//                            .foregroundColor(.white)
//                            .font(.title2)
//                            .fontWeight(.bold)
////                            .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 20)
//                    })
//                    .padding()
//                    .background(Color(red: 230/255, green: 57/255, blue: 70/255))
//                    .cornerRadius(15)
//
//
//
//                }//hstack
//
//
//            }//section
//            .padding(.top)
//
//
//            Spacer()
        }//VStack
        .padding()
        .alert(isPresented: $showAlert, content: {
            // Alert to show either success or failure
            Alert(title: Text("\(alertTitle)"),
                  message: Text("\(alertMsg)"),
                  dismissButton: .default(Text("OK"), action: {
                    if alertTitle == "Success" {
                        showEditModal.toggle()
                    }
                  }))
        })
        .onTapGesture {
            self.hideKeyboard() // hide the keyboard if touch elsewhere
        }
    }//body
    
    
    // Reusable showError function
    // Sets and toggles the necessary fields
    func showError() {
        alertTitle = "Error"
        alertMsg = "There was an error editing the food! Please make sure all inputs are entered accordingly."
        showAlert.toggle()
    }
    
    // Success alert message title and message setting
    func showSuccess(whichSuccess: String) {
        alertTitle = "Success"
        
        if whichSuccess == "edit" {
            alertMsg = "Food entry edited successfully!"
        }
        else {
            alertMsg = "Food entry deleted successfully!"
        }
        
        showAlert.toggle()
    }
}//struct

struct FoodEditModal_Previews: PreviewProvider {
    static var previews: some View {
        FoodEditModal(food: FoodEntry(), showEditModal: .constant(true))
    }
}
