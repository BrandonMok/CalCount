

import SwiftUI
import UIKit

/**
 * FoatingMenu
 * Struct for the Floating Action Button (FAB)
 * Allows for the creation of a food and water entry through the presented options
 * Note: Can also add a food and water entry in their respective areas (i.e. the "home" tab and the "water" tab)
 */
struct FloatingMenu: View {
    
    // https://www.youtube.com/watch?v=QCvP-iFfbAg
    // Note: The above YouTube video was referenced and used to help create my FAB and custom options
    
    // Necessary EnvironmentObjects
    @EnvironmentObject var mm: ModalManager
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObject: RealmObject
    
    @State var showMenuItems = false
    
    
    var body: some View {
        VStack {
            Spacer()
            
            // Check if showMenuItems was set to True from clicking the FAB
             // Displays the two options of Food & Water
            if showMenuItems {
                VStack {
                    // Food button
                    Button(action: {
                        mm.showCalorieModal.toggle()    // set which modal should show - Calorie modal
                        mm.showModal.toggle()           // show the modal (a sheet) w/the form
                        showMenuItems.toggle()          // hide the opened options from the FAB
                    }, label: {
                        Image(systemName: "scroll")
                            .padding()
                            .font(.title2)
                            .foregroundColor(.white)

                    })
                    .padding()
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(50)
                    
                    
                    // Water button
                    Button(action: {
                        mm.showWaterModal.toggle()  // set which modal should show - Water modal
                        mm.showModal.toggle()       // show the modal (a sheet) w/the form
                        showMenuItems.toggle()      //  hide the opened options from the FAB
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
            // NOTE: only shows on the Food / home tab and Water tab
            Button(action: {
                showMenuItems.toggle()  // show the options for the FAB (e.g. Food & water buttons)
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
        .fullScreenCover(isPresented: $mm.showModal, content: {      //fullscreencover acts as my "modal"
            // deteremine which modal to show
              if mm.showCalorieModal {
                  //https://stackoverflow.com/questions/58743004/swiftui-environmentobject-error-may-be-missing-as-an-ancestor-of-this-view
                  // Resource used to fix issue on subviews erroring out on environmentobject and missing an observable object
                  FoodAddModal().environmentObject(self.mm).environmentObject(self.status).environmentObject(self.realmObject)
              }
              else if mm.showWaterModal {
                  WaterAddModal().environmentObject(self.mm).environmentObject(self.status).environmentObject(self.realmObject)
              }
        })
    }//body
}//struct

struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu()
    }
}


// https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
// Extension to hide the keyboard
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


// Extension to check if a text input is numeric
extension String {
   var isNumeric: Bool {
     return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
   }
}
