
import SwiftUI

/**
 * FoodEditModal
 * Struct to act as a "modal" to show the user a form in which they can edit a Food Entry
 */
struct FoodEditModal: View {
    // https://developer.apple.com/forums/thread/120034
    // Reference to how to have binding value be passed to a subview
    
    @State private var food: FoodEntry
    var showEditModal: Binding<Bool>
    
    
    // EnvironmentObjects needed for application
    @EnvironmentObject var realmObj: RealmObject
    @EnvironmentObject var foodManager: FoodManager
    
    // Food Entry state variables
    @State private var foodName = ""
    @State private var calories = ""
    @State private var carbs = ""
    @State private var fat = ""
    @State private var protein = ""
    
    // Alert state variables
    @State private var showAlert = false            // bool var for CONFIRM edit button alert
    @State private var showAreYouSureAlert = false  // bool var for DELETE edit button alert
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    
    init(food: FoodEntry, showEditModal: Binding<Bool>) {
        self.showEditModal = showEditModal
        self._food = State(initialValue: food)
        self._foodName = State(initialValue: String(food.name))
        self._calories = State(initialValue: String(food.calories))
        self._carbs = State(initialValue: String(food.carbs))
        self._fat =  State(initialValue: String(food.fat))
        self._protein =  State(initialValue: String(food.protein))
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {

            // TOP SECTION
            HStack {
                Text("Edit Food - \(food.name)")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)

                Spacer()

                // X-button to leave the "modal"
                Button(action: {
                    self.showEditModal.wrappedValue.toggle()
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
            }

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
                
                TextField("Protein (g)", text: $protein)
                    .padding()
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)

                TextField("Fat (g)", text: $fat)
                    .padding()
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(5.0)
            }

            
            
            // MARK: - Buttons
            Section(){
                HStack {
                    // Edit Button
                    Button(action: {
                        if foodName.isEmpty || calories.isEmpty || carbs.isEmpty || fat.isEmpty || protein.isEmpty {
                            showError()
                        }
                        else {
                            // There was input, now validate that the respective fields are numeric
                            if calories.isNumeric && carbs.isNumeric && fat.isNumeric && protein.isNumeric {
                                
                                try! realmObj.realm.write {
                                    food.name = foodName
                                    food.calories = Int(calories)!
                                    food.carbs = Int(carbs)!
                                    food.fat = Int(fat)!
                                    food.protein = Int(protein)!
                                }

                                foodManager.updateFoodsList()
                                                                
                                alertTitle = "Success"
                                alertMsg = "Food entry edited successfully!"
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
                                    self.showEditModal.wrappedValue.toggle()
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
                        Alert(title: Text("Delete Food"),
                              message: Text("Are you sure you want to delete this food item?"),
                              primaryButton: .default(Text("Confirm"), action: {
                
                            
                            if let foodInArr = foodManager.foodsList.firstIndex(
                                where: {$0.id == food.id }) {
                                foodManager.foodsList.remove(at: foodInArr)
                                foodManager.foodsListCopy = foodManager.foodsList
                            }
                                
                            
                            // PROBLEM:
                            // Deleting object throws object invalidated or deleted error!
                            try! realmObj.realm.write {
                                realmObj.realm.delete(self.food)
                            }
                                
//                            foodManager.updateFoodsList()
                                
                            alertTitle = "Success"
                            alertMsg = "Food entry deleted successfully!"
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
        }//VStack
        .padding()
        .onTapGesture {
            self.hideKeyboard()
        }
    }//body
    
    
    // Reusable showError function
    func showError() {
        alertTitle = "Error"
        alertMsg = "There was an error editing the food! Please make sure all inputs are entered accordingly."
        showAlert.toggle()
    }
}//struct


struct FoodEditModal_Previews: PreviewProvider {
    static var previews: some View {
        Text("Food Edit Modal")    // don't know what value I'd but for the showEditModal under this preview
//        FoodEditModal(food: FoodEntry(), showEditModal: .init(Binding<Bool>)!)
    }
}
