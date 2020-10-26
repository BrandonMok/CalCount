

import Foundation

// enum for tab navigation
enum Tabs: Hashable {
    case home
    case water
    case nutrition
    case settings
}


class TabManager: ObservableObject {
    @Published var selectedTab = Tabs.home
}
