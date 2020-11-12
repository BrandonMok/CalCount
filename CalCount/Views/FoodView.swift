
import SwiftUI
import SwiftUICharts


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
    @EnvironmentObject var modalManager: ModalManager
    @EnvironmentObject var realmObj: RealmObject
    
    @State var selectedPeriod = Periods.day

    // FoodLists
    @State private var foodList = [FoodEntry]()     // main list (the one read in from Realm)
    @State private var foodListCopy = [FoodEntry]() // copied of the main list that's used on the display
    
    // Calulated fields 
    @State private var totalCalories = 0
    @State private var remainingCalories = 0

    
    var body: some View {
        VStack {
            // MARK: - TOP BAR (Day, Week, Month)
            TopPeriodBar(selectedPeriod: $selectedPeriod, foodList: $foodList, foodListCopy: $foodListCopy, totalCalories: $totalCalories, remainingCalories: $remainingCalories)
            
            VStack {
                if selectedPeriod == Periods.day {
                    // TODO: - Make chart use my data!!
                    PieChartView(data: [10,20], title: "Calories")
                        .frame(maxWidth: .infinity)
                }
//                else if selectedPeriod == Periods.week {
//                      // change type of chart
//                }
//                else if selectedPeriod == Periods.month {
//                      // change type of chart
//                }
                
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
                if !foodListCopy.isEmpty {
                    List(foodListCopy, id: \.self) { food in
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
            .onAppear(perform: {
                // Get all of this user's Food Entries!
                
                
                // ISSUE: On appear occurs everytime you go to the tab
                // TODO!!
                // MIGHT need to keep a global for the array?
                
                let foodObjs =  realmObj.realm.objects(FoodEntry.self)
                
                if (foodObjs.count != 0) {
                    foodObjs.forEach { food in
                        if food.user!.username == status.currentUser.username {
                            foodList.append(food)
                        }
                    }
                    
                    foodListCopy = foodList // reserve a copy of all foods, will modify foodLIstCopy when determining either day, week, or month foods
                }
            })//onAppear
            
        }//vstack        
    }//body
}//struct

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
    }
}


struct FoodRow: View {
    var food: FoodEntry
    
    var body: some View {
        VStack {
            HStack {
                Text("\(food.name)")
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                
                Text("\(food.calories)")
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                    
            }
//            HStack {
////                Text(food.date)
//            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding()
    }
}



struct TopPeriodBar: View {
    @Binding var selectedPeriod: Periods
    @EnvironmentObject var status: LoggedInStatus
    @EnvironmentObject var realmObj: RealmObject

    @Binding var foodList: [FoodEntry]
    @Binding var foodListCopy: [FoodEntry]
    @Binding var totalCalories: Int
    @Binding var remainingCalories:Int

    
    var body: some View {
        HStack {
            // DAY BTN
            Button(action: {
                // Filter foodList by Date for today
                // ON each btn click, always set foodListCopy = foodList
                    // bc based on foodListCopy && .filter returns a new array
            
                
                
                // ALSO need to calculate the total calories
                
                
                
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
                // TODO get users data on calories/food for the week
                
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
            .border(selectedPeriod == Periods.month ? Color(red: 108/255, green: 117/255, blue: 125/255) : Color(red: 233/255, green: 236/255, blue: 239/255))
            
            
        }//hstack
        .frame(maxWidth: .infinity)
        .background(Color(red: 233/255, green: 236/255, blue: 239/255))
    }
}

