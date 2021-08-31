//
//  HandsOnUnitTestingTests.swift
//  HandsOnUnitTestingTests
//
//  Created by Fardan Akhter on 8/28/21.
//

import XCTest
@testable import HandsOnUnitTesting

class HandsOnUnitTestingTests: XCTestCase {

    var sut: UserModel!
    var sutCollection: [UserModel]!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = UserModel()
        sutCollection = [UserModel]()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        sutCollection = nil
        try super.tearDownWithError()
    }

    func testUserPrintableDetails(){
        // Given
        sut.firstname = "Fardan"
        sut.lastname = "Akhter"
        
        // When
        let string = sut.getPrintableDetials()
        
        // Then
        XCTAssertEqual(string, "Fardan Akhter", "Error in formatting printable string!")
        
    }
    
    // performance test on data collection
    func testSortOperationOnDataCollection(){
        //given
        sutCollection = [UserModel(firstName: "fardan", lastName: "akhter"),
                         UserModel(firstName: "shehroz", lastName: "khan"),
                         UserModel(firstName: "zeeshan", lastName: "mustaqim"),
                         UserModel(firstName: "furqan", lastName: "akhter"),
                         UserModel(firstName: "zarrar", lastName: "dehli")
        ]
        
        measure(
            //then
            metrics: [
                XCTClockMetric(),
                XCTCPUMetric(),
                XCTStorageMetric(),
                XCTMemoryMetric()
            ]
        ) {
            //when
            UserModel.loop(sutCollection)
        }
    }
    

}
