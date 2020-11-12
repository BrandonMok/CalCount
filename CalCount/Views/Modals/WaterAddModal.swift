
import SwiftUI
import UIKit

/**
 * WaterAddModal
 * Struct to act as a "modal" to show the user a form in which they can enter inputs to create a Water Entry
 * Created / called from either the action of the FAB (i.e. tap the FAB button and tap the Water button) OR from the "water" tab
 */
struct WaterAddModal: View {
    
    // EnvironmentObjects necessary for the application
    @EnvironmentObject var mm: ModalManager
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject
    
    var body: some View {
        VStack(alignment: .leading) {
            // TOP SECTION
            HStack {
                Text("Add Water")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                
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
            .padding(.bottom)
            .onTapGesture {
                self.hideKeyboard() // hide the keyboard if tapped elsewhere
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
        .onTapGesture {
            self.hideKeyboard()
        }
        
    }//body
}

struct WaterAddModal_Previews: PreviewProvider {
    static var previews: some View {
        WaterAddModal()
    }
}
