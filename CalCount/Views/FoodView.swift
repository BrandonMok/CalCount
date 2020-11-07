
import SwiftUI
import SwiftUICharts

enum Periods {
    case day
    case week
    case month
}

struct FoodView: View {

    @ObservedObject var tabManager = TabManager()
    @EnvironmentObject var status: LoggedInStatus
    
    @State var selectedPeriod = Periods.day
    
    init(){
        self.tabManager.selectedTab = Tabs.home
    }
    
    var body: some View {
        VStack {
            TopPeriodBar(selectedPeriod: $selectedPeriod)
            
            VStack {
                PieChartView(data: [10,20], title: "Calories")
                    .frame(maxWidth: .infinity)
                
                HStack {
                    VStack{
                        Text("0")
                            .font(.largeTitle)
                        
                        Text("Total")
                            .font(.title)
                            .bold()
                    }
                    .padding()
                    
                    VStack {
                        Text("0")
                            .font(.largeTitle)
                        
                        Text("Remaining")
                            .font(.title)
                            .bold()
                    }
                    .padding()
                }
                
                // Add food button
                Button(action: {
                    // Bring up same modal as the FAB
                    
                }, label: {
                    Text("Add Food")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                })
                .background(Color("PrimaryBlue"))
                .border(Color.black)
                .cornerRadius(5)
                
            }//hstack
            .padding(.vertical)
            
            Spacer()
            
            
            VStack {
                // List of all the items! - TODO
                // NEED a food row view
            }
        }//vstack
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
    }
}


struct TopPeriodBar: View {
    @Binding var selectedPeriod: Periods
    
    var body: some View {
        HStack {
            // DAY BTN
            Button(action: {
                // TODO get users data on calories/food for the month
                
                selectedPeriod = Periods.day
            }, label: {
                Text("Day")
                    .foregroundColor(.black)
                    .font(.title2)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            })
            .background(selectedPeriod == Periods.day ? Color(red: 173/255, green: 181/255, blue: 189/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
            .border(selectedPeriod == Periods.day ? Color(red: 108/255, green: 117/255, blue: 125/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
            
            
            // WEEK BTN
            Button(action: {
                // TODO get users data on calories/food for the month
                
                selectedPeriod = Periods.week
            }, label: {
                Text("Week")
                    .foregroundColor(.black)
                    .font(.title2)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            })
            .background(selectedPeriod == Periods.week ? Color(red: 173/255, green: 181/255, blue: 189/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
            .border(selectedPeriod == Periods.week ? Color(red: 108/255, green: 117/255, blue: 125/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
        
            
            // MONTH BTN
            Button(action: {
                // TODO get users data on calories/food for the month
                
                
                selectedPeriod = Periods.month
            }, label: {
                Text("Month")
                    .foregroundColor(.black)
                    .font(.title2)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            })
            .background(selectedPeriod == Periods.month ? Color(red: 173/255, green: 181/255, blue: 189/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
            .border(selectedPeriod == Periods.day ? Color(red: 108/255, green: 117/255, blue: 125/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
            
            
        }//hstack
        .frame(maxWidth: .infinity)
        .background(Color(red: 233/255, green: 236/255, blue: 239/255))
    }
}
