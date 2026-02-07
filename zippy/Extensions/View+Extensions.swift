//
//  View+Extensions.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
