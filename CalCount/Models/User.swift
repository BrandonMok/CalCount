
import Foundation
import RealmSwift
import CryptoKit

class User: Object, Identifiable {
    // REALM doesn't allow for init for parameters to be passed when creating object
    // Only seems like to set each field have to do .field = value for ALL
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var gender: String = ""
}
