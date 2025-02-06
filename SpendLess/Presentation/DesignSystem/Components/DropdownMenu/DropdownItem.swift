//
//  DropdownItem.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

struct DropdownItem: Identifiable {
    let id: Int
    let title: String
    let icon: String
    let onSelect: (Int) -> Void
}
