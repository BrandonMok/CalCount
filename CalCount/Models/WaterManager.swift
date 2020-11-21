

import Foundation
import RealmSwift

/**
 * WaterManager
 * Class to load and keep track of all the water log entries
 */
class WaterManager: ObservableObject {
    @Published var waterList: [WaterEntry] = [WaterEntry]()
    
    // Username
    // Is set on login as it take the username of the current user
    // Used to know which FoodEntry data is there's and only use theirs
    var username: String = "" {
        didSet {
//            updateFoodsList()
            objectWillChange.send()
        }
    }
    
    /*
     * updateWaterList
     * Function that acts as both a GETTER and an UPDATER
     * Gets the WaterEntry(s) that this user created
     */
    func updateWaterList() {
        let realm = try! Realm()
        let entries = realm.objects(WaterEntry.self)
        var tempWaterList: [WaterEntry] = []
        
        for water in entries {
            if water.user?.username == username {
                if !waterList.contains(where: {$0.id == water.id}) {
                    tempWaterList.append(water)
                }
            }
        }
        
        waterList = tempWaterList.sorted(by: { $0.date < $1.date })
    }
}
