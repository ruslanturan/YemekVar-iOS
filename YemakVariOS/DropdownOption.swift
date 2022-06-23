//
//  DropdownOption.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 26.04.22.
//

import Foundation
struct DropdownOption: Hashable {
    let key: String
    let value: String

    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}
