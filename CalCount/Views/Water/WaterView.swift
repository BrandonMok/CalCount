
import SwiftUI
import SwiftUICharts
import UIKit

/**
 * WaterView
 * A view in the TabView that shows all the user's data on the water entries they've entered
 * Can change between different time periods of their data, look at graphs, look at their entries, and manage their water logs
 */
struct WaterView: View {
    
    // EnvironmentObjects necessary for the application
    @EnvironmentObject var realmObject: RealmObject
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var waterManager: WaterManager
    @EnvironmentObject var modalManager: ModalManager
    
    @State private var chartData: [Double] = []
    
    var body: some View {
        ScrollView {
            VStack {
                PieChartView(data: chartData, title: "Water Consumption")
                    .frame(maxWidth: .infinity)
                
                // HStack with the calculated water consumption
                HStack {
                    VStack{
                        // TODO: do a conditional so if there's a goal show it else don't
                        Text("TEMP oz")
                            .font(.largeTitle)
                        
                        Text("Goal")
                            .font(.title)
                            .bold()
                    }
                    .padding()
                    
                    VStack {
                        Text("\(waterManager.totalConsumed)oz")
                            .font(.largeTitle)
                        
                        Text("Consumed")
                            .font(.title)
                            .bold()
                    }
                    .padding()
                }//hstack
            }//vstack
            .padding(.vertical, 20)
            
            // MARK: - Add water button
            Button(action: {
                modalManager.showWaterModal.toggle()
                modalManager.showModal.toggle()
            }, label: {
                Text("Add Water")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
            })
            .background(Color("PrimaryBlue"))
            .cornerRadius(5)
            
            Spacer()
            
            // VStack to hold the list of water log entries
            VStack {
                if !waterManager.waterList.isEmpty {
                    ForEach(waterManager.waterList, id: \.self) { water in
                        WaterRow(water: water)
                    }
                }
                else {
                    Text("No water logged!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Spacer()
                    Spacer()
                }
            } 
        }// Scrollview
        .onAppear {
            waterManager.updateWaterList()
        }
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}


/**
 * WaterRow
 * View to represent an individual row of a water entry
 */
struct WaterRow: View {
    var water: WaterEntry
    
    @EnvironmentObject var realmObject: RealmObject
    @EnvironmentObject var waterManager: WaterManager
    
    @State private var du = DateUtility()
    
    @State var showWaterAlertModal = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(du.formatTime(passedDate: water.date, timeStyle: .short))")
                    .font(.title)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("\(water.amount)oz")
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding()
        .background(Color(red: 233.0/255, green: 236.0/255, blue: 239.0/255))
        .contentShape(Rectangle())
        .onTapGesture {
            showWaterAlertModal.toggle()
        }
        .fullScreenCover(isPresented: $showWaterAlertModal, content: {
            WaterEditModal(water: water, showWaterAlertModal: $showWaterAlertModal)
        })
    }
}
