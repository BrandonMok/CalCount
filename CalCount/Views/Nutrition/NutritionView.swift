
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
                        ForEach(foodManager.foodsListCopy, id: \.id) { food in
                            SingleRow(food: food)
                        }
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


struct SingleRow: View {
    var food: FoodEntry
    
    @State private var du = DateUtility()
    @State private var tapped = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: tapped ? "arrowtriangle.down" : "arrowtriangle.down.fill")
                
                Text("\(du.formatDate(passedDate: food.date, dateStyle: .medium ))")
                    .font(.title)
                    .foregroundColor(.black)
                
                
            }
        }
        .onTapGesture {
            // display the bigger view possibly through either opacity or if elses
            tapped.toggle()
        }
    }
}
