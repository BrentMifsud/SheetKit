//
//  ActivitySheet.swift
//  
//
//  Created by Brent Mifsud on 2021-09-18.
//

import UIKit
import SwiftUI

struct ActivitySheet: ViewModifier {
    // MARK: - State

    @Binding private var isPresented: Bool

    // MARK: - Properties

    private let activityItems: [Any]
    private let applicationActivities: [UIActivity]?
    private let completionHandler: UIActivityViewController.CompletionWithItemsHandler?
    private let activityController: UIActivityViewController

    // MARK: - Init

    init(
        isPresented: Binding<Bool>,
        activityItems: [Any],
        applicationActivities: [UIActivity]?,
        completionHandler: UIActivityViewController.CompletionWithItemsHandler?
    ) {
        self._isPresented = isPresented

        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
        self.completionHandler = completionHandler

        self.activityController = {
            let controller = UIActivityViewController(
                activityItems: activityItems,
                applicationActivities: applicationActivities
            )

            controller.completionWithItemsHandler = completionHandler

            return controller
        }()
    }

    init(
        activityItems: Binding<[Any]?>,
        applicationActivities: [UIActivity]?,
        completionHandler: UIActivityViewController.CompletionWithItemsHandler?
    ) {
        self._isPresented = Binding<Bool>(
            get: {
                activityItems.wrappedValue != nil
            },
            set: { newValue in
                activityItems.wrappedValue = nil
            }
        )

        self.activityItems = activityItems.wrappedValue ?? []
        self.applicationActivities = applicationActivities
        self.completionHandler = completionHandler

        let controller = UIActivityViewController(
            activityItems: activityItems.wrappedValue ?? [],
            applicationActivities: applicationActivities
        )

        controller.completionWithItemsHandler = completionHandler

        activityController = controller
    }


    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented, perform: presentationChanged)
    }

    // MARK: - Functions

    private func presentationChanged(_ isPresented: Bool) {
        guard let scene = UIApplication.activeScene,
              let rootViewController = scene.keyWindow?.rootViewController else {
            return
        }

        if isPresented {
            rootViewController.present(activityController, animated: true)
        } else {
            activityController.dismiss(animated: true) {
                completionHandler?(nil, false, nil, nil)
            }
        }
    }
}
