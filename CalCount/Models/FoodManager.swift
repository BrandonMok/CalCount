
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
            let realm = try! Realm()
            let entries = realm.objects(FoodEntry.self)

            for food in entries {
                if food.user?.username == username {
                    self.foodsList.append(food)
                }
            }
            
            objectWillChange.send()
        }
    }
    
    // Published field to keep track of all of this user's food
    @Published var foodsList: [FoodEntry] = [FoodEntry]()
}//class
