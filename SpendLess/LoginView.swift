//
//  ContentView.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var context
    @Query private var encryptedExpenses: [EncryptedExpenseModel]
    @State var expenses: [ExpenseModel] = []
    
    @FocusState private var isTextFieldFocused: Bool
    @StateObject private var keyboardObserver = KeyboardObserver()

    var body: some View {
        VStack {
            LazyVStack {
                ForEach(expenses) { expense in
                    Text(expense.receiver)
                }
            }.onAppear {
                expenses = getExpenses()
            }
            
            TextField("username", text: .constant("Name"))
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isTextFieldFocused)
            
            Button {
                saveExpense()
                expenses = getExpenses()
                isTextFieldFocused = false
            } label: {
                Text("Add")
            }
            
            Banner()
                .padding(.bottom, 24)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: isTextFieldFocused ? -keyboardObserver.keyboardHeight + 24 : 0)
                .animation(.easeInOut, value: isTextFieldFocused)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(edges: .bottom)
        .background(Color("Background"))
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
    
    private func saveExpense() {
        let newExpense = EncryptedExpenseModel(receiver: "Netflix", amount: 10, note: "Muy caro", category: ExpenseCategory.entertainment)
        context.insert(newExpense)
        try? context.save()
    }
    
    func getExpenses() -> [ExpenseModel] {
        return encryptedExpenses.compactMap { encryptedSession in
            return encryptedSession.decryptAll()
        }
    }
}

#Preview {
    LoginView()
}
