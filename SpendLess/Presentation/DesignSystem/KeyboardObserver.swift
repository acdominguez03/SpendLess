//
//  KeyboardObserver.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellables: Set<AnyCancellable> = []

    init() {
        let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)

        keyboardWillShow
            .merge(with: keyboardWillHide)
            .sink { notification in
                if notification.name == UIResponder.keyboardWillShowNotification,
                   let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self.keyboardHeight = keyboardFrame.height
                } else {
                    self.keyboardHeight = 0
                }
            }
            .store(in: &cancellables)
    }
}
