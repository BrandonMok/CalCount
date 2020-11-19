
import Foundation
import RealmSwift

/**
 * RealmObject Class
 * An observable object that is a reusable instance of realm
 */
class RealmObject: ObservableObject {
    
    @Published var realm: Realm
    
    init() {
//        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//        realm = try! Realm(configuration: config)
        
        realm = try! Realm()
        print("REALM FILE LOCATION: \(Realm.Configuration.defaultConfiguration.fileURL)")
    }
}
