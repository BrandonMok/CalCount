

import SwiftUI

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


struct FoodAddModal: View {
    @EnvironmentObject var mm: ModalManager
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Add Food")
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
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

            
            
            Form {
                Section(header: Text("Calories")
                            .fontWeight(.heavy)
                            .foregroundColor(.blue)){
//                    TextField("Total number of people", text: $numOfPeople)
//                        .keyboardType(.numberPad)
                }
            }
            

        }//VStack
        .padding()
    }
}

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
