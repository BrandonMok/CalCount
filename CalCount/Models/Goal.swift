
import Foundation
import RealmSwift

/**
 * Goal Class
 * Class that represents a goal object of a user
 * Used & stored in realm -> therefore needs to extend Object
 */
class Goal: Object {
    @objc dynamic var user: User? = User()
    @objc dynamic var weightGoal = "None"
    @objc dynamic var waterGoal = "None"
}
