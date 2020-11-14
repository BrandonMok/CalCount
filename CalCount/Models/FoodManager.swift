
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
                    print("in the !contains")
                    foodsList.append(food)
                }
            }
        }//for
        
        foodsListCopy = foodsList
    }
}//class
