//
//  WindowHelper.swift
//  
//
//  Created by Brent Mifsud on 2021-09-18.
//

import UIKit

extension UIApplication {
    static var activeScene: UIWindowScene? {
        UIApplication.shared.connectedScenes.first(where: { scene in
            scene.activationState == .foregroundActive
        }) as? UIWindowScene
    }
}
