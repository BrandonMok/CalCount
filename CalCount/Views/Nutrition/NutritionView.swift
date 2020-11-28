
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
    
    
    var nutritionData: [Double] {
        set {
            nutritionData = []
        }
        get {
            let data = foodManager.calcMacros()
            var tempArr: [Double] = []
            tempArr.append(Double(data.1))
            tempArr.append(Double(data.2))
            tempArr.append(Double(data.3))
            return tempArr
        }
    }
    
    
    var body: some View {
        VStack {
            // MARK: - TOP BAR (Day, Week, Month)
            TopPeriodBar(chartData: $chartData)

            ScrollView {
                VStack {
                    PieChartView(data: nutritionData, title: "Nutrition")
                    
//                    switch selectedPeriod {
//                        case Periods.day:
//                            PieChartView(data: $nutritionData, title: "Nutrition")
//                                .frame(maxWidth: .infinity)
//                        case Periods.week:
//                            BarChartView(data: ChartData(points: chartData), title: "Week")
//                        case Periods.month:
//                            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Month")
//                    }
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
                }//Vstack
//                .onAppear {
//                    if !nutritionData.isEmpty {
//                        nutritionData = []
//                    }
//
//                    // SO the chart data array (nutritionData) has the data, but won't show it :/
//                    let data = foodManager.calcMacros()
//                    nutritionData.append(Double(data.1))
//                    nutritionData.append(Double(data.2))
//                    nutritionData.append(Double(data.3))
//                }

            }//scrollview
        }//Vstack
    }//body
}//struct

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView()
    }
}


/**
 * TabRow
 * A view to display the macronutrients of the selected time period
 * First initially only shows a little tab like view and then on tap, will show more data
 */
struct TabRow: View {
    @EnvironmentObject var foodManager: FoodManager

    @State private var du = DateUtility()
    @State private var tapped = false
    @State private var data: (calories: Int, carbs: Int, protein: Int, fat: Int) = (0,0,0,0)
    
    
    var tabPeriod: String {
        switch foodManager.selectedPeriod {
            case Periods.day:
                return du.formatDate(passedDate: Date(), dateStyle: .medium)
            case Periods.week:
                // https://www.reddit.com/r/swift/comments/f8ai10/finding_start_and_end_of_current_week_gives_me/
                let start = du.convertDateToLocalTime(foodManager.foodsListCopy.first!.date.startOfWeek!)
                let end = du.convertDateToLocalTime(foodManager.foodsListCopy.first!.date.endOfWeek!)

                let startingDay = du.formatDate(passedDate: start, dateStyle: .short)
                let endingDay = du.formatDate(passedDate: end, dateStyle: .short)
                let combined = "\(startingDay) - \(endingDay)"
                return combined
            case Periods.month:
                return du.getMonthFromDate(passedDate: foodManager.foodsListCopy.first!.date)
        }
    }//tabPeriod
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: tapped ? "arrowtriangle.up" : "arrowtriangle.down.fill")
                
                Text("\(tabPeriod)")
                    .font(.title2)
                    .foregroundColor(.black)
                
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
