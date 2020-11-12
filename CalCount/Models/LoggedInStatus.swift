
import Foundation

/**
 * LoggedInStatus class
 * An observable object used to store user / application specific information (e.g. loggedin, who the current user is, and if they have goals)
 */
class LoggedInStatus: ObservableObject {
    @Published var loggedIn = false
    @Published var currentUser = User()
    @Published var currentGoal: Goal? = Goal()
}
