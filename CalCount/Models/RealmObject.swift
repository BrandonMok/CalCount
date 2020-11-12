
import Foundation
import RealmSwift

/**
 * RealmObject Class
 * An observable object that is a reusable instance of realm
 */
class RealmObject: ObservableObject {
    
    // Published field referencing the Realm instance
    @Published var realm: Realm
    
    init() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        realm = try! Realm(configuration: config)
        print("REALM FILE LOCATION: \(Realm.Configuration.defaultConfiguration.fileURL)")
    }
    
    
    
    // Other useful information possibly for later
    //                    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    //                    let realm = try! Realm(configuration: config)
    //                    let realm = try! Realm()

}
