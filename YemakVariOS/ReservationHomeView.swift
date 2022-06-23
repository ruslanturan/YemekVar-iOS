//
//  ReservationHomeView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 09.05.22.
//

import SwiftUI

struct ReservationHomeView: View {
    @ObservedObject var location = LocationManager()
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    @State private var searchText: String = ""
    @State var goToRestaurant = false
    @State var isLoading = false
    @State var showAlert = false
    @State var showFullList = false
    @State var closeApp = false

    @State var selectedHour = 0
    @State var message = ""
    @State var guestCount = UserDefaults.standard.string(forKey: "GuestCount") ?? ""
//    @State var bookingDate = "Now"
    @State private var isShowingMenu = false
    @State private var isShowingPicker = false
    @State var currentDate: Date = Date.now
    var hours = [Date]()
    @State var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""
    @State var address = UserDefaults.standard.string(forKey: "loggedAddress") ?? ""
    @State var selectedAddress = UserDefaults.standard.string(forKey: "selectedStreet") ?? ""
    @State var bookingHour = UserDefaults.standard.string(forKey: "PickedHour") ?? ""
//    @State var bookingDay = UserDefaults.standard.string(forKey: "PickedDay") ?? "Now"

    @State var nearestRestaurants: [NSDictionary] = []
    @State var restaurants: [NSDictionary] = []
    @State var dividers: [NSDictionary] = []
    @State var dividerID: Int = 0
    @State var restID: Int = 0
    @State var favouriteRestaurants: [Int] = []
    @State private var goToAddress = false
    @State var goToSearch = false
    let hourFormatter = DateFormatter()
    let dateFormatter = DateFormatter()

    var lat: String {
        return "\(location.lastKnownLocation?.coordinate.latitude ?? 0.0)"
    }

    var lon: String {
        return "\(location.lastKnownLocation?.coordinate.longitude ?? 0.0)"
    }
    public init() {
        hourFormatter.dateStyle = .none
        hourFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.setLocalizedDateFormatFromTemplate("MM.dd HH:mm")
        for _ in 0...5{
            if hours.count < 1{
                let component = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate)
                let year = component.year
                let month = component.month
                let day = component.day
                var hour = component.hour ?? 0
                
                var minute = component.minute ?? 0
                if minute < 30{
                    minute = 30
                }
                else{
                    minute = 0
                    hour += 1
                }
                var components = DateComponents()
                components.year = year
                components.hour = hour
                components.minute = minute
                components.month = month
                components.day = day
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm"
                let date = formatter.date(from: String(year!) + "/" + String(month!) + "/" + String(day!) + " " + String(hour) + ":" + String(minute))
                hours.insert(date ?? Date.now, at: 0)
            }
            else{
                let nextTime = hours.first?.addingTimeInterval(1800)
                hours.insert(nextTime!, at: 0)
            }
        }
        self.location.startUpdating()
    }
    var body: some View {
        LoadingView(isShowing: $isLoading) {

        ZStack{


            VStack(spacing:0){
                        
                        VStack{
                            Spacer()
                                .frame(height:20)
                            HStack{
//                                Button(action: {
//                                    withAnimation(.spring()){
//                                        isShowingMenu.toggle()
//                                    }
//                                }) {
//                                    Image("Icon-menu")
//                                        .frame(width: 22, height: 15, alignment: .center)
//                                        .padding(15)
//                                        .background(Color("Color-white"))
//                                        .clipShape(Circle())
//                                }
                                Spacer()
                                    .frame(width:55)
                                if loggedID != ""{

                                Button(action: {
                                    withAnimation{
                                        goToAddress.toggle()
                                    }
                                }, label: {
                                    Image("Icon-location")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 50, alignment: .center)
                                        .padding(.leading)
//                                    if selectedAddress.isEmpty{
//                                        Text(address)
//                                            .lineLimit(1)
//                                            .font(.custom("SFProRounded-Light", size: 15) )
//                                            .foregroundColor(Color.black)
//                                    }
//                                    else{
                                    if selectedAddress != ""{
                                        Text(UserDefaults.standard.string(forKey: "selectedStreet")!)
                                            .lineLimit(1)
                                            .font(.custom("SFProRounded-Light", size: 15) )
                                            .foregroundColor(Color.black)
                                    }
                                    else{
                                        Text(UserDefaults.standard.string(forKey: "loggedAddress")!)
                                            .lineLimit(1)
                                            .font(.custom("SFProRounded-Light", size: 15) )
                                            .foregroundColor(Color.black)
                                    }
//                                    }
                                    Image("Icon-down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 15, height: 50, alignment: .center)
                                })
                                .sheet(isPresented: $goToAddress, onDismiss: {
                                    Task{
                                        await loadData()
                                    }
                                }) {
                                    VStack{
                                        Spacer()
                                        AddressesView()
                                            .frame(height: 350)
                                                        .clearModalBackground()
                                    }
                                }
                                }
                                else{
                                    VStack{}
                                        .frame(height:50)
                                }
                                Spacer()
                                    .frame(width:55)
//                                Image("Icon-user")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 50, height: 50, alignment: .center)
//                                    .background(Color.white)
//                                    .cornerRadius(25)
//        //                            .clipShape(Circle())
//                                    .overlay(
//                                        Circle().stroke(Color("Color-yellow"), lineWidth: 2.5))
                            }
                            HStack{
                                Spacer()
                                    .frame(width:10)
                                Image("Icon-search")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20, alignment: .center)
                                TextField("Search for food or restaurant...", text: $searchText)
                                    .foregroundColor(Color.gray)
                                    .font(.custom("SFProRounded-Regular", size: 18) )
                                    .lineLimit(1)
                                    .simultaneousGesture(TapGesture().onEnded {
                                        withAnimation{
                                            goToSearch.toggle()
                                        }
                                        
                                    })

                                    .fullScreenCover(isPresented: $goToSearch, content: {
                                        ReservationSearchView()
                                        
                                    })
                            }
                            .frame(width: UIScreen.screenWidth - 40, height: 50, alignment: .leading)
                            .background(Color("Color-white"))
                            .cornerRadius(50)
                            .padding(.vertical)
                            if !isShowingPicker{
                                Button(action: {
                                    withAnimation{
                                        isShowingPicker.toggle()
                                    }
                                }, label: {
                                    HStack{
                                        Spacer()
                                            .frame(width:20)
                                        HStack{
                                            Spacer()
                                            Image("Icon-user-red")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:16, height:16)
                                            Text(guestCount)
                                                .font(.custom("SFProRounded-Light", size: 18) )
                                                .foregroundColor(Color("Color-red"))
                                                .lineLimit(1)
                                                //.position(x: 110, y: 40)
                                                //.padding(.bottom,10)
                                            Text(".")
                                                .foregroundColor(Color.black)
                                                .font(.system(size: 50, weight: .heavy, design: .default))
                                                .lineLimit(1)
                                                //.position(x: 110, y: 40)
                                                .padding(.bottom,30)
                                            Text((UserDefaults.standard.string(forKey: "PickedDay") ?? "Now") + " " + UserDefaults.standard.string(forKey: "PickedHour")!)
                                                .font(.custom("SFProRounded-Light", size: 18))
                                                .foregroundColor(Color("Color-red"))
                                                .lineLimit(1)
                                                //.position(x: 110, y: 40)
                                            Spacer()
                                        }
                                        .background(Color("Color-yellow"))
                                        .frame(width: 230, height: 40, alignment: .trailing)
                                        .cornerRadius(30)
                //                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                        .padding(.bottom,20)
                                        Spacer()
                                    }

                                })
                            }
                        }
                        .frame(width:UIScreen.screenWidth)
                        .background(Color("Color-red"))
                        ScrollView{

                            if isShowingPicker{
                                VStack{
                                    VStack{
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            HStack{
                                                Spacer()
                                                Image("Icon-user-red")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width:16, height:16)
                                                Text(guestCount)
                                                    .font(.custom("SFProRounded-Light", size: 18) )
                                                    .foregroundColor(Color("Color-red"))
                                                    .lineLimit(1)
                                                    //.position(x: 110, y: 40)
                                                    //.padding(.bottom,10)
                                                Text(".")
                                                    .foregroundColor(Color.black)
                                                    .font(.system(size: 50, weight: .heavy, design: .default))
                                                    .lineLimit(1)
                                                    //.position(x: 110, y: 40)
                                                    .padding(.bottom,30)
                                                Text((UserDefaults.standard.string(forKey: "PickedDay") ?? "Now") + " " + UserDefaults.standard.string(forKey: "PickedHour")!)                                                 .font(.custom("SFProRounded-Light", size: 18))
                                                    .foregroundColor(Color("Color-red"))
                                                    .lineLimit(1)
                                                    //.position(x: 110, y: 40)
                                                Spacer()
                                            }
                                            .background(Color("Color-yellow"))
                                            .frame(width: 230, height: 40, alignment: .trailing)
                                            .cornerRadius(30)
                    //                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
//                                            .padding(.bottom,20)
                                            Spacer()
                                        }
                                        .frame(width:200)
                                        Text(" ")
                                            .frame(
                                              minWidth: 0,
                                              maxWidth: UIScreen.screenWidth - 60,
                                              minHeight: 0,
                                              maxHeight: 1,
                                              alignment: .leading
                                            )
                                            .background(Color("Color-red"))
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            Text("Number of guests:")
                                                .font(.custom("SFProRounded-Light", size: 18) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                                //.position(x: 110, y: 40)
                                            Spacer()
                                            HStack{
                                                Button(action: {
                                                    withAnimation{
                                                        if guestCount != "1"{
                                                            guestCount = String(Int(guestCount)! - 1)
                                                            UserDefaults.standard.set(guestCount, forKey: "GuestCount")

                                                        }
                                                    }
                                                }, label: {
                                                    Text("-")
                                                        .font(.custom("SFProRounded-Light", size: 30) )
                                                        .lineLimit(1)
                                                        //.position(x: 110, y: 40)
                                                        .padding(.bottom,10)
                                                        .foregroundColor(Color("Color-black"))

                                                })

                                                Spacer()
                                                Text(guestCount)
                                                    .foregroundColor(Color("Color-red"))
                                                    .font(.custom("SFProRounded-light", size: 21) )
                                                    .lineLimit(1)
                                                    //.position(x: 110, y: 40)
                                                    //.padding(.bottom,160)
                                                Spacer()
                                                Button(action: {
                                                    withAnimation{
                                                        if guestCount != "9"{
                                                            guestCount = String(Int(guestCount)! + 1)
                                                            UserDefaults.standard.set(guestCount, forKey: "GuestCount")

                                                        }
                                                    }
                                                }, label: {
                                                    Text("+")
                                                        .font(.custom("SFProRounded-Light", size: 30) )
                                                        .lineLimit(1)
                                                        //.position(x: 110, y: 40)
                                                        .padding(.bottom,10)
                                                        .foregroundColor(Color("Color-black"))
                                                })
                                                
                                            }
                                            .padding()
                                            .background(Color("Color-white"))
                                            .frame(width: 90, height: 40, alignment: .trailing)
                                            .cornerRadius(30)
                                            .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                            Spacer()
                                                .frame(width:20)

                                        }
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            Text("Time:")
                                                .font(.custom("SFProRounded-Light", size: 18) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Spacer()
                                        }
                                        HStack{
                                            Button(action: {
                                                withAnimation{
//                                                    if(bookingDay == "Now"){
//                                                        bookingHour = hourFormatter.string(from: hours.last!)
                                                    selectedHour = 1
                                                        let df = DateFormatter()
                                                        df.timeStyle = .none
                                                        df.dateStyle = .short
                                                        UserDefaults.standard.set(df.string(from: hours.last!), forKey: "PickedDay")
//                                                        bookingDay = df.string(from: hours.last!)
                                                        UserDefaults.standard.set(hourFormatter.string(from: hours.last!), forKey: "PickedHour")

//                                                    }
                                                }
                                            }, label: {
                                                if selectedHour == 1{
                                                    Text(hourFormatter.string(from: hours.last!))
                                                        .foregroundColor(Color("Color-white"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-red"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }else{
                                                    Text(hourFormatter.string(from: hours.last!))
                                                        .foregroundColor(Color("Color-red"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-white"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }
                                                
                                            })

                                            Spacer()
                                            Button(action: {
                                                withAnimation{
//                                                    if(bookingDay == "Now"){
//                                                        bookingHour = hourFormatter.string(from: hours.last!)
                                                    selectedHour = 2
                                                        let df = DateFormatter()
                                                        df.timeStyle = .none
                                                        df.dateStyle = .short
                                                        UserDefaults.standard.set(df.string(from: hours[hours.count - 2]), forKey: "PickedDay")
//                                                        bookingDay = df.string(from: hours.last!)
                                                        UserDefaults.standard.set(hourFormatter.string(from: hours[hours.count - 2]), forKey: "PickedHour")

//                                                    }
                                                }
                                            }, label: {
                                                if selectedHour == 2{
                                                    Text(hourFormatter.string(from: hours[hours.count - 2]))
                                                        .foregroundColor(Color("Color-white"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-red"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }else{
                                                    Text(hourFormatter.string(from: hours[hours.count - 2]))
                                                        .foregroundColor(Color("Color-red"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-white"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }
                                                
                                            })
                                            Spacer()
                                            Button(action: {
                                                withAnimation{
//                                                    if(bookingDay == "Now"){
//                                                        bookingHour = hourFormatter.string(from: hours.last!)
                                                    selectedHour = 3
                                                        let df = DateFormatter()
                                                        df.timeStyle = .none
                                                        df.dateStyle = .short
                                                        UserDefaults.standard.set(df.string(from: hours[hours.count - 3]), forKey: "PickedDay")
//                                                        bookingDay = df.string(from: hours.last!)
                                                        UserDefaults.standard.set(hourFormatter.string(from: hours[hours.count - 3]), forKey: "PickedHour")

//                                                    }
                                                }
                                            }, label: {
                                                if selectedHour == 3{
                                                    Text(hourFormatter.string(from: hours[hours.count - 3]))
                                                        .foregroundColor(Color("Color-white"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-red"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }else{
                                                    Text(hourFormatter.string(from: hours[hours.count - 3]))
                                                        .foregroundColor(Color("Color-red"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-white"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }
                                                
                                            })
                                        }
                                        .frame(width: UIScreen.screenWidth - 60)
                                        HStack{
                                            Button(action: {
                                                withAnimation{
//                                                    if(bookingDay == "Now"){
//                                                        bookingHour = hourFormatter.string(from: hours.last!)
                                                    selectedHour = 4
                                                        let df = DateFormatter()
                                                        df.timeStyle = .none
                                                        df.dateStyle = .short
                                                        UserDefaults.standard.set(df.string(from: hours[hours.count - 4]), forKey: "PickedDay")
//                                                        bookingDay = df.string(from: hours.last!)
                                                        UserDefaults.standard.set(hourFormatter.string(from: hours[hours.count - 4]), forKey: "PickedHour")

//                                                    }
                                                }
                                            }, label: {
                                                if selectedHour == 4{
                                                    Text(hourFormatter.string(from: hours[hours.count - 4]))
                                                        .foregroundColor(Color("Color-white"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-red"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }else{
                                                    Text(hourFormatter.string(from: hours[hours.count - 4]))
                                                        .foregroundColor(Color("Color-red"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-white"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }
                                                
                                            })
                                            Spacer()
                                            Button(action: {
                                                withAnimation{
//                                                    if(bookingDay == "Now"){
//                                                        bookingHour = hourFormatter.string(from: hours.last!)
                                                    selectedHour = 5
                                                        let df = DateFormatter()
                                                        df.timeStyle = .none
                                                        df.dateStyle = .short
                                                        UserDefaults.standard.set(df.string(from: hours[hours.count - 5]), forKey: "PickedDay")
//                                                        bookingDay = df.string(from: hours.last!)
                                                        UserDefaults.standard.set(hourFormatter.string(from: hours[hours.count - 5]), forKey: "PickedHour")

//                                                    }
                                                }
                                            }, label: {
                                                if selectedHour == 5{
                                                    Text(hourFormatter.string(from: hours[hours.count - 5]))
                                                        .foregroundColor(Color("Color-white"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-red"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }else{
                                                    Text(hourFormatter.string(from: hours[hours.count - 5]))
                                                        .foregroundColor(Color("Color-red"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-white"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }
                                                
                                            })

                                            Spacer()
                                            Button(action: {
                                                withAnimation{
//                                                    if(bookingDay == "Now"){
//                                                        bookingHour = hourFormatter.string(from: hours.last!)
                                                    selectedHour = 6
                                                        let df = DateFormatter()
                                                        df.timeStyle = .none
                                                        df.dateStyle = .short
                                                        UserDefaults.standard.set(df.string(from: hours.first!), forKey: "PickedDay")
//                                                        bookingDay = df.string(from: hours.last!)
                                                        UserDefaults.standard.set(hourFormatter.string(from: hours.first!), forKey: "PickedHour")

//                                                    }
                                                }
                                            }, label: {
                                                if selectedHour == 6{
                                                    Text(hourFormatter.string(from: hours.first!))
                                                        .foregroundColor(Color("Color-white"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-red"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }else{
                                                    Text(hourFormatter.string(from: hours.first!))
                                                        .foregroundColor(Color("Color-red"))
                                                        .font(.custom("SFProRounded-light", size: 18) )
                                                        .lineLimit(1)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 5)
                                                        .background(Color("Color-white"))
                                                        .cornerRadius(30)
                                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                                }
                                                
                                            })

                                        }
                                        .frame(width: UIScreen.screenWidth - 60)
                                    }
                                    Spacer()
                                        .frame(height:20)
                                    HStack{
                                        Spacer()
                                            .frame(width:20)
                                        Text("Date:")
                                            .font(.custom("SFProRounded-Light", size: 18) )
                                            .lineLimit(1)
                                            .foregroundColor(Color("Color-red"))
                                        Spacer()
                                    }
                                    HStack{
                                        DatetimePicker(currentDate: $currentDate)
                                            .padding()
    //                                .simultaneousGesture(TapGesture().onEnded {
//                                  print("Textfield pressed")
//                                })
                                    }
                                    .frame(width: UIScreen.screenWidth - 60)
                                    .background(Color("Color-white"))
                                    .cornerRadius(30)
                                    .padding()
                                    .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                    Button(action: {
                                        withAnimation{
                                            isShowingPicker.toggle()
                                        }
                                    }, label: {
                                        Text("Confirm")
                                            .font(.custom("SFProRounded-Semibold", size: 23) )
                                            .foregroundColor(Color("Color-white"))
                                            .lineLimit(1)
                                            .frame(width: UIScreen.screenWidth - 60, height: 40, alignment: .center)
                                        .background(Color("Color-red"))
                                        .cornerRadius(30)
                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                    })
                                    
                                    Spacer()
                                        .frame(height:20)
                                }
                                .background(Color("Color-yellow"))
                                .cornerRadius(30)
                                .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                .padding(15)
                                .frame(width: UIScreen.screenWidth)
                            }
                            else{
                        VStack{
                            LazyVGrid(columns: threeColumnGrid) {
                                if showFullList {
                                    ForEach(dividers, id: \.self) { divider in
                                        Button(action: {
                                            
                                            dividerID = divider["ID"] as! Int

                                            Task{
                                                await divide()
                                            }
                                        }, label: {
                                            ZStack{
                                                AsyncImage(url: URL(string: "https://yemekvar.az/images/Reservation-Divider/" + (divider["PhotoURL"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                } placeholder: {
        //                                            VStack{}
        //                                                .background(Color.gray)

                                                }
                                           
                                                
                                                    .frame(width: (UIScreen.screenWidth - 40)/3, height: (UIScreen.screenWidth - 40)/3)

                                                VStack{
                                                    HStack{
                                                        Text((divider["Name"]  as! String))
                                                            .font(.custom("SFProRounded-Regular", size: 15) )
                                                            .lineLimit(1)
            //                                                .foregroundColor(Color("Color-red"))
                                                    }
                                                    Spacer()
                                                        .frame(height:5)
                                                }
                                                .frame(width: (UIScreen.screenWidth - 40)/3, height: 40)
                                                .background(Color("Color-white"))
                                                .foregroundColor(Color("Color-black"))
                                                .cornerRadius(20)
    //                                            .position(x: (UIScreen.screenWidth - 95)/5, y: (UIScreen.screenWidth - 105)/3)
                                                .padding(.top,(UIScreen.screenWidth - 40)/4)
                                            }
                                            .frame(width: (UIScreen.screenWidth - 40)/3, height: (UIScreen.screenWidth - 40)/3)
            //                                    .background(Color.white)
                                                .cornerRadius(20)
                                                .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
                                        })
                                        
                                    }

                                }
                                else{
                                    ForEach(dividers.prefix(3), id: \.self) { divider in
                                        Button(action: {
                                            dividerID = divider["ID"] as! Int
                                            Task{
                                                await divide()
                                            }
                                        }, label: {
                                            ZStack{
                                                AsyncImage(url: URL(string: "https://yemekvar.az/images/Reservation-Divider/" + (divider["PhotoURL"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                } placeholder: {
        //                                            VStack{}
        //                                                .background(Color.gray)

                                                }
                                           
                                                
                                                    .frame(width: (UIScreen.screenWidth - 40)/3, height: (UIScreen.screenWidth - 40)/3)

                                                VStack{

                                                    HStack{
                                                        Text((divider["Name"]  as! String))
                                                            .font(.custom("SFProRounded-Regular", size: 15) )
                                                            .lineLimit(1)
            //                                                .foregroundColor(Color("Color-red"))
                                                    }
                                                    Spacer()
                                                        .frame(height:5)
                                                }
                                                .frame(width: (UIScreen.screenWidth - 40)/3, height: 40)
                                                .background(Color("Color-white"))
                                                .foregroundColor(Color("Color-black"))
                                                .cornerRadius(20)
    //                                            .position(x: (UIScreen.screenWidth - 95)/5, y: (UIScreen.screenWidth - 105)/3)
                                                .padding(.top,(UIScreen.screenWidth - 40)/4)
                                            }
                                            .frame(width: (UIScreen.screenWidth - 40)/3, height: (UIScreen.screenWidth - 40)/3)
            //                                    .background(Color.white)
                                                .cornerRadius(20)
                                                .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
                                        })
                                        
                                    }

                                }
                            }
                            VStack{
                                Spacer()
                                    .frame(height:10)
                                if showFullList {
                                    Button(action: {
                                        withAnimation{
                                            showFullList.toggle()
                                        }
                                    }, label: {
                                        HStack{
                                            Text("See less")
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Image("Icon-up")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 10, height: 20, alignment: .center)
                                        }
                                    })
                                }
                                else{
                                    Button(action: {
                                        withAnimation{
                                            showFullList.toggle()
                                        }
                                    }, label: {
                                        HStack{
                                            Text("See all categories")
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Image("Icon-down-red")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 10, height: 20, alignment: .center)
                                        }
                                    })
                                }
                                
                                Spacer()
                                    .frame(height:20)
                            }
                            if restaurants.count > 0{
                            HStack{
                                Spacer()
                                    .frame(width:15)
                                Text("Available for today’s dinner")
                                    .font(.custom("SFProRounded-Light", size: 22) )
                                    .lineLimit(1)
                                    .padding(.trailing)
                                    .foregroundColor(Color("Color-red"))
                                Spacer()
//                                Text("View all")
//                                    .font(.custom("SFProRounded-Light", size: 15) )
//                                    .lineLimit(1)
//                                    .foregroundColor(Color("Color-red"))
//                                Image("Icon-right")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width:10, height:10)
//                                Spacer()
//                                    .frame(width:15)
                            }
                            ScrollView(.horizontal) {
                                Spacer()
                                    .frame(height:20)
                                HStack(spacing: 20) {
                                    Spacer()
                                        .frame(width:0)
                                    ForEach(restaurants, id: \.self) { restaurant in
                                        Button(action: {
                                            restID = restaurant["ID"] as! Int
                                            withAnimation{
                                                goToRestaurant.toggle()
                                            }
                                        }, label: {
                                            ZStack{
                                                AsyncImage(url: URL(string: "https://yemekvar.az/images/Restaurant-Images/" + (restaurant["Unique_Num"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "/" + (restaurant["PhotoURL"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! )){ image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                } placeholder: {
                                                    VStack{}
                                                        .background(Color.gray)
                                                    
                                                }
                                                    .clipped()
                                                HStack{
                                                    VStack{
                                                        ZStack{
                                                            Text( (restaurant["Type_1"]  as! String) )
                                                                .frame(width: 50, height: 10, alignment: .leading)
                                                                .padding()
                                                                .foregroundColor(Color("Color-red"))
                                                                .font(.custom("SFProRounded-Regular", size: 21) )
                                                                .lineLimit(1)
                                                                .background(Color("Color-white"))
                                                                .cornerRadius(30)
                                                                //.position(x: 110, y: 40)
                //                                                .padding(.bottom,160)
                //                                                .padding(.trailing,UIScreen.screenWidth/2)
                                                            Image("Icon-star")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: 17, height: 17)
                                                                //.position(x: 130, y: 40)
                //                                                .padding(.bottom,160)
                                                                .padding(.leading,50)
                                                        }
                                                    }
                                                    
                                                    Spacer()
                                                    if loggedID != ""{
                                                        if favouriteRestaurants.contains(restaurant["ID"] as! Int){
                                                            Button(action: {
                                                                restID = restaurant["ID"] as! Int
                                                                Task{
                                                                    await removeFav()
                                                                }
                                                            }, label: {
                                                                Image("Icon-heart-red")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 20, height: 20)
                                                                    .padding(10)
                                                                    .background(Color("Color-yellow"))
                                                                    .cornerRadius(30)
                                        //                            .position(x: UIScreen.screenWidth - 60, y: 215)
        //                                                            .padding(.bottom,160)
        //                                                            .padding(.leading,(UIScreen.screenWidth/2 + 40))
                                                                    .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                                                            })
                                                        }
                                                        else{
                                                                Button(action: {
                                                                    restID = restaurant["ID"] as! Int
                                                                    Task{
                                                                        await addFav()
                                                                    }
                                                                }, label: {
                                                                    Image("Icon-heart")
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: 20, height: 20)
                                                                        .padding(10)
                                                                        .background(Color("Color-red"))
                                                                        .cornerRadius(30)
                                                                        //.position(x: 120, y: 40)
        //                                                                .padding(.bottom,160)
        //                                                                .padding(.leading,(UIScreen.screenWidth/2 + 40))
                                                                })
                                                        }
                                                    }

                                                }
                                                .padding(.bottom,160)
                                                .frame(width: UIScreen.screenWidth - 70)
                                                VStack{
                                                    Spacer()
                                                        .frame(height:10)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)
                                                        Text( (restaurant["Name"]  as! String) )
                                                            .font(.custom("SFProRounded-Regular", size: 22) )
                                                            .lineLimit(1)
                                                            .padding(.trailing)
                                                            .foregroundColor(Color("Color-red"))
                                                        Spacer()
    //                                                    if restaurant["IsReservable"]  as! Bool{
    //                                                        Button(action: {}, label: {
    //                                                            Text("Tables available")
    //                                                                .font(.custom("SFProRounded-Light", size: 12) )
    //                                                                .lineLimit(1)
    //                                                                .foregroundColor(Color("Color-red"))
    //                                                            Image("Icon-right")
    //                                                                .resizable()
    //                                                                .scaledToFit()
    //                                                                .frame(width:6, height:10)
    //                                                        })
    //                                                    }
    //
    //                                                    Spacer()
    //                                                        .frame(width:10)
                                                    }
                                                    VStack (alignment: .trailing) {
                                                        HStack{
                                                            Spacer()
                                                                .frame(width:20)
                                                            ForEach((restaurant["Tags"] as! [String]), id: \.self) { tag in

                                                            Text(tag)
                                                                .frame(width: tag.widthOfString(usingFont: UIFont.systemFont(ofSize: 13, weight: .bold)), height:26)
                                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                                .lineLimit(1)
                                                                .padding(.horizontal)
                                                                .background(Color("Color-gray"))
                                                                .cornerRadius(20)
                                                                .foregroundColor(Color("Color-black"))
                                                            }
                                                        }
                                                        .frame(height: 36)
                                                        Spacer()
                                                            .frame(height:20)
                                                    }
                                                    .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .leading)
                                                    
                                                }
                                                .frame(width: UIScreen.screenWidth - 40, height: 80, alignment: .top)
                                                .background(Color("Color-white"))
                                                .cornerRadius(20)
                                                .padding(.top, 160)
                                            }
                                                .frame(width: UIScreen.screenWidth - 40, height: 240)
                                                .background(Color("Color-white"))
                                                .cornerRadius(20)
                                                .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
                                        })
                                        .fullScreenCover(isPresented: $goToRestaurant, content: {
                                            if restID != 0{
                                                ReservationRestaurantView(id: restID)
                                            }
                                            
                                        })
                                    }
                                    Spacer()
                                        .frame(width:100)
                                }
                                .frame(height: 260, alignment: .topLeading)

                            }
                            .frame(height: 260, alignment: .topLeading)
                            }
                        }
                                if nearestRestaurants.count > 0{
                        HStack{
                            Spacer()
                                .frame(width:15)
                            Text("Nearest restaurants")
                                .font(.custom("SFProRounded-Light", size: 22) )
                                .lineLimit(1)
                                .padding(.trailing)
                                .foregroundColor(Color("Color-red"))
                            Spacer()
//                            Text("View all")
//                                .font(.custom("SFProRounded-Light", size: 15) )
//                                .lineLimit(1)
//                                .foregroundColor(Color("Color-red"))
//                            Image("Icon-right")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 10, height: 10)
//                            Spacer()
//                                .frame(width:15)
                        }
                        ScrollView(.horizontal) {
                            Spacer()
                                .frame(height:20)
                            HStack(spacing: 20) {
                                Spacer()
                                    .frame(width:0)
                                ForEach(nearestRestaurants, id: \.self) { restaurant in
                                    Button(action: {
                                        restID = restaurant["ID"] as! Int
                                        withAnimation{
                                            goToRestaurant.toggle()
                                        }
                                    }, label: {
                                        ZStack{
                                            AsyncImage(url: URL(string: "https://yemekvar.az/images/Restaurant-Images/" + (restaurant["uniqueNum"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "/" + (restaurant["photoURL"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! )){ image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            } placeholder: {
                                                VStack{}
                                                    .background(Color.gray)
                                                
                                            }
                                                .clipped()
                                            HStack{
                                                VStack{
                                                    ZStack{
                                                        Text( (restaurant["rating"]  as! String) )
                                                            .frame(width: 50, height: 10, alignment: .leading)
                                                            .padding()
                                                            .foregroundColor(Color("Color-red"))
                                                            .font(.custom("SFProRounded-Regular", size: 21) )
                                                            .lineLimit(1)
                                                            .background(Color("Color-white"))
                                                            .cornerRadius(30)
                                                            //.position(x: 110, y: 40)
            //                                                .padding(.bottom,160)
            //                                                .padding(.trailing,UIScreen.screenWidth/2)
                                                        Image("Icon-star")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 17, height: 17)
                                                            //.position(x: 130, y: 40)
            //                                                .padding(.bottom,160)
                                                            .padding(.leading,50)
                                                    }
                                                }
                                                
                                                Spacer()
                                                if loggedID != ""{
                                                    if favouriteRestaurants.contains(restaurant["ID"] as! Int){
                                                        Button(action: {
                                                            restID = (restaurant["ID"] as! Int)

                                                                Task{
                                                                    await removeFav()
                                                                }

                                                        }, label: {
                                                            Image("Icon-heart-red")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: 20, height: 20)
                                                                .padding(10)
                                                                .background(Color("Color-yellow"))
                                                                .cornerRadius(30)
                                    //                            .position(x: UIScreen.screenWidth - 60, y: 215)
    //                                                            .padding(.bottom,160)
    //                                                            .padding(.leading,(UIScreen.screenWidth/2 + 40))
                                                                .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                                                        })
                                                    }
                                                    else{
                                                            Button(action: {
                                                                    restID = (restaurant["ID"] as! Int)

                                                                    Task{
                                                                        await addFav()
                                                                    }
                                                            }, label: {
                                                                Image("Icon-heart")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .frame(width: 20, height: 20)
                                                                    .padding(10)
                                                                    .background(Color("Color-red"))
                                                                    .cornerRadius(30)
                                                                    //.position(x: 120, y: 40)
    //                                                                .padding(.bottom,160)
    //                                                                .padding(.leading,(UIScreen.screenWidth/2 + 40))
                                                            })
                                                    }
                                                }

                                            }
                                            .padding(.bottom,160)
                                            .frame(width: UIScreen.screenWidth - 70)
                                            VStack{
                                                Spacer()
                                                    .frame(height:10)
                                                HStack{
                                                    Spacer()
                                                        .frame(width:20)
                                                    Text( (restaurant["name"]  as! String) )
                                                        .font(.custom("SFProRounded-Regular", size: 22) )
                                                        .lineLimit(1)
                                                        .padding(.trailing)
                                                        .foregroundColor(Color("Color-red"))
                                                    Spacer()
//                                                    if restaurant["isReservable"]  as! Bool{
//                                                        Button(action: {}, label: {
//                                                            Text("Tables available")
//                                                                .font(.custom("SFProRounded-Light", size: 12) )
//                                                                .lineLimit(1)
//                                                                .foregroundColor(Color("Color-red"))
//                                                            Image("Icon-right")
//                                                                .resizable()
//                                                                .scaledToFit()
//                                                                .frame(width:6, height:10)
//                                                        })
//                                                    }
                                                    
                                                    Spacer()
                                                        .frame(width:10)
                                                }
                                                VStack (alignment: .trailing) {
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)
                                                        if (restaurant["tags"] as? String ?? "").count > 1{
                                                            ForEach((restaurant["tags"] as! String).components(separatedBy: ","), id: \.self) { tag in

                                                            Text(tag)
                                                                .frame(width: tag.widthOfString(usingFont: UIFont.systemFont(ofSize: 13, weight: .bold)), height:26)
                                                                .foregroundColor(Color("Color-black"))

                                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                                .lineLimit(1)
                                                                .padding(.horizontal)
                                                                .foregroundColor(.black)
                                                                .background(Color("Color-gray"))
                                                                .cornerRadius(20)
                                                            }
                                                        }
                                                    }
                                                    .frame(height: 36)
                                                    Spacer()
                                                        .frame(height:20)
                                                }
                                                .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .leading)
                                                
                                            }
                                            .frame(width: UIScreen.screenWidth - 40, height: 80, alignment: .top)
                                            .background(Color("Color-white"))
                                            .cornerRadius(20)
                                            .padding(.top, 160)
                                        }
                                            .frame(width: UIScreen.screenWidth - 40, height: 240)
                                            .background(Color("Color-white"))
                                            .cornerRadius(20)
                                            .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
                                    })
                                    .fullScreenCover(isPresented: $goToRestaurant, content: {
                                        if restID != 0{
                                            ReservationRestaurantView(id: restID)
                                        }
                                    })
                                    
                                }
                                Spacer()
                                    .frame(width:100)
                                
                            }
                            .frame(height: 260, alignment: .topLeading)

                        }
                            .frame(height: 260, alignment: .topLeading)
                                }

                    }
                            Spacer()
                                .frame(height:100)
                }
                
            }
            .background(Color("Color-white"))
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
            if showAlert {
                VStack{

                    CustomAlertView(showAlert: $showAlert, closeApp: $closeApp, message: message)

                }
//                    .background(Color("Color-white"))
                .background(Color.black.opacity(0.8))
                .shadow(color: Color.black, radius: 4, x: 0, y: 1)

                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .transition(.opacity)
            }

        }
        .ignoresSafeArea(.all)
        }
        .task({
            await loadData()
        })
    }
    func divide() async{
        let decimalLat = Double(lat) ?? 0.0
        let roundedLat = round(decimalLat * 100000)/100000
        let latitude = String(roundedLat)
        let decimalLon = Double(lon) ?? 0.0
        let roundedLon = round(decimalLon * 100000)/100000
        let longitude = String(roundedLon)
        var coords = latitude + "-" + longitude
        if selectedAddress != "" {
            coords = UserDefaults.standard.string(forKey: "selectedLatitude")! + "-" + UserDefaults.standard.string(forKey: "selectedLongitude")!
        }
        withAnimation{
            isLoading.toggle()
        }

        guard let url = URL(string: "https://yemekvar.az/api/reservation/divide") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["coords": coords, "dividerId": String(dividerID)]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                    restaurants = json!["featuredRestaurants"] as! [NSDictionary]
                    nearestRestaurants = json!["nearest"] as! [NSDictionary]
                    withAnimation{
                        isLoading.toggle()
                    }
                }
                else{
                    message = "Error occured. Please try again later"

                    withAnimation{
                        showAlert.toggle()
                        isLoading.toggle()
                    }
                }
            }
            catch{
                print(error)
            }
        }.resume()
    }
    func removeFav() async{
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/user/removefromfavourites") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["userId": loggedID, "restId": String(restID)]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    message = "Successfully removed from favourites"
                    let decimalLat = Double(lat) ?? 0.0
                    let roundedLat = round(decimalLat * 100000)/100000
                    let latitude = String(roundedLat)
                    let decimalLon = Double(lon) ?? 0.0
                    let roundedLon = round(decimalLon * 100000)/100000
                    let longitude = String(roundedLon)
                    var coords = latitude + "-" + longitude
                    if selectedAddress != "" {
                        coords = UserDefaults.standard.string(forKey: "selectedLatitude")! + "-" + UserDefaults.standard.string(forKey: "selectedLongitude")!
                    }
                    guard let url = URL(string: "https://yemekvar.az/api/reservation/home") else {
                        return
                    }
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    let body: [String: String] = ["coords": coords, "userID": loggedID]
                    let finalBody = try! JSONSerialization.data(withJSONObject: body)
                    request.httpBody = finalBody
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let data = data else { return }
                        do{
                        let str = String(decoding: data, as: UTF8.self)
                            if !(str.lowercased().contains("error")){
                                let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                                
                                restaurants = json!["restaurants"] as! [NSDictionary]
                                nearestRestaurants = json!["nearest"] as! [NSDictionary]
                                favouriteRestaurants = json!["favs"] as! [Int]
                                dividers = json!["dividers"] as! [NSDictionary]
                                dividerID = dividers.first!["ID"] as! Int
                                withAnimation{
                                    showAlert.toggle()
                                    isLoading.toggle()
                                }
                            }
                            else{
                                message = "Error occured. Please try again later"

                                withAnimation{
                                    showAlert.toggle()
                                    isLoading.toggle()
                                }
                            }
                        }
                        catch{
                            print(error)
                        }
                    }.resume()

                }
                else{
                    message = "Error occured. Please try again later"

                    withAnimation{
                        showAlert.toggle()
                        isLoading.toggle()
                    }
                }
            
        }.resume()
    }
    func addFav() async{
        withAnimation{
            isLoading.toggle()
        }

        guard let url = URL(string: "https://yemekvar.az/api/user/addtofavourites") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["userId": loggedID, "restId": String(restID)]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    message = "Successfully added to favourites"
                    let decimalLat = Double(lat) ?? 0.0
                    let roundedLat = round(decimalLat * 100000)/100000
                    let latitude = String(roundedLat)
                    let decimalLon = Double(lon) ?? 0.0
                    let roundedLon = round(decimalLon * 100000)/100000
                    let longitude = String(roundedLon)
                    var coords = latitude + "-" + longitude
                    if selectedAddress != "" {
                        coords = UserDefaults.standard.string(forKey: "selectedLatitude")! + "-" + UserDefaults.standard.string(forKey: "selectedLongitude")!
                    }
                    guard let url = URL(string: "https://yemekvar.az/api/reservation/home") else {
                        return
                    }
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    let body: [String: String] = ["coords": coords, "userID": loggedID]
                    let finalBody = try! JSONSerialization.data(withJSONObject: body)
                    request.httpBody = finalBody
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let data = data else { return }
                        do{
                        let str = String(decoding: data, as: UTF8.self)
                            if !(str.lowercased().contains("error")){
                                let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                                
                                restaurants = json!["restaurants"] as! [NSDictionary]
                                nearestRestaurants = json!["nearest"] as! [NSDictionary]
                                favouriteRestaurants = json!["favs"] as! [Int]
                                dividers = json!["dividers"] as! [NSDictionary]
                                dividerID = dividers.first!["ID"] as! Int
                                withAnimation{
                                    isLoading.toggle()
                                    showAlert.toggle()

                                }
                            }
                            else{
                                message = "Error occured. Please try again later"

                                withAnimation{
                                    showAlert.toggle()
                                    isLoading.toggle()
                                }
                            }
                        }
                        catch{
                            print(error)
                        }
                    }.resume()
                }
                else{
                    message = "Error occured. Please try again later"

                    withAnimation{
                        showAlert.toggle()
                        isLoading.toggle()
                    }
                }
            
        }.resume()
    }
    func loadData() async{
        let decimalLat = Double(lat) ?? 0.0
        let roundedLat = round(decimalLat * 100000)/100000
        let latitude = String(roundedLat)
        let decimalLon = Double(lon) ?? 0.0
        let roundedLon = round(decimalLon * 100000)/100000
        let longitude = String(roundedLon)
        var coords = latitude + "-" + longitude
        if selectedAddress != "" {
            coords = UserDefaults.standard.string(forKey: "selectedLatitude")! + "-" + UserDefaults.standard.string(forKey: "selectedLongitude")!
        }
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/reservation/home") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["coords": coords, "userID": loggedID]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                    
                    restaurants = json!["restaurants"] as! [NSDictionary]
                    nearestRestaurants = json!["nearest"] as! [NSDictionary]
                    favouriteRestaurants = json!["favs"] as! [Int]
                    dividers = json!["dividers"] as! [NSDictionary]
                    dividerID = dividers.first!["ID"] as! Int
                    withAnimation{
                        isLoading.toggle()
                    }
                }
                else{
                    message = "Error occured. Please try again later"

                    withAnimation{
                        showAlert.toggle()
                        isLoading.toggle()
                    }
                }
            }
            catch{
                print(error)
            }
        }.resume()
    }
}

struct ReservationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationHomeView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 13 Pro Max")
    }
}
extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}
