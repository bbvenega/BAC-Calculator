import SwiftUI
import UIKit

struct CalendarView: UIViewRepresentable {
    @Binding var selectedDate: DateComponents?
    
    func makeUIView(context: Context) -> UICalendarView {
        let calendarView = UICalendarView()
        let selection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        calendarView.selectionBehavior = selection
        return calendarView
    }

    func updateUIView(_ uiView: UICalendarView, context: Context) {
        // Update the view when needed
    }

    // Create the Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UICalendarSelectionSingleDateDelegate {
        var parent: CalendarView

        init(_ parent: CalendarView) {
            self.parent = parent
        }

        // Handle date selection (Optional)
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.selectedDate = dateComponents
//            if let date = dateComponents {
//                print("Selected date: \(date)")
//            }
        }
    }
}
