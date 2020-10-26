
import Foundation

class LoggedInStatus: ObservableObject {
    @Published var loggedIn = false
    var currentUser = User()
}
