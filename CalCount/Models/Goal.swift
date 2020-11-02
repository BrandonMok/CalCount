
import Foundation
import RealmSwift

class Goal: Object {
    @objc dynamic var user: User? = User()
    @objc dynamic var weightGoal = "None"
    @objc dynamic var waterGoal = "None"
}
