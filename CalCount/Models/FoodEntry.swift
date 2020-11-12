
import Foundation
import RealmSwift

/**
 * FoodEntry Class
 * Class that represents a FoodEntry
 * Used & stored in realm -> therefore needs to extend Object
 */
class FoodEntry: Object {
    @objc dynamic var user: User? = User()
    @objc dynamic var name = ""
    @objc dynamic var calories = 0
    @objc dynamic var carbs = 0
    @objc dynamic var fat = 0
    @objc dynamic var protein = 0
    @objc dynamic var date = Date()
}
