//
//  AlertPresenter.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 01/09/25.
//

import UIKit

// MARK: - Global Alert Presenter
func presentAlert(
    title: String,
    message: String,
    primaryAction: UIAlertAction,
    secondaryAction: UIAlertAction? = nil,
    tertiaryAction: UIAlertAction? = nil
) {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(primaryAction)
        if let secondary = secondaryAction { alert.addAction(secondary) }
        if let tertiary = tertiaryAction { alert.addAction(tertiary) }
        rootController?.present(alert, animated: true)
    }
}

var rootController: UIViewController? {
    var root = UIApplication.shared.connectedScenes
        .filter { $0.activationState == .foregroundActive }
        .first(where: { $0 is UIWindowScene })
        .flatMap { $0 as? UIWindowScene }?
        .windows
        .first(where: { $0.isKeyWindow })?
        .rootViewController
    while root?.presentedViewController != nil {
        root = root?.presentedViewController
    }
    return root
}
