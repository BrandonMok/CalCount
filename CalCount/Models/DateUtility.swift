
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
    
    // Gets the name of the month of the date passeds
    // source: https://stackoverflow.com/questions/55492003/how-can-i-find-current-month-name-and-current-month-number-in-swift
    func getMonthFromDate(passedDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: passedDate)
    }
    
    // Formats the date's time that was passed in with the desired style
    func formatTime(passedDate: Date, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = timeStyle
        return formatter.string(from: passedDate)
    }
    
    
    func convertDateToLocalTime(_ date: Date) -> Date {
            let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: date))
            return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: date)!
    }

}


// source: https://www.reddit.com/r/swift/comments/f8ai10/finding_start_and_end_of_current_week_gives_me/
extension Date {
    var startOfWeek: Date? {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        guard let startDay = gregorianCalendar.date(from: gregorianCalendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else {return nil}
        return gregorianCalendar.date(byAdding: .day, value: 1, to: startDay)
    }
    
    var endOfWeek: Date? {
       let gregorianCalendar = Calendar(identifier: .gregorian)
           guard let startDay = gregorianCalendar.date(from: gregorianCalendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
          return gregorianCalendar.date(byAdding: .day, value: 7, to: startDay)
    }
}
