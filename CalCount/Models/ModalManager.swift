

import Foundation

/**
 * ModalManager Class
 * An observable object used to determine which modal to show and if it should be shown
 * Used in both the FAB button actions & the individual  Food / Home tab and Water tab
 */
class ModalManager: ObservableObject {
    // property shared by FloatingMenu (has the button and actions) and the Food & water View
    @Published var showModal = false
    @Published var showCalorieModal = false
    @Published var showCalorieEditModal = false
    @Published var showWaterModal = false
}
