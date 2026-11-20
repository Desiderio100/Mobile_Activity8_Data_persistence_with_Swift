//
//  ExpirationStatus.swift
//  Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation

nonisolated enum ExpirationStatus: CaseIterable, Identifiable {
    case expired
    case expiringSoon
    case valid

    /// Days before the expiration date when a supply is flagged as expiring soon.
    static let warningPeriodInDays = 30

    init(expirationDate: Date, referenceDate: Date = .now, calendar: Calendar = .current) {
        let today = calendar.startOfDay(for: referenceDate)
        let expirationDay = calendar.startOfDay(for: expirationDate)
        let daysLeft = calendar.dateComponents([.day], from: today, to: expirationDay).day ?? 0

        switch daysLeft {
        case ..<0:
            self = .expired
        case ...Self.warningPeriodInDays:
            self = .expiringSoon
        default:
            self = .valid
        }
    }

    var id: Self { self }
}
