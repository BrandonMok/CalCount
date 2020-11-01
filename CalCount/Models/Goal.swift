
import Foundation
import RealmSwift

class Goal: Object {
    @objc dynamic var user: User? = User()
    @objc dynamic var weightGoal = ""
    @objc dynamic var waterGoal = ""
}
