
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
    
    
    /*
     * updateFoodsList
     * Function that acts as both a GETTER and an UPDATER
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
        }//for
        
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
        
        return total
    }
    
    
    
    func getDayChartData() -> [Double] {
        return [Double(calculateConsumedCalories())];
    }

//    func getWeekChartData() -> [Double] {
//        // [value, value] each value in the array will be the total for each day of the week
//        var weekFoodArr: [Double] = []
//        var day: Date? = nil
//        
////        let test = Dictionary(grouping: foodsListCopy) { $0.date }
////        print("TEST: \(test)")
//
////        for food in foodsListCopy {
////            // need to check if the first date is the same as the 2nd date
//////            if day == nil {
//////                day = food.date
//////            }
//////            else {
//////
//////            }
////
////
//////            if Calendar.current.dateComponents([.day], from: )
////
////
////
////            weekFoodArr.append(Double(food.calories))
////        }
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
