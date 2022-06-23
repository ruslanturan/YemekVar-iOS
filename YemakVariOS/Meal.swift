//
//  Meal.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 26.04.22.
//

import Foundation
struct Meal: Codable,Identifiable  {
    let id: Int
    let image: String
    let title: String
}
