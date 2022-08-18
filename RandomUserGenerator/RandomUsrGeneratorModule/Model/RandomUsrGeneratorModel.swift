//
//  RandomUsrGeneratorModel.swift
//  RandomUserGenerator
//
//  Created by Minerva Nolasco Espino on 17/08/22.
//

import Foundation

public struct RandomUsrGeneratorModel : Codable {
    public var results : [ArrResults]?
}

public struct ArrResults : Codable {
    public var gender : String
    public var name : Name?
    public var location : Location?
    public var email : String
    public var dob : DOB?
    public var cell : String
    public var picture : Picture?
}

public struct Name: Codable {
    public var title : String
    public var first : String
    public var last  : String
}

public struct Location : Codable {
    public var coordinates : Coordinates?
}

public struct DOB : Codable {
    public var age : Int
}

public struct Picture : Codable {
    public var large : String
}

public struct Coordinates : Codable {
    public var latitude : String
    public var longitude : String
}
