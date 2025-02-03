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

    var body: some View {
        List {
            ForEach(expenses) { expense in
                Text(expense.receiver)
            }
        }.onAppear {
            expenses = getExpenses()
        }
        
        Button {
            saveExpense()
            expenses = getExpenses()
        } label: {
            Text("Add")
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
