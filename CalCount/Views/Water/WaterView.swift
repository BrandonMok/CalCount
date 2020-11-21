
import SwiftUI
import SwiftUICharts
import UIKit

/**
 * WaterView
 * A view in the TabView that shows all the user's data on the water entries they've entered
 * Can change between different time periods of their data, look at graphs, look at their entries, and manage their food entries
 */
struct WaterView: View {
    
    @EnvironmentObject var tabManager: TabManager
    @EnvironmentObject var realmObject: RealmObject
    @EnvironmentObject var status: LoggedInStatus
    
    @State private var chartData: [Double] = []
    
    var body: some View {
        ScrollView {
            VStack {
                PieChartView(data: chartData, title: "Water Consumption")
                    .frame(maxWidth: .infinity)
                
                // HStack with the calculated water consumption
                HStack {
                    VStack{
                        Text("TEMP oz")
                            .font(.largeTitle)
                        
                        Text("Goal")
                            .font(.title)
                            .bold()
                    }
                    .padding()
                    
                    VStack {
                        Text("TEMP oz")
                            .font(.largeTitle)
                        
                        Text("Consumed")
                            .font(.title)
                            .bold()
                    }
                    .padding()
                }//hstack
            }//vstack
            .padding(.vertical, 20)
            
            Spacer()
            
            // VStack to hold the list of water log entries
            VStack {
                
            }
            
            
            
        }// Scrollview
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
