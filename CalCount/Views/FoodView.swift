
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
    
    // Selected Time Period of data to see (e.g. Day, Week, Month)
    @State var selectedPeriod = Periods.day
    
//    @State var tappedFood: FoodEntry?
    @State var showEditModal = false    // so issue, using modal manager triggers on the FloatingMenu (where FAB is) but need to pass in food to edit modal
    
    
    // Calulated fields 
    @State private var totalCalories = 0
    @State private var remainingCalories = 0

    
    var body: some View {
        VStack {
            // MARK: - TOP BAR (Day, Week, Month)
            TopPeriodBar(selectedPeriod: $selectedPeriod, totalCalories: $totalCalories, remainingCalories: $remainingCalories)
            
            ScrollView {
                VStack {
                    // Top Chart to display data
                    if selectedPeriod == Periods.day {
                        // TODO: - Make chart use my data!!
                        // Data will be consumed? - have to loop at what data is accepts (i.e. total and then entries?)
                        PieChartView(data: [10,20], title: "Calories")
                            .frame(maxWidth: .infinity)
                    }
    //                else if selectedPeriod == Periods.week {
    //                      // change type of chart
    //                }
    //                else if selectedPeriod == Periods.month {
    //                      // change type of chart
    //                }
                    
                    // HStack with the calculated calories & remainder
                    HStack {
                        VStack{
                            Text("\(totalCalories)")
                                .font(.largeTitle)
                            
                            Text("Total")
                                .font(.title)
                                .bold()
                        }
                        .padding()
                        
                        VStack {
                            Text("\(remainingCalories)")
                                .font(.largeTitle)
                            
                            Text("Remaining")
                                .font(.title)
                                .bold()
                        }
                        .padding()
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
                        ForEach(foodManager.foodsListCopy, id: \.self) { food in
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
                .onReceive(foodManager.$foodsList, perform: { _ in
                    // SAME as the Day btn action, BUT needed the data to show initially even w/o having clicked the button!
                    foodManager.foodsListCopy = foodManager.foodsList.filter {  Calendar.current.isDateInToday($0.date) }
                    foodManager.foodsListCopy.sort(by: {$0.date < $1.date })

                    totalCalories = foodManager.calculateConsumedCalories()
                })
            }//ScrollView
            .padding(.bottom, 20)
        }//outter vstack
    }//body
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
    // EnvironmentObjects
    @EnvironmentObject var realmObject: RealmObject
    @EnvironmentObject var foodManager: FoodManager
    
    var food: FoodEntry // passed in food
    
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

            Text("\(du.formatDate(passedDate: food.date, dateStyle: .medium )) - \(du.formatTime(passedDate: food.date, timeStyle: .short))")
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
    
    // Binding - passed in value
    @Binding var selectedPeriod: Periods
    @Binding var totalCalories: Int
    @Binding var remainingCalories: Int

    
    var body: some View {
        HStack {
            // DAY BTN
            Button(action: {
                if !foodManager.foodsList.isEmpty {
                    // TODO: Need to know what / how many calories should be set for the goal
                    // Calculate for gender how many calories gain or lose weight should be
                    // MAYBE have a custom input option?
//                    if status.currentGoal != nil {
////                        var totalAllottedCals = status.currentGoal?.weightGoal
//                    }

                    foodManager.foodsListCopy = foodManager.foodsList.filter {  Calendar.current.isDateInToday($0.date) }
                    foodManager.foodsListCopy.sort(by: {$0.date < $1.date })
                    
                    totalCalories = foodManager.calculateConsumedCalories()
                }
                

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
                if !foodManager.foodsList.isEmpty {
                    // TODO: Need to know what / how many calories should be set for the goal
                    // Calculate for gender how many calories gain or lose weight should be
                    // MAYBE have a custom input option?
//                    if status.currentGoal != nil {
////                        var totalAllottedCals = status.currentGoal?.weightGoal
//                    }
                    
                    foodManager.foodsListCopy = foodManager.foodsList.filter {  Calendar.current.compare(Date(), to: $0.date, toGranularity: .weekday) == .orderedSame }
                    
                    foodManager.foodsListCopy.sort(by: {$0.date < $1.date })
                    
                    totalCalories = foodManager.calculateConsumedCalories()
                }
                
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
                if !foodManager.foodsList.isEmpty {
                    // TODO: Need to know what / how many calories should be set for the goal
                    // Calculate for gender how many calories gain or lose weight should be
                    // MAYBE have a custom input option?
//                    if status.currentGoal != nil {
////                        var totalAllottedCals = status.currentGoal?.weightGoal
//                    }
 
                    
                    foodManager.foodsListCopy = foodManager.foodsList.filter {  Calendar.current.compare(Date(), to: $0.date, toGranularity: .month) == .orderedSame }
                    foodManager.foodsListCopy.sort(by: {$0.date < $1.date })
                    
                    totalCalories = foodManager.calculateConsumedCalories()
                }
                
                
                selectedPeriod = Periods.month
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



/**
 * Extension Date
 * Check to see if a date is within the current week
 */
extension Date {
    func isInSevenDays() -> Bool {
        let now = Date()
        let calendar = Calendar.current
        let weekday = calendar.dateComponents([.weekday], from: now)
        let startDate = calendar.startOfDay(for: now)
        let nextWeekday = calendar.nextDate(after: now, matching: weekday, matchingPolicy: .nextTime)!
        let endDate = calendar.date(byAdding: .day, value: 1, to: nextWeekday)!
        return self >= startDate && self < endDate
    }
}
