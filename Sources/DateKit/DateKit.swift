// The Swift Programming Language
// https://docs.swift.org/swift-book
import UIKit
import Foundation

extension Date {
    
    /// use this only for UTC timezone.
    private static let dateFormatter = DateFormatter()
    
    /// UTC as Int64
    static var currentTimeStamp: Int64 {
        return Int64(Date().timeIntervalSince1970)
    }
    
    /// Todo - We are taking integer string input for this?
    /// - Parameter strTimeStamp:
    /// - Returns:
    static func dateFromTimeStamp(_ strTimeStamp: String) -> Date {
        let timeStamp = TimeInterval(Int(strTimeStamp) ?? 0)
        return Date(timeIntervalSince1970: timeStamp)
    }
    
    /// Todo - This can be refactored as we have one which take format as input.
    /// - Parameter date:
    /// - Returns:
    static func getAppDateSectionString(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    static func convertStringToStringFormat(dateString: String,
                                            fromFormat: String,
                                            toFormat: String) -> String {
        let myDateString = dateString
        dateFormatter.dateFormat = fromFormat
        // swiftlint:disable:next force_cast
        let myDate = dateFormatter.date(from: myDateString)!
        dateFormatter.dateFormat = toFormat
        let somedateString = dateFormatter.string(from: myDate)
        return somedateString
    }
    
    static func getDateFromStringWithUTC(date: String) -> Date {
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "dd MMM yyyy"
        // swiftlint:disable:next force_cast
        return dateFormatter.date(from: date)!
    }
    
    static func getDateFromStringWithUTCWithFormat(date: String, formate: String) -> Date {
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = formate
        
        // swiftlint:disable:next force_cast
        return dateFormatter.date(from: date)!
    }
    
    static func getDateFromStringRemovingMillis(_ dateString: String, formate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        // Addded this as the date from server some times does not have milli seconds in it.
        if formate == DateConstant.KServertDateFormate {
               var dateArr: [String] = dateString.components(separatedBy: ".")
               if dateArr.count > 1 {
                   dateArr.removeLast()  // Remove milliseconds
               }
               return formatter.date(from: dateArr.joined(separator: ""))
           }
        return formatter.date(from: dateString)
    }
    
    static func getDateFromString(_ dateString: String, formate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        // Addded this as the date from server some times does not have milli seconds in it.
        if formate == DateConstant.KServertDateFormate {
            var dateArr: [String] = dateString.components(separatedBy: ".")
            if dateArr.count > 1 {
                dateArr.removeLast()
            } else {
                return formatter.date(from: String(dateArr.joined(separator:"").dropLast())+".000Z")
            }
            return formatter.date(from: dateArr.joined(separator:"")+".000Z")
        }
        return formatter.date(from: dateString)
    }
    
    static func getDateWithRegionFromString(_ dateString: String, formate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        let customLocale = Locale(identifier: Locale.current.identifier)
        let customTimezone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.locale = customLocale
        formatter.timeZone = customTimezone
        // Addded this as the date from server some times does not have milli seconds in it.
        if formate == DateConstant.KServertDateFormate {
            var dateArr: [String] = dateString.components(separatedBy: ".")
            if dateArr.count > 1 {
                dateArr.removeLast()
            } else {
                return formatter.date(from: String(dateArr.joined(separator:"").dropLast())+".000Z")
            }
            return formatter.date(from: dateArr.joined(separator:"")+".000Z")
        }
        return formatter.date(from: dateString)
    }
    
    static func convertDateString(_ dateString: String, fromFormat: String, toFormat: String) -> String? {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = fromFormat
          guard let date = dateFormatter.date(from: dateString) else {
              return nil
          }
          
          dateFormatter.dateFormat = toFormat
          return dateFormatter.string(from: date)
      }
    
    static func getDateFromStringWithRegionViaFormat(_ dateString: String, formate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        formatter.locale = Locale(identifier: Locale.current.identifier)
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        // Addded this as the date from server some times does not have milli seconds in it.
        if formate == DateConstant.KServertDateFormate {
            var dateArr: [String] = dateString.components(separatedBy: ".")
            if dateArr.count > 1 {
                dateArr.removeLast()
            } else {
                return formatter.date(from: String(dateArr.joined(separator:"").dropLast())+".000Z")
            }
            return formatter.date(from: dateArr.joined(separator:"")+".000Z")
        }
        return formatter.date(from: dateString)
    }
    
    static func getDateFromStringWithUTCViaFormat(_ dateString: String, formate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = formate
        // Addded this as the date from server some times does not have milli seconds in it.
        if formate == DateConstant.KServertDateFormate {
            var dateArr: [String] = dateString.components(separatedBy: ".")
            if dateArr.count > 1 {
                dateArr.removeLast()
            } else {
                return formatter.date(from: String(dateArr.joined(separator:"").dropLast())+".000Z")
            }
            return formatter.date(from: dateArr.joined(separator:"")+".000Z")
        }
        return formatter.date(from: dateString)
    }
    
   static func timeDifferenceString(to date: Date) -> String {
       var present = Date().getStringFromDate(formate: DateConstant.KUTCDateTimeFormate)
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = DateConstant.KUTCDateTimeFormate
       dateFormatter.timeZone = TimeZone(identifier: "GMT")
       
       let convertedDate = dateFormatter.date(from: present) ?? Date()
           let calendar = Calendar.current
           let difference = calendar.dateComponents([.hour, .minute, .second], from: date, to: convertedDate)
           let formattedString = String(format: "%02ld:%02ld:%02ld", difference.hour ?? 0, difference.minute ?? 0, difference.second ?? 0)
           return formattedString
       
       }
       
    static func timeInterval(to date: Date) -> TimeInterval {
        let deviceTime = Date().getStringFromDate(formate: DateConstant.KUTCDateTimeFormate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateConstant.KUTCDateTimeFormate
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        
        let convertedDate = dateFormatter.date(from: deviceTime) ?? Date()
     
           let calendar = Calendar.current
           let difference = calendar.dateComponents([.hour, .minute, .second], from: date, to: convertedDate)
           let hours = (difference.hour ?? 0) * 3600
           let minutes = (difference.minute ?? 0) * 60
           let seconds = (difference.second ?? 0)
           return TimeInterval(hours + minutes + seconds)
       }
    
    static func getDateForAdjustment(strDate: String, from: String , toFormat: String) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = from
        let date: Date = dateFormatterGet.date(from: strDate)!
        return date
    }
    
    static func getDateStringToString(strDate:String, formate: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = DateConstant.kDateFormatddMMyyyyfull
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formate
        let date: Date = dateFormatterGet.date(from: strDate)!
        return dateFormatterPrint.string(from: date)
    }
    
    static func getDateString(strDate: String, formate: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = DateConstant.KServertDateFormateclockin
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formate
        let date: Date = dateFormatterGet.date(from: strDate)!
        return dateFormatterPrint.string(from: date)
    }
    
    static func getStringFromDate(date: Date, formate: String) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formate
        return dateFormatterPrint.string(from: date)
    }

    static func getStringFromDate2(date: Date, formate: String) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formate
        return dateFormatterPrint.string(from: date)
    }
    
   static func formattedTimeString(_ time: TimeInterval) -> String {
        let hours = Int(time / 3600)
        let minutes = Int((time.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    func getStringFromDate(formate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        return formatter.string(from: self)
    }
    
    func getStringFromUTCDate(formate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: self)
    }
    
    static func getCurrentDate(formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentTimestamp(formate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let date = getCurrentDate(formate: formate)
        return dateFormatter.date(from: date) ?? Date()
    }
   
    static func getCurrentRegionDate(formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return dateFormatter.string(from: Date())
    }
    
    func getRegionStringFromDate(formate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        formatter.locale = Locale(identifier: Locale.current.identifier)
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
    
    static func getCurrentRegionTimestamp(formate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        let date = getCurrentRegionDate(formate: formate)
        return dateFormatter.date(from: date) ?? Date()
    }
    
    func getWeekNumberOfMonth() -> String {
        let dateToFind = Int(self.getStringFromDate(formate: "dd"))
        let _ = Date.getCurrentDate(formate: "yyyy")
        let calendar = Calendar(identifier: .gregorian)
        for day in 1 ... 31 {
            let date = calendar.date(
                from: DateComponents(
                    era: 1,
                    year: Int(Date.getCurrentDate(formate: "yyyy")),
                    month: Int(Date.getCurrentDate(formate: "MM")),
                    day: day,
                    hour: 12,
                    minute: 0,
                    second: 0
                )
            )!
            if dateToFind == day {
                let weekNumber = calendar.component(.weekOfMonth, from: date)
                if weekNumber == 1 {
                    return "first week"
                } else if weekNumber == 2 {
                    return "second week"
                } else if weekNumber == 3 {
                    return "third week"
                } else if weekNumber == 4 {
                    return "fourth week"
                } else if weekNumber == 5 {
                    return "fifth week"
                } else if weekNumber == 6 {
                    return "sixth week"
                }
            }
        }
        return ""
    }
    
    func isEqualTo(_ date: Date) -> Bool {
        return self == date
    }
    
    func isGreaterThanEqual(_ date: Date) -> Bool {
        return self >= date
    }
    
    func isSmallerThanEqual(_ date: Date) -> Bool {
        return self <= date
    }
    
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    func addedDay(by value: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: value, to: self) ?? Date()
    }
    
    mutating func addOneDay(value: Int) {
        self = Calendar.current.date(byAdding: .day, value: value, to: self) ?? Date()
    }
    
    func timeAgo(showTime:Bool) -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        if unit == "second" || unit == "min" || unit == "hour" {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = DateConstant.KDateFormathhMMa
            return "today at \(dateFormatterPrint.string(from: self))"
        } else if unit == "day" && quotient == 1 {
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = DateConstant.KDateFormathhMMa
            return "yesterday at \(dateFormatterPrint.string(from: self))"
        } else {
            let dateFormatterPrint1 = DateFormatter()
            dateFormatterPrint1.dateFormat = DateConstant.KDateFormatddMMMyyyy
            if showTime {
                let dateFormatterPrint2 = DateFormatter()
                dateFormatterPrint2.dateFormat = DateConstant.KDateFormathhMMa
                return "on \(dateFormatterPrint1.string(from: self)) at \(dateFormatterPrint2.string(from: self))"
            } else {
                
                return "on \(dateFormatterPrint1.string(from: self))"
            }
        }
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: startDay)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let startDay = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: startDay)
    }
    
    var weekOfTheDay: Date {
        return Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    }
    
    func getMonth(month: Int) -> Date {
        let date = Calendar.current.date(byAdding: .month, value: month, to: Date()) ?? Date()
        return date
    }
    
    func convertDateToDateTime(date: Date, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        var dateComponents = DateComponents()
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = components.day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second

        return calendar.date(from: dateComponents) ?? Date()
    }
    
    
    func replaceDate(of originalDate: Date, with newDate: Date) -> Date? {
        let calendar = Calendar.current
        
        // Extract time components from the original date
        let originalTimeComponents = calendar.dateComponents([.hour, .minute, .second], from: originalDate)
        
        // Extract date components from the new date
        let newDateComponents = calendar.dateComponents([.year, .month, .day], from: newDate)
        
        // Combine date components of new date with time components of original date
        var combinedDateComponents = DateComponents()
        combinedDateComponents.year = newDateComponents.year
        combinedDateComponents.month = newDateComponents.month
        combinedDateComponents.day = newDateComponents.day
        combinedDateComponents.hour = originalTimeComponents.hour
        combinedDateComponents.minute = originalTimeComponents.minute
        combinedDateComponents.second = originalTimeComponents.second
        
        // Create a new date with combined components
        return calendar.date(from: combinedDateComponents)
    }
    
    func hoursAndMinutesToTime(hours: Int, minutes: Int, date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        var dateComponents = DateComponents()
        dateComponents.year = components.year
        dateComponents.month = components.month
        dateComponents.day = components.day
        dateComponents.hour = hours
        dateComponents.minute = minutes

        return calendar.date(from: dateComponents) ?? Date()
    }

    func extractHoursAndMinutes() -> (hours: Int, minutes: Int)? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: self)
        
        if let hours = components.hour, let minutes = components.minute {
            return (hours, minutes)
        }
        return nil
    }
    
    func getPreviousDayDate(date: String) -> String {
        let converteddate = Date.getDateFromString(date, formate: DateConstant.KDateFormatyyyyMMddWithDash) ?? Date()
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: converteddate) ?? Date()
        let formattedDate = Date.getStringFromDate(date: previousDate, formate: DateConstant.KDateFormatyyyyMMddWithDash)
        return Date().getDateWithUnknownFormat(date: formattedDate, format: DateConstant.KDateFormatyyyyMMddWithDash)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    func minute(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    func isSame(inTermsOf components: Set<Calendar.Component>, as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(components, from: self)
        let otherDateComponents = calendar.dateComponents(components, from: otherDate)
        return dateComponents == otherDateComponents
    }
    
    func components(_ components: Set<Calendar.Component>) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents(components, from: self)
    }
    
    func abbreviatedMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self) ?? ""
    }
    
    func removeYear() -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let components = calendar.dateComponents([.month, .day], from: self)
        let currentYear = calendar.component(.year, from: Date())

        var dateComponents = DateComponents()
        dateComponents.year = currentYear
        dateComponents.month = components.month
        dateComponents.day = components.day

        return calendar.date(from: dateComponents)
    }
    
    func difference(from endDate: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: endDate, to: self)
        return components
    }
    
    func isFirstTimeGreater(date1: Date, date2: Date) -> Bool {
        let time1 = 60*Calendar.current.component(.hour, from: date1) + Calendar.current.component(.minute, from: date1)
        let time2 =  60*Calendar.current.component(.hour, from: date2) + Calendar.current.component(.minute, from: date2)
        return time2 >= time1
    }
    
    static func getDateFromUnknownFormat(date: String, format: String) -> Date {
        let date = Date().getDateWithUnknownFormat(date: date, format: format)
        let convertedDate = Date.getDateFromString(date, formate: format) ?? Date()
        return convertedDate
    }
    
    func getDateWithUnknownFormat(date: String, format: String) -> String {
        let dateFormatterGet = DateFormatter()
        let customLocale = Locale(identifier: Locale.current.identifier)
        let customTimezone = TimeZone(identifier: TimeZone.current.identifier)
        dateFormatterGet.locale = customLocale
        dateFormatterGet.timeZone = customTimezone
           let formatsToTry = [
            DateConstant.KServertDateFormateclockin,
            DateConstant.kDateFormatddMMyyyyfull,
            DateConstant.KServertDateFormate,
            DateConstant.KUTCDateTimeFormate,
            DateConstant.KApplicationDateFormateForChat,
            DateConstant.KApplicationDescriptiveDateFormate,
            DateConstant.KApplicationTimeFormate,
            DateConstant.KDateFormatddMMMyyyy,
            DateConstant.KApplicationDateFormateForShiftClockin,
            DateConstant.KDateFormathhSSa,
            DateConstant.KDateFormathhmmssa,
            DateConstant.KServertDateFormateThird,
            DateConstant.kServerDateLog,
            DateConstant.KDateTimeFormat
           ]
    
           for formatToTry in formatsToTry {
               dateFormatterGet.dateFormat = formatToTry
               if let dateFormatted = Date.getDateFromStringRemovingMillis(date, formate: formatToTry ) {
                   let dateFormatterPrint = DateFormatter()
                   dateFormatterPrint.dateFormat = format
                   dateFormatterPrint.locale = Locale(identifier: Locale.current.identifier)
                   dateFormatterPrint.timeZone = TimeZone(identifier: TimeZone.current.identifier)
                   return dateFormatterPrint.string(from: dateFormatted)
               }
               
               if let formattedDate = dateFormatterGet.date(from: date) {
                   let dateFormatterPrint = DateFormatter()
                   dateFormatterPrint.dateFormat = format
                   dateFormatterPrint.locale = Locale(identifier: Locale.current.identifier)
                   dateFormatterPrint.timeZone = TimeZone(identifier: TimeZone.current.identifier)
                   return dateFormatterPrint.string(from: formattedDate)
               }
           }
           
           return ""
       }
    // MARK: - method to convert severdate to Any format
        
    func convertServerDateTOAnyFormat(date: String, format: String) -> String {
        guard let date = Date.getDateFromString(date, formate: DateConstant.KServertDateFormate) else { return ""}
                var formate = format
                if Calendar.current.isDateInToday(date) {
                    formate = DateConstant.KDateFormatddMMMyyyy
                }
                return date.getStringFromDate(formate: formate)
        }
    
    func isDateGreaterThanYesterday() -> Bool {
        // Get the current calendar and today's date
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Get yesterday's date by subtracting one day from today
        if let yesterday = calendar.date(byAdding: .day, value: -1, to: today) {
            // Compare the target date with yesterday's date
            return self > yesterday
        }
        
        // Default return value if we couldn't calculate yesterday's date
        return false
    }
    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
            return (min(date1, date2) ... max(date1, date2)).contains(self)
        }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        guard fromDate <= toDate else { return [Date()] }
            var dates: [Date] = []
            var date = fromDate
            while date <= toDate {
                guard let onlyDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: date)) else {
                    break
                }
                dates.append(onlyDate)
                guard var newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
                date = newDate
            }
           return dates
        }
}

extension Date {

    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }

    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }

    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }
    var isInPreviousWeek: Bool { isInSameWeek(as: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: .init()) ?? .init()) }

    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }

    var isInTheFuture: Bool { self > Date() }
    var isInThePast:   Bool { self < Date() }
    var day: Int { Calendar.current.component(.day, from: self) }
    var dayName: String { getStringFromDate(formate: DateConstant.KWeekdayFormat) }
    var shortMonth: String { getStringFromDate(formate: DateConstant.KMonthFormatMMM) }
    
    var previousMonday: Date {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Set Monday as the first day of the week.

        let currentDate = Date().startOfDay
        let currentWeekday = calendar.component(.weekday, from: currentDate)
        
        // Calculate the number of days to subtract to reach the previous Monday.
        let daysUntilMonday = (currentWeekday - 2 + 7) % 7
        
        // Calculate the date for the Monday of the current week.
        let mondayOfWeek = calendar.date(byAdding: .day, value: -daysUntilMonday, to: currentDate)!
        
        return mondayOfWeek
    }
    
    static func getChatDateFromServerDate(dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateConstant.KServertDateFormate
           
           if let date = dateFormatter.date(from: dateStr) {
               dateFormatter.dateFormat = DateConstant.KApplicationDateShortFormate
               return dateFormatter.string(from: date)
           } else {
               return ""
           }
    }
    
    static func getUnKnowDateWithUTCViaFormat(_ dateString: String, formate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = formate
        // Addded this as the date from server some times does not have milli seconds in it.
        if formate == DateConstant.KServertDateFormate {
            var dateArr: [String] = dateString.components(separatedBy: ".")
            if dateArr.count > 1 {
                dateArr.removeLast()
            } else {
                return formatter.date(from: String(dateArr.joined(separator:"").dropLast())+".000Z")
            }
            return formatter.date(from: dateArr.joined(separator:"")+".000Z")
        }
        return getUnknowDateFromStringWithUTCViaFormat(dateString, formate: formate)//formatter.date(from: dateString)
    }
    
    static func getUnknowDateFromStringWithUTCViaFormat(_ dateString: String, formate: String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let formatsToTry = [
            DateConstant.KServertDateFormateclockin,
            DateConstant.kDateFormatddMMyyyyfull,
            DateConstant.KServertDateFormate,
            DateConstant.KUTCDateTimeFormate,
            DateConstant.KApplicationDateFormateForChat,
            DateConstant.KApplicationDescriptiveDateFormate,
            DateConstant.KApplicationTimeFormate,
            DateConstant.KDateFormatddMMMyyyy,
            DateConstant.KApplicationDateFormateForShiftClockin,
            DateConstant.KDateFormathhSSa,
            DateConstant.KDateFormathhmmssa,
            DateConstant.KServertDateFormateThird,
            DateConstant.kServerDateLog,
            DateConstant.KDateTimeFormat
        ]
        
        for format in formatsToTry {
            formatter.dateFormat = format
            
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        
        return nil
    }
}

