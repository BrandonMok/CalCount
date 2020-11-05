
import Foundation
import RealmSwift

class RealmObject: ObservableObject {
    let configuration = Realm.Configuration(schemaVersion: 1)
    @Published var realm: Realm
    
    init() {
        realm = try! Realm(configuration: configuration)
        print("REALM FILE LOCATION: \(Realm.Configuration.defaultConfiguration.fileURL)")
    }
    
    // Other useful information possibly for later
    //                    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    //                    let realm = try! Realm(configuration: config)
    //                    let realm = try! Realm()

}
