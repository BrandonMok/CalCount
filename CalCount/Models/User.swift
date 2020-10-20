
import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var username: String
    @objc dynamic var password: String
    @objc dynamic var gender: String
    
    init(username: String, password: String, gender: String){
        self.username = username
        self.password = password
        self.gender = gender
    }
    
    override required init() {
        fatalError("init() has not been implemented")
    }
    
    
    func getUsername() -> String { username }
    func set(uname: String) {
        self.username = uname
    }
    
    func getPassword() -> String { password }
    func set(pword: String) {
        self.password = pword
    }
    
    func getGender() -> String { gender }
    func set(gender: String) {
        self.gender = gender
    }
}
