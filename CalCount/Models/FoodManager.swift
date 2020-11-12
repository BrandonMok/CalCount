
import Foundation
import RealmSwift

class FoodManager: ObservableObject {
    
    // WANT ONE AREA TO BE IN CHARGE OF THE FOOD ENTRY DATA
    // BUT DON'T HAVE ACCESS TO ENVRIONMENT OBJECTS BC IT'S A CLASS
    
    // NEED REALM
    // NEED LoggedInStatus
    
    // What happens if you pass in the instances of the realmObject && status?
    
    // OR have a field for current user too, and then on login set it as int FoodManager().field = username
    
    @Published var foodsList: [FoodEntry] = [FoodEntry]()
    
    init() {
        // Get / load foodsList!
        let realm = try! Realm()
        let entries = realm.objects(FoodEntry.self)
        
        
        
        
        
    }
}
