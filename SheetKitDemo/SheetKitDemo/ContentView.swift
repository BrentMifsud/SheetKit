//
//  ContentView.swift
//  SheetKitDemo
//
//  Created by Brent Mifsud on 2021-09-18.
//

import SwiftUI
import SheetKit

struct ContentView: View {
    @State var isPresented: Bool = false

    var body: some View {
        Color.white
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Button {
                    isPresented = true
                } label: {
                    Text("Present Share Sheet")
                }
            )
            .activitySheet($isPresented, activityItems: [URL(string: "https://www.google.com")!]) { activityType, completed, activityItems, error in
                print("ActivityType: \(String(describing: activityType))")
                print("Completed: \(completed)")
                print("ActivityItems: \(String(describing: activityItems))")
                print("Error: \(String(describing: error))")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
