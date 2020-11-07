

import Foundation

// Observable object to keep track if the modal's should show
// Can add food/water anywhere in app!
class ModalManager: ObservableObject {
    @Published var showCalorieModal = false
    @Published var showWaterModal = false
}
