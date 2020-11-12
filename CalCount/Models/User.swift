
import Foundation
import RealmSwift

/**
 * User Class
 * Class that represents a user of the app
 * Used & stored in realm -> therefore needs to extend Object
 */
class User: Object, Identifiable {
    // REALM doesn't allow for init for parameters to be passed when creating object
    // Only seems like to set each field have to do .field = value for ALL
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var gender: String = ""
}
