
import SwiftUI
import UIKit

/**
 * FoodAddModal
 * Struct to act as a "modal" to show the user a form in which they can enter inputs to create a Food Entry
 * Created / called from either the action of the FAB (i.e. tap the FAB button and tap the Food button) OR from the "home" tab
 */
struct FoodAddModal: View {
    // EnvironmentObjects needed for application
    @EnvironmentObject var mm: ModalManager
    @EnvironmentObject var status: LoggedInStatus
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
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // TOP SECTION
            HStack {
                Text("Add Food")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                
                Spacer()
                
                // X-button to leave the "modal"
                Button(action: {
                    mm.showCalorieModal.toggle()
                    mm.showModal.toggle()
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
            Section(header: Text("Name")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)){
                
                TextField("Name", text: $foodName)
                    .padding()
                    .keyboardType(.alphabet)
                    .foregroundColor(.black)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
            }//section
            
            
            Section(header: Text("Calories")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)) {
                TextField("Calories", text: $calories)
                    .padding()
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
            }
            
            
                        
            Section(header: Text("Macronutrients")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)) {
             
                
                TextField("Carbohydrates (g)", text: $carbs)
                    .padding()
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
                
                
                TextField("Fat (g)", text: $fats)
                    .padding()
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
                
                
                TextField("Protein (g)", text: $protein)
                    .padding()
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
            }
            
            Section(){
                // Submit button
                Button(action: {
                    // CHECK input && add to realm!
                    if foodName.isEmpty || calories.isEmpty || carbs.isEmpty || fats.isEmpty || protein.isEmpty {
                        // ERROR - invalid input (blank)
                        showError()
                    }
                    else {
                        // There was input, now validate that the respective fields are numeric
                        if calories.isNumeric && carbs.isNumeric && fats.isNumeric && protein.isNumeric {

                            // Create a FoodEntry
                            let foodEntry = FoodEntry()
                            foodEntry.user = self.status.currentUser
                            foodEntry.name = foodName
                            foodEntry.calories = Int(calories)!
                            foodEntry.carbs = Int(carbs)!
                            foodEntry.fat = Int(fats)!
                            foodEntry.protein = Int(protein)!
                            foodEntry.date = Date()
                            
                            // SAVE the object
                            try! realmObj.realm.write {
                                realmObj.realm.add(foodEntry)
                            }
                            
                            foodManager.updateFoodsList()
                            
                            // After updating the added food entry to the list, need to sort by the period!
                            // otherwise, regardless of period, it will show all the entries that aren't in the selected period!
                            switch foodManager.selectedPeriod {
                                case Periods.day:
                                    foodManager.filterForDay()
                                case Periods.week:
                                    foodManager.filterForWeek()
                                case Periods.month:
                                    foodManager.filterForMonth()
                            }
                            
                            foodManager.calculateConsumedCalories()
                            
                            
                            showSuccess()
                        }
                        else {
                            // Non numeric input for the numeric only fields
                            showError()
                        }
                    }
                }, label: {
                    Text("Submit")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 0, maxHeight: 20)
                })
                .padding()
                .background(Color("PrimaryBlue"))
                .cornerRadius(15)
            }
            .padding(.top)


            Spacer()
        }//VStack
        .padding()
        .alert(isPresented: $showAlert, content: {
            // Alert to show either success or failure
            Alert(title: Text("\(alertTitle)"),
                  message: Text("\(alertMsg)"),
                  dismissButton: .default(Text("OK"), action: {
                    if alertTitle == "Success" {
                        mm.showCalorieModal.toggle()
                        mm.showModal.toggle()
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
        alertMsg = "There was an error creating the food! Please make sure all inputs are entered accordingly."
        showAlert.toggle()
    }
    
    func showSuccess() {
        alertTitle = "Success"
        alertMsg = "Food entry added successfully!"
        showAlert.toggle()  //show the alert for success/fail for this sheet
    }
}

struct FoodAddModal_Previews: PreviewProvider {
    static var previews: some View {
        FoodAddModal()
    }
}
