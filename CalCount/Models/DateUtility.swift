
import Foundation

/*
 * DateUtility
 * Custom class with useful & reusable functions for dates
 */
class DateUtility {
    
    // Formats the date passed in with the desired style
    func formatDate(passedDate: Date, dateStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        return formatter.string(from: passedDate)
    }
    
    // Formats the date's time that was passed in with the desired style
    func formatTime(passedDate: Date, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = timeStyle
        return formatter.string(from: passedDate)
    }
}
