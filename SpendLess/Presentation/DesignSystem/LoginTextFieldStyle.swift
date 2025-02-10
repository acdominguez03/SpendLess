//
//  LoginTrxtFieldStyle.swift
//  SpendLess
//
//  Created by Andres Cordón on 8/2/25.
//

import SwiftUI

struct LoginTextFieldStyle: TextFieldStyle {
    @FocusState var isFocused: Field?
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 12)
            .padding(.leading, 12)
            .tint(Color("PrimaryApp"))
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            
    }
}
