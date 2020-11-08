

import SwiftUI

struct FloatingMenu: View {
    
    // MIGHT NOT need a modal manager!
    @EnvironmentObject var mm: ModalManager
    
    //https://www.youtube.com/watch?v=QCvP-iFfbAg
    @State private var showMenuItems = false
    
//    @State private var showModal = false
    
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .fullScreenCover(isPresented: $mm.showModal, content: {
            if mm.showCalorieModal {
                CalorieAddModal()
                    .onTapGesture {
                        mm.showCalorieModal.toggle()
                        mm.showModal.toggle()
                    }
            }
            else if mm.showWaterModal {
                WaterAddModal()
                    .onTapGesture {
                        mm.showWaterModal.toggle()
                        mm.showModal.toggle()
                    }
            }
        })
    }//body
}//struct

struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu()
    }
}


struct CalorieAddModal: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Add Food")
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.bold)
            
            
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
    var body: some View {
        VStack(alignment: .leading) {
            Text("Add Water")
                .font(.title)
                .fontWeight(.heavy)
        }//VStack
        .padding()
    }
}
