
import Foundation
import RealmSwift

/**
 * FoodManager
 * Class to load and keep track of all this user's food entries
 */
class FoodManager: ObservableObject {

    // Username
    // Is set on login as it take the username of the current user
    // Used to know which FoodEntry data is there's and only use theirs
    var username: String = "" {
        didSet {
            updateFoodsList()
            objectWillChange.send()
        }
    }
    
    @Published var foodsList: [FoodEntry] = [FoodEntry]()       // The MAIN food list - used to be filtered on
    @Published var foodsListCopy: [FoodEntry] = [FoodEntry]()   // A copy of the food list that will use the main foodsList to filter upon (allows the original to be preserved)
    @Published var totalCals = 0
    @Published var selectedPeriod = Periods.day
    
    
    /*
     * updateFoodsList
     * Gets the FoodEntry(s) that this user created
     */
    func updateFoodsList() {
        let realm = try! Realm()
        let entries = realm.objects(FoodEntry.self)

        for food in entries {
            if food.user?.username == username {
                if !foodsList.contains(where: {$0.name == food.name}) {
                    foodsList.append(food)
                }
            }
        }
        
        foodsListCopy = foodsList
    }
    
    /**
     * calculateConsumedCalories
     * @return Int
     * Calculates the total consumed calories based on the foodsListCopy
     * The foodsListCopy is an array that's a filtered version of the foodsList for the specific/chosen time period (e.g. Day, Week, Month)
     */
    func calculateConsumedCalories() -> Int {
        var total = 0
        
        for food in foodsListCopy {
            total += food.calories
        }
        
        totalCals = total
        return total
    }
    
    
    
    /** MARK: - Filter functions */
    
    /**
     * filterForDay
     * Filtering function to filter food entries based on day
     */
    func filterForDay() {
        foodsListCopy = foodsList.filter {  Calendar.current.isDateInToday($0.date) }
        foodsListCopy.sort(by: {$0.date < $1.date })
    }
    
    /**
     * filterForWeek
     * Filtering function to filter food entries based on week
     */
    func filterForWeek() {
        foodsListCopy = foodsList.filter {  Calendar.current.compare(Date(), to: $0.date, toGranularity: .weekOfYear) == .orderedSame }
        foodsListCopy.sort(by: {$0.date < $1.date })
    }
    
    /**
     * filterForMonth
     * Filtering function to filter food entreis based on moth
     */
    func filterForMonth() {
        foodsListCopy = foodsList.filter {  Calendar.current.compare(Date(), to: $0.date, toGranularity: .month) == .orderedSame }
        foodsListCopy.sort(by: {$0.date < $1.date })
    }
    
    
    /**
     * getDayChartData()
     */
    func getDayChartData() -> [Double] {
        return [Double(calculateConsumedCalories())];
    }

//    func getWeekChartData() -> [Double] {
//        // [value, value] each value in the array will be the total for each day of the week
//        var weekFoodArr: [Double] = []
//        var day: Date? = nil
//
//        for food in foodsListCopy {
//            if day == nil {
//                day = food.date
//
//
//
//            }
//            else {
//                // check if the saved day is the same, if not change it
//
//
//
//            }
//
////            if Calendar.current.dateComponents([.day], from: )
//
//
//
//            weekFoodArr.append(Double(food.calories))
//        }
//        return weekFoodArr
//    }

//    func getMonthChartData() -> [Double] {
//        // [value, value] each value in the array will be the total for each day of the month
//        var monthFoodArr: [Double] = []
//
//        for food in foodsListCopy {
//          // group by day?
//        }
//
//    }
}//class
