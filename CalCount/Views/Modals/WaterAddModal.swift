
import SwiftUI
import UIKit

struct WaterAddModal: View {
    @EnvironmentObject var mm: ModalManager
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject
    
    var body: some View {
        VStack(alignment: .leading) {
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
                self.hideKeyboard()
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
