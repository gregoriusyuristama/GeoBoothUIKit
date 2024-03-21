//
//  AuthenticationInteractorTests.swift
//  GeoBoothUIKitTests
//
//  Created by Gregorius Yuristama Nugraha on 3/14/24.
//

import XCTest
@testable import GeoBoothUIKit
@testable import Supabase

final class AuthenticationInteractorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. 
        // Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testDoAuthSuccess() {
        // Mock SupabaseSingleton's client to return a successful response
        let mockClient = SupabaseSingleton.shared.client
        let mockInteractor = AuthenticationInteractor()

        var completionUser: User?
        var completionError: Error?

        mockInteractor.doAuth(email: "ichovantz@gmail.com", password: "123456") { user, error in
            completionUser = user
            completionError = error
        }

        // Assert expected behavior
        XCTAssertNil(completionError)
        XCTAssertNotNil(completionUser) // Assuming User model has an 'id' property
        XCTAssertTrue(UserDefaults.standard.value(forKey: UserDefaultsKeyConstant.supabaseSession) != nil)
    }

}
