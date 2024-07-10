//
//  Status.swift
//  DeleverFlyAlexPetrosyan
//
//  Created by user on 7/10/24.
//

import Foundation

enum Status: String {
    case success
    case error
    
    var description: String {
        switch self {
        case .success:
            "Your order was successful, \n see conformation in order history!"
        case .error:
            "There was an error"
        }
    }
}
