
import SwiftUI
import SwiftUICharts
import UIKit

/**
 * NutritionView
 * View to display the nutritional values of the foods consumed
 * Similar to the FoodView BUT displays the macronutrient totals instead of just food name & calories
 */
struct NutritionView: View {
    
    // EnvironmentObjects necessary for the application
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObject: RealmObject
    @EnvironmentObject var foodManager: FoodManager
    
    // Selected Time Period of data to see (e.g. Day, Week, Month)
    @State var selectedPeriod = Periods.day
    @State var chartData: [Double] = []
    
    var body: some View {
        VStack {
            // MARK: - TOP BAR (Day, Week, Month)
            TopPeriodBar(chartData: $chartData)

            ScrollView {
                VStack {
                    switch selectedPeriod {
                        case Periods.day:
                            PieChartView(data: chartData, title: "Nutrition")
                                .frame(maxWidth: .infinity)
                        case Periods.week:
                            BarChartView(data: ChartData(points: chartData), title: "Week")
                        case Periods.month:
                            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Month")
                    }
                }
                .padding(.vertical, 20)

                Spacer()

                VStack {
                    if !foodManager.foodsListCopy.isEmpty {
                        // Only one row / tab thing bc data in it is the only thing that'll change
                        TabRow()
                    }
                    else {
                        Text("No food records!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)

                        Spacer()
                        Spacer()
                    }
                }
                .onAppear {
//                    chartData = []
//
//                    switch foodManager.selectedPeriod {
//                        case Periods.day:
//                            foodManager.filterForDay()
//                            chartData.append(contentsOf: foodManager.getDayChartData())
//                        case Periods.week:
//                            foodManager.filterForWeek()
//                        case Periods.month:
//                            foodManager.filterForMonth()
//                    }
                }

            }//scrollview
        }//Vstack
    }//body
}//struct

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView()
    }
}


struct TabRow: View {
    @EnvironmentObject var foodManager: FoodManager
    
    @State private var du = DateUtility()
    @State private var tapped = false
    
    @State private var data: (calories: Int, carbs: Int, protein: Int, fat: Int) = (0,0,0,0)
    
//    var tabPeriod: String {       // used as the tab display before tapping on it to show more info
//        switch foodManager.selectedPeriod {
//        case Periods.day:
//            return du.formatDate(passedDate: Date(), dateStyle: .medium)
//        case Periods.week:
//            // get beginning && and of week then pass through func
//        case Periods.month:
//            // something
//    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: tapped ? "arrowtriangle.up" : "arrowtriangle.down.fill")
                
                // check period bc if Day => show today's date, Week => show range, etc.
                
//                Text("\(du.formatDate(passedDate: food.date, dateStyle: .medium ))")
//                    .font(.title2)
//                    .foregroundColor(.black)
                
                Spacer()
            }
            .padding()
 
            // Show full
            if tapped {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Total Calories:")
                            .font(.title2)
                            .fontWeight(.heavy)
                        
                        Spacer()
                        
                        Text("\(data.calories)")
                            .font(.title2)
                            .fontWeight(.heavy)
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Carbs")
                            .font(.title3)
                            .foregroundColor(.black)
                            .bold()
                        
                        Spacer()
                        
                        Text("\(data.carbs)")
                            .bold()
                    }
                    
                    HStack {
                        Text("Protein")
                            .font(.title3)
                            .foregroundColor(.black)
                            .bold()
                        
                        Spacer()
                        
                        Text("\(data.protein)")
                            .bold()
                    }
                    
                    HStack {
                        Text("Fats")
                            .font(.title3)
                            .foregroundColor(.black)
                            .bold()
                        
                        Spacer()
                        
                        Text("\(data.fat)")
                            .bold()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 218.0/255, green: 221.0/255, blue: 224.0/255))
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color(red: 233.0/255, green: 236.0/255, blue: 239.0/255))
        .padding()
        .onTapGesture {
            // display the bigger view possibly through either opacity or if elses
            tapped.toggle()
            data = foodManager.calcMacros()
        }
    }
}
