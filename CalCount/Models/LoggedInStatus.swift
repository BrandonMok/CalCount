
import Foundation

class LoggedInStatus: ObservableObject {
    @Published var loggedIn = false
    @Published var currentUser = User()
}
