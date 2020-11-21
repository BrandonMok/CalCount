
import Foundation
import RealmSwift

/**
 * WaterEntry
 * Class that represents a water entry / water log
 */
class WaterEntry: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var user: User? = User()
    @objc dynamic var amount = 0
    @objc dynamic var date = Date()
}

