

import Foundation

// Observable object to keep track if the modal's should show
// Can add food/water anywhere in app!
class ModalManager: ObservableObject {
    // property shared by FloatingMenu (has the button and actions) and the Food & water View
    @Published var showModal = false
    @Published var showCalorieModal = false
    @Published var showWaterModal = false
}
