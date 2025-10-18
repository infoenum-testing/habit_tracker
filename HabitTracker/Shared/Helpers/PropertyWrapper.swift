//
//  PropertyWrapper.swift
//  HabitTracker
//
//  Created by IE14 on 10/10/25.
//

@propertyWrapper
struct ArcName {
    private var value: String = ""

    var wrappedValue: String {
        get { formatArcName(value) }
        set { value = newValue }
    }

    private func formatArcName(_ input: String) -> String {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else { return "Arc" }

        var corrected = trimmed
        if corrected.lowercased().hasSuffix("ine") {
            corrected = String(corrected.dropLast(3)) + "ing"
        }

        corrected = corrected.prefix(1).uppercased() + corrected.dropFirst()

        if corrected.lowercased() == "arc" || corrected.count < 3 {
            return "Arc"
        }

        if !corrected.lowercased().hasSuffix("arc") {
            return "\(corrected) Arc"
        }

        return corrected
    }

    init(wrappedValue: String) {
        self.value = wrappedValue
    }
}
