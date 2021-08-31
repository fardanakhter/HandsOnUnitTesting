//
//  UserModel.swift
//  HandsOnUnitTesting
//
//  Created by Fardan Akhter on 8/28/21.
//

import Foundation

class UserModel: NSObject {
    
    var id: String = "123"
    var firstname: String = "TestFirst"
    var lastname: String = "TestLast"
    
    init(firstName: String, lastName: String) {
        self.firstname = firstName
        self.lastname = lastName
    }
    
    override init() {}
    
    func getPrintableDetials() -> String {
        return "\(firstname) \(lastname)"
    }
    
    static func loop(_ users: [UserModel]){
        
        let semaphore = DispatchSemaphore(value: 0) // for synchrounous operations
        let globalQ = DispatchQueue.global()

        let _ = users.forEach{ _ in
            //additional delay for testing
            globalQ.asyncAfter(deadline: .now() + 0.25) {
                semaphore.signal()
            }
            semaphore.wait()
        }
    }
}
