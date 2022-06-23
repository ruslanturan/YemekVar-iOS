//
//  DeliveryDivider.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 30.05.22.
//

import Foundation
public class DeliveryDivider: Hashable  {
    public static func == (lhs: DeliveryDivider, rhs: DeliveryDivider) -> Bool {
        return lhs.Name == rhs.Name && lhs.PhotoURL == rhs.PhotoURL && lhs.ID == rhs.ID
    }
    
    var ID: String
    var Name: String
    var PhotoURL: String
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ID)
        hasher.combine(Name)
        hasher.combine(PhotoURL)
    }
    init(ID: String, Name: String, PhotoURL: String) {
        self.ID = ID
        self.Name = Name
        self.PhotoURL = PhotoURL
    }
}
