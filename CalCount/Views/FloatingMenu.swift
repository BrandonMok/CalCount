

import SwiftUI
import UIKit

struct FloatingMenu: View {
    
    @EnvironmentObject var mm: ModalManager
    
    //https://www.youtube.com/watch?v=QCvP-iFfbAg
    @State private var showMenuItems = false
    
    
    var body: some View {
        VStack {
            Spacer()
            
            if showMenuItems {
                VStack {
                    // Food btn
                    Button(action: {
                        mm.showCalorieModal.toggle()
                        mm.showModal.toggle()
                        showMenuItems.toggle()
                    }, label: {
                        Image(systemName: "scroll")
                            .padding()
                            .font(.title2)
                            .foregroundColor(.white)

                    })
                    .padding()
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(50)
                    
                    
                    // Water btn
                    Button(action: {
                        mm.showWaterModal.toggle()
                        mm.showModal.toggle()
                        showMenuItems.toggle()
                    }, label: {
                        Image(systemName: "drop")
                            .padding()
                            .font(.title2)
                            .foregroundColor(.white)
                    })
                    .padding()
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(50)
                    
                }
            }

            
            // FAB button
            Button(action: {
                showMenuItems.toggle()
            }, label: {
                Image(systemName: showMenuItems ? "xmark" : "plus")
                .font(.system(.title))
                .frame(width: 80, height: 80)
                    .foregroundColor(showMenuItems ? Color.black : Color(red: 248/255, green: 249/255, blue: 250/255))
            })
            .background(showMenuItems ? .white : Color("PrimaryBlue"))
            .cornerRadius(38.5)
            .padding(.bottom, 20)
            .shadow(color: Color.black.opacity(0.3),radius: 5, x: 3, y: 3)
        }//vstack
        .fullScreenCover(isPresented: $mm.showModal, content: {
            if mm.showCalorieModal {
                FoodAddModal()
            }
            else if mm.showWaterModal {
                WaterAddModal()
            }
        })
    }//body
}//struct

struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


// MARK: - Modal to add a new Food!
struct FoodAddModal: View {
    @EnvironmentObject var mm: ModalManager
    
    @State private var foodName = ""
    @State private var calories = ""    // need to convert to int!  EX: Int(calories) ?? 0
    
    @State private var carbs = ""
    @State private var fats = ""
    @State private var protein = ""
    
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
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
                        showAlert.toggle()
                    }
                    else {
                        // There's input entered, still need to validate!
                        
                        
                        
                        
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
            Alert(title: Text("Error"),
                  message: Text("There was an error creating the food! Please make sure all inputs are entered accordingly."),
                  dismissButton: .default(Text("OK")))
        })
        .onTapGesture {
            self.hideKeyboard()
        }
    }//body
}//struct

struct WaterAddModal: View {
    @EnvironmentObject var mm: ModalManager
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Add Water")
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
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
            
//                    Form {
//                        Section(header: Text("Water")
//                                    .fontWeight(.heavy)
//                                    .foregroundColor(.blue)){
//            //                    TextField("Total number of people", text: $numOfPeople)
//            //                        .keyboardType(.numberPad)
//                        }
//                    }//form
            
            
        }// Vstack
        .padding()
        
    }//body
}//struct
