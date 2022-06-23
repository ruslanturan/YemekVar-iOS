//
//  ReservationsView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 16.05.22.
//

import SwiftUI
public class Reservation: Identifiable{
    var name: String = ""
    var address: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var guestCount: String = ""
    var status: String = ""
    var statusColor: Color = .green
    var date: String = ""
    public var id: Int = 0
    var statusID: Int = 0

    public init(name: String, guestCount: String, address: String, latitude: String, longitude: String, date: String, id: Int, statusID: Int){
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
        self.id = id
        self.guestCount = guestCount
        self.statusID = statusID
        if statusID == 0{
            status = "Waiting"
        }
        else if statusID == 1{
            status = "Accepted"
        }
        else if statusID == 2{
            status = "Rejected"
            statusColor = .red

        }
        else if statusID == 3{
            status = "Finished"
        }
        else if statusID == 4{
            status = "Canceled"
            statusColor = .red

        }
    }
}

struct ReservationsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State var goToReservation = false
    @State var upcomingIsEmpty = false
    @State var historyIsEmpty = false
    @State var showAlert = false
    @State var isLoading = false
    @State var selected = 0
    @State var closeApp = false
    @State var message = ""
    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""
    @State var upcoming: [Reservation] = []
    @State var history: [Reservation] = []
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
        VStack{
            Spacer()
                .frame(height:30)
            HStack{
                Spacer()
                    .frame(width:20)
                Button(action: {
                    withAnimation{
                        self.mode.wrappedValue.dismiss()
                    }
                    
                }, label: {
                    Image("Icon-back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(10)
                })

                Text("My bookings")
                   // .frame(height:26)
                    .font(.custom("SFProRounded-Light", size: 23) )
                Spacer()
            }
            TopBar(selected: self.$selected)
                .frame(width: UIScreen.screenWidth - 40)

            ScrollView{
                if self.selected == 0 {
                    if upcomingIsEmpty{
                    VStack{
                        Spacer()
                        Image("Icon-calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width:130,height: 130)
                        Text("No history yet")
                           // .frame(height:26)
                            .font(.custom("SFProRounded-Light", size: 30) )
                        Text("Hit the red button down below to Create an order")
                           // .frame(height:26)
                            .font(.custom("SFProRounded-Light", size: 20) )
                            .multilineTextAlignment(.center)
                            .frame(width:UIScreen.screenWidth - 160)
                        Spacer()
                        HStack{
                            Spacer()
                            Text("Start ordering")
                                .font(.custom("SFProRounded-Light", size: 18) )
                                .foregroundColor(Color("Color-white"))
                                .lineLimit(1)
                                //.position(x: 110, y: 40)
                                //.padding(.bottom,10)
                           Spacer()
                        }
                        .padding()
                        .background(Color("Color-red"))
                        .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .trailing)
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                    }
                    .frame(height: UIScreen.screenHeight - 250)
                    }
                    else{
                        ForEach(upcoming){ reserv in

                        VStack{
                            VStack{
                                Spacer()
                                    .frame(height:10)
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    Text(reserv.name)
                                        .font(.custom("SFProRounded-Regular", size: 30) )
                                        .lineLimit(1)
                                        .foregroundColor(Color("Color-red"))
                                    Spacer()
                                    Text("#" + String(reserv.id).PadLeft(totalWidth: 6, byString: "0"))
                                       // .frame(height:26)
                                        .font(.custom("SFProRounded-Light", size: 20) )
                                    Spacer()
                                        .frame(width:20)
                                }
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    VStack{
                                        HStack{
                                            HStack{
                                                Spacer()
                                                Image("Icon-user-red")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width:16, height:16)
                                                Text(reserv.guestCount)
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
                                                Text(reserv.date)
                                                    .font(.custom("SFProRounded-Light", size: 18))
                                                    .foregroundColor(Color("Color-red"))
                                                    .lineLimit(1)
                                                    //.position(x: 110, y: 40)
                                                Spacer()
                                            }
                                            .background(Color("Color-yellow"))
                                            .frame(width: 200, height: 40, alignment: .trailing)
                                            .cornerRadius(30)
                    //                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                        }
                                    }
                                    VStack{
                                        HStack{
                                            Text("Status:")
                                               // .frame(height:26)
                                                .font(.custom("SFProRounded-Light", size: 21) )
                                        }
                                        HStack{
                                            Text(reserv.status)
                                                .font(.custom("SFProRounded-Regular", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color.green)
                                        }
                                    }
                                    .frame(width:100)
                                    Spacer()
                                        .frame(width:20)
                                }
                                .frame(width:UIScreen.screenWidth - 40)
                                Text(" ")
                                    .frame(
                                      minWidth: 0,
                                      maxWidth: UIScreen.screenWidth - 40,
                                      minHeight: 0,
                                      maxHeight: 1,
                                      alignment: .leading
                                    )
                                    .background(Color("Color-red"))
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    Text(reserv.address)
                                       // .frame(height:26)
                                        .font(.custom("SFProRounded-Light", size: 18) )
                                    Spacer()
//                                    Text("See on map")
//                                       // .frame(height:26)
//                                        .font(.custom("SFProRounded-Light", size: 18) )
//                                        .foregroundColor(Color("Color-red"))
//                                    Spacer()
//                                        .frame(width:20)

                                }

                                    HStack{
                                        Spacer()
                                            .frame(width:20)
                                        Text("Cancel")
                                           // .frame(height:26)
                                            .font(.custom("SFProRounded-Light", size: 21) )
                                            
                                            .lineLimit(1)
                                            .foregroundColor(Color("Color-red"))
                                            .frame(width:UIScreen.screenWidth/3, height: 40)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 30)
                                                    .stroke(Color("Color-red"), lineWidth: 3)
                                            )
                                        Spacer()
                                        Button(action: {
                                            UserDefaults.standard.set(reserv.id, forKey: "ReservID")
                                            withAnimation{
                                                goToReservation.toggle()
                                            }
                                        }, label: {
                                            Text("Info")
                                               // .frame(height:26)
                                                .font(.custom("SFProRounded-Light", size: 21) )
                                                
                                                .lineLimit(1)
                                                .frame(width:UIScreen.screenWidth*2/5, height: 40)
                                                .background(Color("Color-red"))
                                                .foregroundColor(Color("Color-white"))
                                                .cornerRadius(30)
                                        })
                                        .sheet(isPresented: $goToReservation, onDismiss: {
                                            UserDefaults.standard.set(0, forKey: "ReservID")
                                        }) {
                                            VStack{
                                                Spacer()
                                                ReservationView()
                                                    .frame(height: UIScreen.screenHeight - 200)
                                                                .clearModalBackground()
                                            }
                                            
                                            
                                        }
                                        Spacer()
                                            .frame(width:20)

                                    }
                                
//                                }
//                                else {
//                                    HStack{
//                                        Spacer()
//                                            .frame(width:20)
//                                        Text("Info")
//                                           // .frame(height:26)
//                                            .font(.custom("SFProRounded-Light", size: 21) )
//
//                                            .lineLimit(1)
//                                            .frame(width:UIScreen.screenWidth - 40, height: 40)
//                                            .background(Color("Color-red"))
//                                            .foregroundColor(Color("Color-white"))
//                                            .cornerRadius(30)
//                                        Spacer()
//                                            .frame(width:20)
//
//                                    }
//                                }
                                Spacer()
                                    .frame(height:10)
                            }
                            .frame(width:UIScreen.screenWidth - 20)
                            .background(Color("Color-white"))
                            .cornerRadius(30)
                            .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                            .padding()
                        }
                        }
                    }
                }
                else{
                    if historyIsEmpty{
                    VStack {
                        Spacer()
                        Image("Icon-calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width:130,height: 130)
                        Text("No history yet")
                           // .frame(height:26)
                            .font(.custom("SFProRounded-Light", size: 30) )
                        Text("Hit the red button down below to Create an order")
                           // .frame(height:26)
                            .font(.custom("SFProRounded-Light", size: 20) )
                            .multilineTextAlignment(.center)
                            .frame(width:UIScreen.screenWidth - 160)
                        Spacer()
                        HStack{
                            Spacer()
                            Text("Start ordering")
                                .font(.custom("SFProRounded-Light", size: 18) )
                                .foregroundColor(Color("Color-white"))
                                .lineLimit(1)
                                //.position(x: 110, y: 40)
                                //.padding(.bottom,10)
                           Spacer()
                        }
                        .padding()
                        .background(Color("Color-red"))
                        .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .trailing)
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                    }
                    .frame(height: UIScreen.screenHeight - 250)
                    }
                    else{
                        ForEach(history){ reservH in

                    VStack{
                        VStack{
                            Spacer()
                                .frame(height:10)
                            HStack{
                                Spacer()
                                    .frame(width:20)
                                Text(reservH.name)
                                    .font(.custom("SFProRounded-Regular", size: 30) )
                                    .lineLimit(1)
                                    .foregroundColor(Color("Color-red"))
                                Spacer()
                                Text("#" + String(reservH.id).PadLeft(totalWidth: 6, byString: "0"))
                                   // .frame(height:26)
                                    .font(.custom("SFProRounded-Light", size: 20) )
                                Spacer()
                                    .frame(width:20)

                            }
                            
                            HStack{
                                Spacer()
                                    .frame(width:20)
                                VStack{
                                    HStack{
                                        HStack{
                                            Spacer()
                                            Image("Icon-user-red")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:16, height:16)
                                            Text(reservH.guestCount)
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
                                            Text(reservH.date)
                                                .font(.custom("SFProRounded-Light", size: 18))
                                                .foregroundColor(Color("Color-red"))
                                                .lineLimit(1)
                                                //.position(x: 110, y: 40)
                                            Spacer()
                                        }
                                        .background(Color("Color-yellow"))
                                        .frame(width: 200, height: 40, alignment: .trailing)
                                        .cornerRadius(30)
                //                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                    }
                                }
                                VStack{
                                    HStack{
                                        Text("Status:")
                                           // .frame(height:26)
                                            .font(.custom("SFProRounded-Light", size: 21) )
                                    }
                                    HStack{
                                            Text(reservH.status)
                                                .font(.custom("SFProRounded-Regular", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(reservH.statusColor)
                                    }
                                }
                                .frame(width:100)
                                Spacer()
                                    .frame(width:20)
                            }
                            .frame(width:UIScreen.screenWidth)
                            Text(" ")
                                .frame(
                                  minWidth: 0,
                                  maxWidth: UIScreen.screenWidth - 40,
                                  minHeight: 0,
                                  maxHeight: 1,
                                  alignment: .leading
                                )
                                .background(Color("Color-red"))
                            HStack{
                                Spacer()
                                    .frame(width:20)
                                Text(reservH.address)
                                   // .frame(height:26)
                                    .font(.custom("SFProRounded-Light", size: 18) )
                                Spacer()
//                                Text("See on map")
//                                   // .frame(height:26)
//                                    .font(.custom("SFProRounded-Light", size: 18) )
//                                    .foregroundColor(Color("Color-red"))
//                                Spacer()
//                                    .frame(width:20)

                            }
                            HStack{
                                Spacer()
                                    .frame(width:20)
                                Text("Re-Book")
                                   // .frame(height:26)
                                    .font(.custom("SFProRounded-Light", size: 21) )
                                    
                                    .lineLimit(1)
                                    .frame(width:UIScreen.screenWidth - 40, height: 40)
                                    .background(Color("Color-yellow"))
                                    .foregroundColor(Color("Color-red"))
                                    .cornerRadius(30)
                                Spacer()
                                    .frame(width:20)

                            }
                            Spacer()
                                .frame(height:10)
                        }
                        .frame(width:UIScreen.screenWidth - 20)
                        .background(Color("Color-white"))
                        .cornerRadius(30)
                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                        .padding()
                    }
                        }
                    }
                }
            }
            .frame(width: UIScreen.screenWidth - 40)

        }
        .background(Color("Color-white"))
        .foregroundColor(Color("Color-black"))
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
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)

        }
        .task({
            await loadData()
        })
    }
    func loadData() async{
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/user/reservations") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["userID": loggedID]
//        let body: [String: String] = ["reservID": "1"]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [NSDictionary]
                    if !(json!.isEmpty){
                        for reserv in json! {
//                            let orderMeals = (order["meals"] as! NSArray)
                            let d = reserv["StartDate"] as! String
                            let startIndex = d.firstIndex(of: "-")
                            let nextIndex = d.index(after: startIndex!)

                            let endIndex = d.lastIndex(of: ":")
                            let range = nextIndex..<endIndex!
                            let dd = d[range].replacingOccurrences(of: "-", with: ".").replacingOccurrences(of: "T", with: " ")
                            if reserv["StatusID"] as! Int == 3 || reserv["StatusID"] as! Int == 2 || reserv["StatusID"] as! Int == 4{
                                let r = Reservation(name: reserv["Name"] as! String, guestCount: reserv["GuestCount"] as? String ?? "2", address: reserv["Display_Address"] as! String, latitude:  reserv["Latitude"] as! String, longitude: reserv["Longitude"] as! String, date: dd, id: reserv["ID"] as! Int, statusID: reserv["StatusID"] as! Int)

                                history.append(r)

                            }
                            else{
                                upcoming.append(Reservation(name: reserv["Name"] as! String, guestCount: reserv["GuestCount"] as? String ?? "2", address: reserv["Display_Address"] as! String, latitude:  reserv["Latitude"] as! String, longitude: reserv["Longitude"] as! String, date: dd, id: reserv["ID"] as! Int, statusID: reserv["StatusID"] as! Int))
                            }
                        }
                        if history.isEmpty{
                            historyIsEmpty = true
                        }
                        else if upcoming.isEmpty{
                            upcomingIsEmpty = true
                        }
                    }
                    else{
                        upcomingIsEmpty = true
                        historyIsEmpty = true
                    }
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

struct ReservationsView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationsView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 13 Pro Max")
    }
}
