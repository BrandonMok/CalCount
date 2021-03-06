

import Foundation
import RealmSwift

/**
 * WaterManager
 * Class to load and keep track of all the water log entries
 */
class WaterManager: ObservableObject {
    @Published var waterList: [WaterEntry] = [WaterEntry]()
    @Published var totalConsumed: Int = 0
    
    // Username
    // Is set on login as it take the username of the current user
    // Used to know which FoodEntry data is there's and only use theirs
    var username: String = "" {
        didSet {
            updateWaterList()
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
        
        for water in entries {
            if water.user?.username == username {
                if !waterList.contains(where: {$0.id == water.id}) && Calendar.current.isDateInToday(water.date) {
                    waterList.append(water)
                }
            }
        }
        
        waterList = waterList.sorted(by: { $0.date < $1.date })
        calculateConsumedWater()
    }
    
    /**
     * calculateConsumedWater
     * @return Int
     * Calculates the total consumed water(oz)
     */
    func calculateConsumedWater() {
        var total = 0
        for water in waterList {
            total += water.amount
        }
        totalConsumed = total
    }
}
