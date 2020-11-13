
import Foundation
import RealmSwift

class FoodManager: ObservableObject {
    
    @Published var foodsList: [FoodEntry] = [FoodEntry]()
    
    init(username: String) {
        if username != "" && !username.isEmpty {
            // Get / load foodsList!
            let realm = try! Realm()
            let entries = realm.objects(FoodEntry.self)
            
            for food in entries {
                if food.user?.username == username {
                    foodsList.append(food)
                }
            }
            
            
            // could just have all the foodentries and return that
            // but not the best bc I only want this user's
        }
    }
}//class
