//
//  DatetimePicker.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 09.05.22.
//

import SwiftUI

struct DatetimePicker: View {
    
    @Binding var currentDate: Date
    @State var  currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Days
            let days = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
            HStack {

                Button {
                    
                    if currentMonth > 0{

                    withAnimation {
                        currentMonth -= 1
                    }
                    }
                } label: {
                    Image(systemName: "chevron.left.circle")
                        .frame(width:18, height:18)
                        .foregroundColor(Color("Color-white"))
                        .background(Color("Color-red"))
                        .cornerRadius(20)
                    
                }
                Spacer()

                Text(extraDate()[1] + ", " + extraDate()[0])
                    .font(.custom("SFProRounded-Semibold", size: 15) )
//                    .frame(width:UIScreen.screenWidth - 76)
                Spacer()
                

                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right.circle")
                        .frame(width:18, height:18)
                        .foregroundColor(Color("Color-white"))
                        .background(Color("Color-red"))
                        .cornerRadius(20)
                }

            }
//            .padding(.horizontal)
            .frame(width: UIScreen.screenWidth - 90, height:30)
            VStack(spacing:0){
                // Day View...
                HStack(spacing: 0) {
                    ForEach(days, id: \.self) { day in
                        if day == "Su" || day == "Sa"{
                            Text(day)
                                .font(.custom("SFProRounded-Semibold", size: 15) )
                                .foregroundColor(Color("Color-red"))
                                .frame(maxWidth: .infinity)
                        }else{
                            Text(day)
                                .font(.custom("SFProRounded-Semibold", size: 15) )
                                .frame(maxWidth: .infinity)
                        }
                        
                    }
                }
            }

            .frame(width: UIScreen.screenWidth - 80, height:40)

            
            //Date
            // Lazy Grid..
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(extractDate()) { value in
                  CardView(value: value)
                        .background(
                            Capsule()
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            let now = Date.now.addingTimeInterval(-86400)
                            if(value.date >= now){
                                currentDate = value.date
                                let df = DateFormatter()
                                df.timeStyle = .none
                                df.dateStyle = .short
                                UserDefaults.standard.set(df.string(from:value.date), forKey: "PickedDay")
                            }
                        }
                }
            }
            .frame(width: UIScreen.screenWidth - 100)
        }
        .frame(width: UIScreen.screenWidth - 80, height: 270)
        
        .onChange(of: currentMonth) { newValue in
            // update month
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                .font(.custom("SFProRounded-Light", size: 15) )
                    .foregroundColor(isSameDay(date1: value.date , date2: currentDate) ? .white : .primary)
                    .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .padding(.top, 10)
        .frame(width:30, height: 30)
        .background(isSameDay(date1: value.date , date2: currentDate) ? Color.red : Color.clear)
        .cornerRadius(10)
    }
    // Checking dates
    func isSameDay(date1: Date, date2: Date) -> Bool {
        return date1 == date2
    }
    
    // Extraing year and month for display
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        // Getting Current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        // Getting Current month date
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            let dateValue =  DateValue(day: day, date: date)
            return dateValue
        }
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

struct DatetimePicker_Previews: PreviewProvider {
    static var previews: some View {
        ReservationHomeView()
    }
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        // geting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)
        // getting date...
        return range!.compactMap{ day -> Date in
            return calendar.date(byAdding: .day, value: day - 1 , to: startDate)!
        }
    }
}
