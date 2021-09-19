//
//  View+ActivitySheet.swift
//  
//
//  Created by Brent Mifsud on 2021-09-18.
//

import SwiftUI

public extension View {

    /// Shows an activity sheet.
    /// - Parameters:
    ///   - isPresented: Binding for showing/hiding the activity sheet.
    ///   - activityItems: items that will be shared
    ///   - applicationActivities: UIActivity items to be added to the activity sheet
    ///   - completionHandler: code that will be executed after the share sheet is closed
    func activitySheet(
        _ isPresented: Binding<Bool>,
        activityItems: [Any],
        applicationActivities: [UIActivity]? = nil,
        completionHandler: UIActivityViewController.CompletionWithItemsHandler? = nil
    ) -> some View {
        modifier(
            ActivitySheet(
                isPresented: isPresented,
                activityItems: activityItems,
                applicationActivities: applicationActivities,
                completionHandler: { activityType, completed, items, error in
                    isPresented.wrappedValue = false
                    completionHandler?(activityType, completed, items, error)
                }
            )
        )
    }

    /// Shows an activity sheet based when sharable items have been provided.
    /// - Parameters:
    ///   - activityItems: Binding to an array of items to be shared
    ///   - applicationActivities: application activities
    ///   - completionHandler: When the activity controller finishes sucessfully this code is run
    func activitySheet(
        activityItems: Binding<[Any]?>,
        applicationActivities: [UIActivity]? = nil,
        completionHandler: UIActivityViewController.CompletionWithItemsHandler? = nil
    ) -> some View {
        modifier(
            ActivitySheet(
                activityItems: activityItems,
                applicationActivities: applicationActivities,
                completionHandler: { activityType, completed, items, error in
                    activityItems.wrappedValue = nil
                    completionHandler?(activityType, completed, items, error)
                }
            )
        )
    }
}
