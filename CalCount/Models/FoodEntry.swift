
import Foundation
import RealmSwift

class FoodEntry: Object {
    @objc dynamic var user: User? = User()
    @objc dynamic var calories = 0
    @objc dynamic var carbs = 0
    @objc dynamic var fat = 0
    @objc dynamic var protein = 0
    @objc dynamic var date = Date()
}
