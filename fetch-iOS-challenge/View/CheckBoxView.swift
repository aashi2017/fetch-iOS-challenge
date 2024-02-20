//
//  CheckboxView.swift
//  fetch-iOS-challenge
//
//  Created by AASHI  SHRIMAL on 2/19/24.
//
//This view represents a custom checkbox component. 
import SwiftUI

struct CheckBoxView: View {
    @State private var isChecked: Bool = false
    
    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .foregroundColor(isChecked ? .green : .gray)
            .onTapGesture {
                self.isChecked.toggle() 
            }
    }
}
#Preview {
    CheckBoxView()
}
