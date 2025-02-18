//
//  Categories.swift
//  SpendLess
//
//  Created by Andres Cordón on 12/2/25.
//

enum Categories: String, CaseIterable {
    case entertainment = "Entertainment"
    case clothing = "Clothing & Accessories"
    case education = "Education"
    case food = "Food & Groceries"
    case health = "Health & Wellness"
    case home = "Home"
    case other = "Other"
    case care = "Personal Care"
    case investments = "Saving & Investments"
    case transportation = "Transportation"
    
    var icon: String {
        switch self {
        case .entertainment:
            return "Entertainment"
        case .clothing:
            return "Clothing"
        case .education:
            return "Education"
        case .food:
            return "Food"
        case .health:
            return "Health"
        case .home:
            return "Home"
        case .other:
            return "Other"
        case .care:
            return "PersonalCare"
        case .investments:
            return "Saving&Investments"
        case .transportation:
            return "Transportation"
        }
    }
    
    var id: Int {
        switch self {
        case .entertainment:
            return 0
        case .clothing:
            return 1
        case .education:
            return 2
        case .food:
            return 3
        case .health:
            return 4
        case .home:
            return 5
        case .other:
            return 6
        case .care:
            return 7
        case .investments:
            return 8
        case .transportation:
            return 9
        }
    }
}
