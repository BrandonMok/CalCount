
import SwiftUI
import SwiftUICharts
import UIKit


/**
 * Periods Enum
 */
enum Periods {
    case day
    case week
    case month
}


/**
 * FoodView
 * A view in the TabView that shows all the user's data on the food entries they've entered
 * Can change between different time periods of their data, look at graphs, look at their entries, and manage their food entries
 */
struct FoodView: View {

    // EnvironmentObjects necessary for the application
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObject: RealmObject
    @EnvironmentObject var foodManager: FoodManager
    @EnvironmentObject var modalManager: ModalManager
    
    @State var chartData: [Double] = []

    @State private var remainingCalories: Int = 0
    
    // something isn't right :/
//    var foodData: [Double] {
//        set {
//            if !foodManager.foodsListCopy.isEmpty {
//                var tempArr: [Double] = []
//                let calculatedVals = foodManager.calculateConsumedCalories()
//                tempArr.append(Double(calculatedVals))
//                self.foodData =  tempArr
//            }
//            else {
//                self.foodData = [0.0]
//            }
//        }
        
//        var tempArr: [Double] = []
//
//        if !foodManager.foodsListCopy.isEmpty {
//            if foodManager.foodsListCopy.count == 1 && foodManager.foodsListCopy.first!.calories == 0 {
//                // need to catch if the only value is 0
//            }
//            else {
//                tempArr = [foodManager.getDayChartData()]
//            }
//        }
//
//        return tempArr
//
////        switch foodManager.selectedPeriod {
////            case Periods.day:
////                return [foodManager.getDayChartData()]
////            case Periods.week:
////                return [foodManager.getDayChartData() ]   // temp
////            case Periods.month:
////                return [foodManager.getDayChartData() ]   // temp
////        }
//    }

    var body: some View {
        VStack {
            // MARK: - TOP BAR (Day, Week, Month)
            TopPeriodBar()
            
            ScrollView {
                VStack {
                    // Top chart to show data based on data
                    switch foodManager.selectedPeriod {
                        case Periods.day:
                            PieChartView(data: chartData, title: "Calories")
                                .frame(maxWidth: .infinity)
                        case Periods.week:
                            BarChartView(data: ChartData(points: chartData), title: "Week")
                        case Periods.month:
                            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Month")
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
                        
                        if self.status.currentUser.gender != "Prefer not to say" {
                            VStack {
                                Text("\(remainingCalories)")
                                    .font(.largeTitle)
                                
                                Text("Remaining")
                                    .font(.title)
                                    .bold()
                            }
                            .padding()
                        }
                    }//hstack
                    
                    
                    // MARK: - Add food button
                    Button(action: {
                        modalManager.showCalorieModal.toggle()
                        modalManager.showModal.toggle()
                    }, label: {
                        Text("Add Food")
                            .foregroundColor(.black)
                            .font(.title)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                    })
                    .background(Color("PrimaryBlue"))
                    .cornerRadius(5)
                    
                }//vstack
                .padding(.vertical, 20)
                
                Spacer()
                
                
                // MARK: - Food List
                VStack {
                    if !foodManager.foodsListCopy.isEmpty {
                        ForEach(foodManager.foodsListCopy, id: \.id) { food in
                            FoodRow(food: food)
                        }
                    }
                    else {
                        Text("No food records!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Spacer()
                        Spacer()
                    }
                }//vstack
                .onAppear {
                    // NOTE: data gets added, BUT chart won't use it for some reason
                    chartData = []
                    
                    switch foodManager.selectedPeriod {
                        case Periods.day:
                            foodManager.filterForDay()
                            chartData.append(Double(foodManager.getDayChartData()))
                        case Periods.week:
                            foodManager.filterForWeek()
                        case Periods.month:
                            foodManager.filterForMonth()
                    }                    
                    foodManager.calculateConsumedCalories()
                    updateRemainingCals()
                }
            }//ScrollView
            .padding(.bottom, 20)
        }
    }//body
    
    
    func updateRemainingCals() {
        // based on recommended daily calorie intakes (not the best bc doesn't account for personal cases)
        if status.currentUser.gender == "Male" {
            self.remainingCalories = 3000 - self.foodManager.totalCals
        }
        else if status.currentUser.gender == "Female" {
            self.remainingCalories = 2400 - self.foodManager.totalCals
        }
        else {
            self.remainingCalories = 0
        }
    }
}//struct

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
    }
}


/**
 * FoodRow
 * A view to represent a Food Entry row
 */
struct FoodRow: View {
    
    var food: FoodEntry // passed in food
    
    // EnvironmentObjects
    @EnvironmentObject var realmObject: RealmObject
    @EnvironmentObject var foodManager: FoodManager

    // local state variables
    @State private var du = DateUtility()
    @State var showEditModal = false
    

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(food.name)")
                    .font(.title)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("\(food.calories)")
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
            }
            
            Spacer()

            Text("\(du.formatDate(passedDate: food.date, dateStyle: .medium)) - \(du.formatTime(passedDate: food.date, timeStyle: .short))")
                .font(.subheadline)
                .foregroundColor(.black)
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding()
        .background(Color(red: 233.0/255, green: 236.0/255, blue: 239.0/255))
        .contentShape(Rectangle())
        .onTapGesture {
            showEditModal.toggle()
        }
        .fullScreenCover(isPresented: $showEditModal, content: {
            FoodEditModal(food: food, showEditModal: $showEditModal)
        })
    }//body
}//struct


/**
 * TopPeriodBar
 * Top bar to allow the user to change between their data fro Day, Week, and Month
 */
struct TopPeriodBar: View {

    // EnvironmentObjects
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject
    @EnvironmentObject var foodManager: FoodManager
    
    var selectedPeriod: Periods {
        self.foodManager.selectedPeriod
    }

    var body: some View {
        HStack {
            // DAY BTN
            Button(action: {
                if !foodManager.foodsList.isEmpty {
                    // NOTE: Since the goal feature wasn't fully implemented due to time constraints, requirement of a lot of personal information, a lot of calculations, and other factors needed to compute the goal values, would do something to show as in the below
//                    if status.currentGoal != nil {
////                        var totalAllottedCals = status.currentGoal?.weightGoal
//                    }

                    foodManager.filterForDay()
                    foodManager.calculateConsumedCalories()
                }
                

                self.foodManager.selectedPeriod = Periods.day
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
                if !foodManager.foodsList.isEmpty {
                    // NOTE: Since the goal feature wasn't fully implemented due to time constraints, requirement of a lot of personal information, a lot of calculations, and other factors needed to compute the goal values, would do something to show as in the below
//                    if status.currentGoal != nil {
////                        var totalAllottedCals = status.currentGoal?.weightGoal
//                    }
                    
                    foodManager.filterForWeek()
                    foodManager.calculateConsumedCalories()
                    
//                    foodManager.getWeekChartData()
                }
                
                self.foodManager.selectedPeriod = Periods.week
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
                if !foodManager.foodsList.isEmpty {
                    // NOTE: Since the goal feature wasn't fully implemented due to time constraints, requirement of a lot of personal information, a lot of calculations, and other factors needed to compute the goal values, would do something to show as in the below
//                    if status.currentGoal != nil {
////                        var totalAllottedCals = status.currentGoal?.weightGoal
//                    }
 
                    foodManager.filterForMonth()
                    foodManager.calculateConsumedCalories()

                    
                }
                
                self.foodManager.selectedPeriod = Periods.month
            }, label: {
                Text("Month")
                    .foregroundColor(.black)
                    .font(.title2)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            })
            .background(selectedPeriod == Periods.month ? Color(red: 173/255, green: 181/255, blue: 189/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
            .border(selectedPeriod == Periods.month ? Color(red: 108/255, green: 117/255, blue: 125/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
            
            
        }//hstack
        .frame(maxWidth: .infinity)
        .background(Color(red: 233/255, green: 236/255, blue: 239/255))
    }//body
}//struct
