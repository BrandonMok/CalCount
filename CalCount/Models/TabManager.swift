

import Foundation

/*
 * Tabs ENUM
 * Used for the Tabs navigation
 */
enum Tabs: Hashable {
    case home
    case water
    case nutrition
    case settings
}

/**
 * TabManager Class
 * An observable object that manages and keeps track of the current tab
 */
class TabManager: ObservableObject {
    @Published var selectedTab = Tabs.home
}
