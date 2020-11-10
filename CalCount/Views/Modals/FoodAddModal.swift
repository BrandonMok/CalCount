
import SwiftUI
import UIKit

struct FoodAddModal: View {
    @EnvironmentObject var mm: ModalManager
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject
    
    @State private var foodName = ""
    @State private var calories = ""
    
    @State private var carbs = ""
    @State private var fats = ""
    @State private var protein = ""
    
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
                Button(action: {
                    // CHECK input && add to realm!
                    if foodName.isEmpty || calories.isEmpty || carbs.isEmpty || fats.isEmpty || protein.isEmpty {
                        // ERROR - invalid input (blank)
                        showError()
                    }
                    else {
                        // There's input entered, still need to validate!
                        if calories.isNumeric && carbs.isNumeric && fats.isNumeric && protein.isNumeric {
                            // They're all numeric - create a FoodEntry
  
                            let foodEntry = FoodEntry()
                            foodEntry.user = self.status.currentUser
                            foodEntry.name = foodName
                            foodEntry.calories = Int(calories)!
                            foodEntry.carbs = Int(carbs)!
                            foodEntry.fat = Int(fats)!
                            foodEntry.protein = Int(protein)!
                            foodEntry.date = Date()
                            
                            // SAVE object
                            try! realmObj.realm.write {
                                realmObj.realm.add(foodEntry)
                            }
                            
                            // show alert for success
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
            self.hideKeyboard()
        }
    }//body
    
    
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
