////
////  CalendarView.swift
////  BlaBalApp
////
////  Created by ChicMic on 11/05/23.
////
//
//import SwiftUI
//
//struct CalendarView: View {
//    @Binding var selectedDate: Date
//    @Environment(\.dismiss) var dismiss
//    let minDate = Calendar.current.date(from: DateComponents(year: 1940, month: 1, day: 1))!
//    let maxDate = Calendar.current.date(from: DateComponents(year: 2015, month: 12, day: 31))!
//    let pickDateMax = Calendar.current.date(from: DateComponents(year: 2040, month: 12, day: 31))!
//    @Binding var isDob: Bool
//
//    var body: some View {
//        VStack {
//            HStack {
//                Spacer()
//                Button {
//                    dismiss()
//                }label: {
//                    Text(Constants.Buttons.done).padding().fontWeight(.semibold)
//                        .font(.title2)
//                }
//            }
//
//            let dateRange = isDob ? minDate...maxDate : Date()...pickDateMax
//
//
//            DatePicker("", selection: $selectedDate, in: dateRange)
//                .datePickerStyle(.graphical)
//                          .frame(maxHeight: 400)
//                          .padding()
//                          .cornerRadius(25)
//            Spacer()
//        }
//    }
//}
//
//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView(selectedDate: .constant(Date()), isDob: .constant(true))
//    }
//}
