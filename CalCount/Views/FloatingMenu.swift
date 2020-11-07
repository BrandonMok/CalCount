

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
                    Button(action: {
                        print("VALUE: \(mm.showCalorieModal)")
                        mm.showCalorieModal.toggle()
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
                    
                    
                    
                    Button(action: {
                        mm.showWaterModal.toggle()
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
                .fontWeight(.heavy)
        }//VStack
        .padding()
        .background(Color.blue)
        .shadow(color: Color.black.opacity(0.3),radius: 5, x: 3, y: 3)
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
        .background(Color.blue)
        .shadow(color: Color.black.opacity(0.3),radius: 5, x: 3, y: 3)
    }
}
