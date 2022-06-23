//
//  OrderConfirmationView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 17.05.22.
//

import SwiftUI
import Alamofire
struct OrderConfirmationView: View {
    @ObservedObject var location = LocationManager()
    @State var isLoading = false
    @State var goToHome = false
    @State var showAlert = false
    @State var closeApp = false
    @State var message = ""
    @State var selectedAddress = UserDefaults.standard.string(forKey: "selectedStreet") ?? ""
    var lat: String {
        return "\(location.lastKnownLocation?.coordinate.latitude ?? 0.0)"
    }

    var lon: String {
        return "\(location.lastKnownLocation?.coordinate.longitude ?? 0.0)"
    }
    @State private var noContact = true
    @State var selection = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var allCount: Int = 0
    var allCost: Int = 0
    var basketItems: [BasketItem] = []
    public init(){
        self.location.startUpdating()

        let data = UserDefaults.standard.data(forKey: "Basket")

        if data != nil{
            let decoded = try? JSONDecoder().decode([BasketItem].self, from: data!)
            basketItems = decoded!
            for item in basketItems{
                allCount += item.count
                allCost += item.cost
            }
        }
    }
    var body: some View {
        LoadingView(isShowing: $isLoading){
            ZStack{
        VStack{
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
//                    .position(x: 18, y:46)
    //                .padding(.bottom,125)
    //                .padding(.trailing,(UIScreen.screenWidth/2 + 120))
            })
            Text("Order confirmation")
               // .frame(height:26)
                .font(.custom("SFProRounded-Light", size: 23) )
            Spacer()
        }

        ScrollView{
            VStack{

                HStack{
                    Spacer()
                        .frame(width:20)
                    Text("Your order from")
                        .font(.custom("SFProRounded-Regular", size: 21) )
                        .lineLimit(1)
                    Spacer()
//                    Text("#123456")
//                       // .frame(height:26)
//                        .font(.custom("SFProRounded-Light", size: 15) )
//                    Spacer()
//                        .frame(width:20)

                }
                .padding(.bottom,3)
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text(UserDefaults.standard.string(forKey: "RestaurantName")!)
                        .font(.custom("SFProRounded-Regular", size: 30) )
                        .lineLimit(1)
                        .foregroundColor(Color("Color-red"))
                    Spacer()

                }
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text("Location")
                        .font(.custom("SFProRounded-Regular", size: 18) )
                        .lineLimit(1)
                    Spacer()
                    Text(UserDefaults.standard.string(forKey: "RestaurantAddress")!)
                        .font(.custom("SFProRounded-Light", size: 15) )
                        .lineLimit(1)
                    Spacer()
                        .frame(width:20)
                }
                .padding(.top,5)
//                ZStack{
//                    LocationView()
//                        .frame(width:UIScreen.screenWidth - 40, height: 150)
//                        .cornerRadius(20)
//                        .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
//                    Image("Icon-full-screen")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .padding(10)
//                        .background(Color("Color-white"))
//                        .cornerRadius(30)
//                        .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
//                        .position(x: UIScreen.screenWidth - 60, y: 130)
//                }
//                .frame(width:UIScreen.screenWidth - 40, height: 150)
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text("Delivery in 30-40 min")
                        .font(.custom("SFProRounded-Regular", size: 18) )
                        .lineLimit(1)
                    Spacer()
//                    Text("1,5 km to your location")
//                        .font(.custom("SFProRounded-Light", size: 15) )
//                        .lineLimit(1)
//                    Spacer()
//                        .frame(width:20)
                }
                .padding(.top,5)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth - 20,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color("Color-red"))
//                HStack{
//                    VStack{
//                        Text("No-contact delivery")
//                            .font(.custom("SFProRounded-Light", size: 18) )
//                            .lineLimit(1)
//                    }
//
//                        .frame(width: UIScreen.screenWidth - 220)

                        //.foregroundColor(Color("Color-red"))
//                    Image("Icon-info")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width:20,height:20)
//                    VStack{
//                    Toggle("", isOn: $noContact)
//                        .toggleStyle(SwitchToggleStyle(tint: Color("Color-red")))
//                    }
//                    .frame(width:180)
//                }
//                .frame(width:UIScreen.screenWidth - 40)
//                Text(" ")
//                    .frame(
//                      minWidth: 0,
//                      maxWidth: UIScreen.screenWidth - 20,
//                      minHeight: 0,
//                      maxHeight: 1,
//                      alignment: .leading
//                    )
//                    .background(Color("Color-red"))

            }
            VStack{
                if UserDefaults.standard.string(forKey: "UserComment") ?? "" != ""{
                    HStack{
                        Spacer()
                            .frame(width:20)
                        Text("Your comment:")
                           .font(.custom("SFProRounded-Regular", size: 17) )
                           .lineLimit(1)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                            .frame(width:20)
                        Text(UserDefaults.standard.string(forKey: "UserComment")!)
                            .font(.custom("SFProRounded-Light", size: 15) )
                        Spacer()
                        Spacer()
                            .frame(width:20)
                    }
                }

                
//                HStack{
//                    Spacer()
//                        .frame(width:20)
//                    Text("Payment via")
//                        .font(.custom("SFProRounded-Regular", size: 23) )
//                        .lineLimit(1)
//                    Spacer()
//                }
//                .padding(.top, 5)
//                HStack{
//                    Spacer()
//                        .frame(width:30)
//                    Image("Icon-card-red")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .padding(10)
//                    Text("Credit card")
//                       // .frame(height:26)
//                        .font(.custom("SFProRounded-Light", size: 21))
//                    Spacer()
//                    Text("*1234")
//                       // .frame(height:26)
//                        .font(.custom("SFProRounded-Regular", size: 21))
//                        .foregroundColor(Color("Color-red"))
//                    Image("Icon-done")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .padding(10)
//                    Spacer()
//                        .frame(width:30)
//                }
//                Text(" ")
//                    .frame(
//                      minWidth: 0,
//                      maxWidth: UIScreen.screenWidth - 40,
//                      minHeight: 0,
//                      maxHeight: 1,
//                      alignment: .leading
//                    )
//                    .background(Color.gray)
//                HStack{
//                    Spacer()
//                        .frame(width:30)
//                    Image("Icon-card")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .padding(10)
//
//                    Text("Credit card")
//                       // .frame(height:26)
//                        .font(.custom("SFProRounded-Light", size: 21))
//                    Spacer()
//                    Text("*1234")
//                       // .frame(height:26)
//                        .font(.custom("SFProRounded-Regular", size: 21))
//                        .foregroundColor(Color("Color-red"))
//                    Spacer()
//                        .frame(width:80)
//                }
//                Text(" ")
//                    .frame(
//                      minWidth: 0,
//                      maxWidth: UIScreen.screenWidth - 40,
//                      minHeight: 0,
//                      maxHeight: 1,
//                      alignment: .leading
//                    )
//                    .background(Color.gray)
//                HStack{
//                    Spacer()
//                        .frame(width:30)
//                    Image("Icon-cash-gray")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .padding(10)
//                    Text("Cash")
//                       // .frame(height:26)
//                        .font(.custom("SFProRounded-Light", size: 21))
//                    Spacer()
//
//                }
//                HStack{
//                    Spacer()
//                    Text("See payment methods")
//                        .font(.custom("SFProRounded-Light", size: 15) )
//                        .lineLimit(1)
//                        .foregroundColor(Color("Color-red"))
//                        .padding(.bottom)
//                    Spacer()
//                }
                DropdownPicker(title: "Tip the courier", selection: $selection, options: ["0 ₼", "1 ₼", "2 ₼", "3 ₼", "4 ₼","5 ₼"])
                    .cornerRadius(30)
                    .frame(width:UIScreen.screenWidth - 40)
                
            }
            Text(" ")
                .frame(
                  minWidth: 0,
                  maxWidth: UIScreen.screenWidth - 40,
                  minHeight: 0,
                  maxHeight: 1,
                  alignment: .leading
                )
                .background(Color("Color-red"))
            Spacer()
                .frame(height:20)
            Button(action: {
                withAnimation{
                    isLoading.toggle()
                }
                let decimalLat = Double(lat) ?? 0.0
                let roundedLat = round(decimalLat * 100000)/100000
                let latitude = String(roundedLat)
                let decimalLon = Double(lon) ?? 0.0
                let roundedLon = round(decimalLon * 100000)/100000
                let longitude = String(roundedLon)
                var coords = latitude + "-" + longitude
                var address = UserDefaults.standard.string(forKey: "loggedAddress")

                if selectedAddress != "" {
                    coords = UserDefaults.standard.string(forKey: "selectedLatitude")! + "-" + UserDefaults.standard.string(forKey: "selectedLongitude")!
                    address = selectedAddress
                }
                let cost = allCost
                let tip = (UserDefaults.standard.string(forKey: "CourierTip") ?? "0").replacingOccurrences(of: " ₼", with: "")
                let courierTip = Int(tip)!*100
                let restaurantId = UserDefaults.standard.string(forKey: "RestaurantID")!
                let userId = UserDefaults.standard.string(forKey: "loggedID")!
                let comment = UserDefaults.standard.string(forKey: "UserComment")!
                let data = UserDefaults.standard.data(forKey: "Basket")
                if data != nil{
                    let decoded = try? JSONDecoder().decode([BasketItem].self, from: data!)
//                    withAnimation{
//                        isLoading.toggle()
//                    }
                    var meals :[[String: Any]] = []
                    var items :[[String: Any]] = []
                    for meal in decoded!{
                        if meal.itemIDs.count > 0{
                            for i in 0...(meal.itemIDs.count - 1){
                                let item: [String: Any] = [
                                    "itemID": meal.itemIDs[i],
                                    "cost": meal.itemCosts[i]
                                ]
                                items.append(item)
                            }
                        }
                        meals.append([
                            "MealID": meal.id,
                            "Count": meal.count,
                            "TotalSum": meal.cost
                        ])
                    }
                    guard let url = URL(string: "https://yemekvar.az/api/delivery/createorder") else {
                        return
                    }

                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    let body: [String: Any] = [
                        "coords": coords,
                        "Address": address!,
                        "meals": meals,
                        "items": items,
                        "o":[
                            "costinpenny": cost,
                            "couriertip": courierTip,
                            "restaurantid": restaurantId,
                            "userid": userId,
                            "usernote": comment

                        ]
                    ]
                    let finalBody = try! JSONSerialization.data(withJSONObject: body)
                    request.httpBody = finalBody
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    Alamofire.request(request).responseJSON { response in

                        switch (response.result) {
                        case .success:
                            print(response.description)
                            if response.description.lowercased() == "success: ok"{
                                message = "Order created you can check the status from My orders page"
                                UserDefaults.standard.set("", forKey: "Basket")
                                UserDefaults.standard.set(0, forKey: "AllCost")
                                UserDefaults.standard.set("", forKey: "CourierTip")
                                withAnimation{
                                    isLoading.toggle()
                                    showAlert.toggle()
                                    goToHome.toggle()
                                }
                            }
                            else{
                                message = "Error occured. Please try again later"
                                withAnimation{
                                    isLoading.toggle()
                                    showAlert.toggle()
                                }
                            }
                        case .failure(_):
                            message = "Error occured. Please try again later"
                            withAnimation{
                                isLoading.toggle()
                                showAlert.toggle()
                            }
                        }
                    }
                }
            }, label: {
                HStack{
                    Text("Arrange delivery")
                        .font(.custom("SFProRounded-Light", size: 18) )
                        .foregroundColor(Color("Color-white"))
                        .lineLimit(1)
                        //.position(x: 110, y: 40)
                        //.padding(.bottom,10)
                    Spacer()
                    Text(".")
                        .foregroundColor(Color("Color-yellow"))
                        .font(.system(size: 50, weight: .heavy, design: .default))
                        .lineLimit(1)
                        //.position(x: 110, y: 40)
                        .padding(.bottom,30)
                    Text(String(Double(allCost)/100) + " ₼")
                        .font(.custom("SFProRounded-Light", size: 18))
                        .foregroundColor(Color("Color-white"))
                        .lineLimit(1)
                        //.position(x: 110, y: 40)
                }
                .padding()
                .background(Color("Color-red"))
                .frame(width: UIScreen.screenWidth - 60, height: 40, alignment: .trailing)
                .cornerRadius(30)
                .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
            })
            .fullScreenCover(isPresented: $goToHome, content: {
                TabBar()
                    .edgesIgnoringSafeArea(.all)
            })
            Spacer()
                .frame(height:20)
        }
        }
        .background(Color("Color-white"))
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
        }
    }
}

struct OrderConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmationView()
            .preferredColorScheme(.dark)
    }
}
