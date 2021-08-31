//
//  HandsOnUnitTestingMockData.swift
//  HandsOnUnitTestingTests
//
//  Created by Fardan Akhter on 8/29/21.
//

import XCTest
@testable import HandsOnUnitTesting

// This is a Mock Data example
class MockUserDefaults: UserDefaults{
    
    var countTimesModified = 0 // This tracks number of times setValue() is called on 'counterValue' key
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        
        if key == "counterValue" {
            countTimesModified += 1
        }
    }
}

class HandsOnUnitTestingMockData: XCTestCase {

    var sut: ViewController! //System Under Test
    var userDefault: MockUserDefaults!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? ViewController
        userDefault = MockUserDefaults()
        sut.defaults =  userDefault //UserDefaults.standard
        sut.resetData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        userDefault = nil
        try super.tearDownWithError()
    }

    // This tests that correct data is being saved
    func testCorrectDataIsSaved(){
        // given
        let button = UIButton()
        
        // when
        XCTAssertEqual(sut.counterValue, 0, "counterValue should be 0 before sendActions")
        button.addTarget(sut, action: #selector(sut.pressButton), for: .touchUpInside)
        button.sendActions(for: .touchUpInside)
        
        // then
        XCTAssertEqual(sut.counterValue, 1, "counterValue changed incorrectly!")
        XCTAssertEqual(userDefault.countTimesModified, 2, "Data value modified more than expected number of times!")
    }
}
