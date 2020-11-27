
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
                            PieChartView(data: chartData, title: "Calories")
                                .frame(maxWidth: .infinity)
                        case Periods.week:
                            BarChartView(data: ChartData(points: chartData), title: "Week")
                        case Periods.month:
                            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Month")
                        default:
                            PieChartView(data: chartData, title: "Calories")
                                .frame(maxWidth: .infinity)
                    }
                
                    
                    // HStack with the calculated calories & remainder
                    HStack {
                        VStack{
                            Text("\(foodManager.totalCals)")
                                .font(.largeTitle)
                            
                            Text("Total")
                                .font(.title)
                                .bold()
                        }
                        .padding()
                        
//                        if self.status.currentUser.gender != "Prefer not to say" {
//                            VStack {
//                                Text("\(remainingCalories)")
//                                    .font(.largeTitle)
//
//                                Text("Remaining")
//                                    .font(.title)
//                                    .bold()
//                            }
//                            .padding()
//                        }
                    }//hstack
                    
                    
                    // MARK: - Add food button
//                    Button(action: {
//                        modalManager.showCalorieModal.toggle()
//                        modalManager.showModal.toggle()
//                    }, label: {
//                        Text("Add Food")
//                            .foregroundColor(.black)
//                            .font(.title)
//                            .padding(.horizontal)
//                            .padding(.vertical, 5)
//                    })
//                    .background(Color("PrimaryBlue"))
//                    .cornerRadius(5)
                }
                .padding(.vertical, 20)
                
                Spacer()
                
                VStack {
                    // list
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
        
        
        
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }//body
}//struct

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView()
    }
}
