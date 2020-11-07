
import SwiftUI

enum Periods {
    case day
    case week
    case month
}

struct CalorieView: View {

    @ObservedObject var tabManager = TabManager()
//    @EnvironmentObject var status: LoggedInStatus
    
    @State var selectedPeriod = Periods.day
    
    init(){
        self.tabManager.selectedTab = Tabs.home
    }
    
    var body: some View {
        VStack {
            HStack {
                // DAY BTN
                Button(action: {
                    // TODO get users data on calories/food for the month
                    
                    selectedPeriod = Periods.day
                }, label: {
                    Text("Day")
                        .foregroundColor(.black)
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                })
                .background(selectedPeriod == Periods.day ? Color(red: 173/255, green: 181/255, blue: 189/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
                
                
                // WEEK BTN
                Button(action: {
                    // TODO get users data on calories/food for the month
                    
                    selectedPeriod = Periods.week
                }, label: {
                    Text("Week")
                        .foregroundColor(.black)
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                })
                .background(selectedPeriod == Periods.week ? Color(red: 173/255, green: 181/255, blue: 189/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
            
                
                // MONTH BTN
                Button(action: {
                    // TODO get users data on calories/food for the month
                    
                }, label: {
                    Text("Month")
                        .foregroundColor(.black)
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                })
                .background(selectedPeriod == Periods.month ? Color(red: 173/255, green: 181/255, blue: 189/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
                
                
            }//hstack
            .frame(maxWidth: .infinity)
            .background(Color(red: 233/255, green: 236/255, blue: 239/255))
            
            Spacer()
            
        }//vstack
    }
}

struct CalorieView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieView()
    }
}
