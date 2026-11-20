//
//  SupplyTests.swift
//  Mobile_Activity8Tests
//
//  Created by Desiderio Ortegon morton on 08/11/26.
//

import Foundation
import Testing
@testable import Mobile_Activity8_Data_persistence_with_SwiftData_and_SwiftTest

@MainActor
struct SupplyTests {
    @Test("A supply name cannot be empty or only spaces")
    func nameValidation() {
        #expect(Supply.isValidName("Gasas estériles"))
        #expect(!Supply.isValidName(""))
        #expect(!Supply.isValidName("   "))
    }

    @Test("Quantity must be greater than zero")
    func quantityValidation() {
        #expect(Supply.isValidQuantity(1))
        #expect(!Supply.isValidQuantity(0))
        #expect(!Supply.isValidQuantity(-5))
    }

    @Test("Expiration status depends on the days left")
    func expirationStatus() throws {
        let calendar = Calendar(identifier: .gregorian)
        let today = try #require(calendar.date(from: DateComponents(year: 2026, month: 11, day: 8)))
        let yesterday = try #require(calendar.date(byAdding: .day, value: -1, to: today))
        let inThirtyDays = try #require(calendar.date(byAdding: .day, value: 30, to: today))
        let inThirtyOneDays = try #require(calendar.date(byAdding: .day, value: 31, to: today))

        #expect(ExpirationStatus(expirationDate: yesterday, referenceDate: today, calendar: calendar) == .expired)
        #expect(ExpirationStatus(expirationDate: today, referenceDate: today, calendar: calendar) == .expiringSoon)
        #expect(ExpirationStatus(expirationDate: inThirtyDays, referenceDate: today, calendar: calendar) == .expiringSoon)
        #expect(ExpirationStatus(expirationDate: inThirtyOneDays, referenceDate: today, calendar: calendar) == .valid)
    }
}
