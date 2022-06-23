//
//  OrdersView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 28.04.22.
//

import SwiftUI
public class Order: Identifiable{
    var name: String = ""
    var countt: Int = 0
    public var id: Int = 0
    var statusID: Int = 0
    var fullCost: Double = 0
    var meals: [Meal] = []
    public init(name: String, countt: Int, id: Int, statusID: Int, fullCost: Double){
        self.name = name
        self.countt = countt
        self.id = id
        self.statusID = statusID
        self.fullCost = fullCost
    }
}
public class Meal: Identifiable{
    var name: String = ""
    var countt: Int = 0
    var totalSum: Double = 0
    public init(name: String, countt: Int, totalSum: Double){
        self.name = name
        self.countt = countt
        self.totalSum = totalSum
    }
}
struct OrdersView: View {
    @State var goToOrder = false
    @State var upcomingIsEmpty = false
    @State var historyIsEmpty = false
    @State var showAlert = false
    @State var isLoading = false
    @State var selected = 0
    @State var closeApp = false
    @State var message = ""
    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""
    @State var upcoming: [Order] = []
    @State var history: [Order] = []
//    @State var oMeals: [String: Any] = []
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

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
                        Text("My orders")
                           // .frame(height:26)
                            .font(.custom("SFProRounded-Light", size: 23) )
                        Spacer()
                    }
                    TopBar(selected: self.$selected)
                    ScrollView{
                        VStack{

                            ScrollView{
                                if self.selected == 0 {
                                    if upcomingIsEmpty{
                                        VStack{
                                            Spacer()
                                            Image("Icon-basket-gray")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:130,height: 130)
                                            Text("No orders yet")
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
                                        ForEach(upcoming){ order in
                                            
                                            VStack{
                                                VStack{
                                                    Spacer()
                                                        .frame(height:10)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)
                                                        
                                                        Text(order.name)
                                                            .font(.custom("SFProRounded-Regular", size: 30) )
                                                            .lineLimit(1)
                                                            .foregroundColor(Color("Color-red"))
                                                        Spacer()
                                                        Text("#" + String(order.id).PadLeft(totalWidth: 6, byString: "0"))
                                                           // .frame(height:26)
                                                            .font(.custom("SFProRounded-Light", size: 20) )
                                                        Spacer()
                                                            .frame(width:20)

                                                    }
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)
                                                        Text(String(order.countt) + " items")
                                                           // .frame(height:26)
                                                            .font(.custom("SFProRounded-Ultralight", size: 16) )
                                                        Spacer()
                                                    }
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)
    //                                                    VStack{
    //                                                        HStack{
    //                                                            Text("Estimated time")
    //                                                               // .frame(height:26)
    //                                                                .font(.custom("SFProRounded-Light", size: 21) )
    //                                                                .lineLimit(1)
    //                                                            Spacer()
    //                                                        }
    //                                                        HStack{
    //                                                            Text("25 min.")
    //                                                                .font(.custom("SFProRounded-Regular", size: 30) )
    //                                                                .lineLimit(1)
    //                                                                .foregroundColor(Color("Color-red"))
    //                                                            Spacer()
    //                                                        }
    //                                                    }
                                                        VStack{
                                                            Spacer()
                                                            HStack{
                                                                Spacer()
                                                                Text("Status:")
                                                                   // .frame(height:26)
                                                                    .font(.custom("SFProRounded-Light", size: 21) )
                                                            }
                                                            HStack{
                                                                Spacer()
                                                                if order.statusID == 0{
                                                                    Text("Waiting")
                                                                        .font(.custom("SFProRounded-Regular", size: 15) )
                                                                        .lineLimit(1)
                                                                        .foregroundColor(Color.green)
                                                                }
                                                                else if order.statusID == 1{
                                                                    Text("Preparing")
                                                                        .font(.custom("SFProRounded-Regular", size: 15) )
                                                                        .lineLimit(1)
                                                                        .foregroundColor(Color.green)
                                                                }
                                                                else if order.statusID == 2{
                                                                    Text("Ready")
                                                                        .font(.custom("SFProRounded-Regular", size: 15) )
                                                                        .lineLimit(1)
                                                                        .foregroundColor(Color.green)
                                                                }
                                                                else if order.statusID == 3{
                                                                    Text("On it's way")
                                                                        .font(.custom("SFProRounded-Regular", size: 15) )
                                                                        .lineLimit(1)
                                                                        .foregroundColor(Color.green)
                                                                }
                                                            }
                                                        }
                                                        Spacer()
                                                            .frame(width:20)
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
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)
                                                        Text("Full cost")
                                                           // .frame(height:26)
                                                            .font(.custom("SFProRounded-Light", size: 18) )
                                                        Spacer()

                                                        Text(String(order.fullCost) + " ₼")
                                                           // .frame(height:26)
                                                            .font(.custom("SFProRounded-Light", size: 18) )
                                                        Spacer()
                                                            .frame(width:20)

                                                    }
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)

                                                        if order.statusID == 0{
                                                        Text("Cancel")
                                                           // .frame(height:26)
                                                            .font(.custom("SFProRounded-Light", size: 21) )
                                                            
                                                            .lineLimit(1)
                                                            .foregroundColor(Color("Color-red"))
                                                            .frame(width:UIScreen.screenWidth - 40,height: 40)
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 30)
                                                                    .stroke(Color("Color-red"), lineWidth: 3)
                                                            )
                                                        }
                                                        else{
                                                            Button(action: {
                                                                UserDefaults.standard.set(order.id, forKey: "OrderID")
                                                                withAnimation{
                                                                    goToOrder.toggle()
                                                                }
                                                            }, label: {
                                                                Text("Track order")
                                                                   // .frame(height:26)
                                                                    .font(.custom("SFProRounded-Light", size: 21) )
                                                                    
                                                                    .lineLimit(1)
                                                                    .frame(width:UIScreen.screenWidth - 40,height: 40)
                                                                    .background(Color("Color-red"))
                                                                    .foregroundColor(Color("Color-white"))
                                                                    .cornerRadius(30)
                                                            })
                                                            .fullScreenCover(isPresented: $goToOrder, content: {
                                                                OrderTrackView()

                                                            })
                                                            
                                                        }
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
                                else{
                                    if historyIsEmpty{
                                        VStack{
                                            Spacer()
                                            Image("Icon-basket-gray")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:130,height: 130)
                                            Text("No orders yet")
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
                                        ForEach(history, id:\.id){ orderH in
                                            VStack{
                                                VStack{
                                                    Spacer()
                                                        .frame(height:10)
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)
                                                        Text(orderH.name)
                                                            .font(.custom("SFProRounded-Regular", size: 30) )
                                                            .lineLimit(1)
                                                            .foregroundColor(Color("Color-red"))
                                                        Spacer()
                                                        VStack{
                                                            Text("288 Aug")
                                                               // .frame(height:26)
                                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                                .foregroundColor(Color.gray)
                                                            Text("Delivered")
                                                               // .frame(height:26)
                                                                .font(.custom("SFProRounded-Light", size: 20) )
                                                                .foregroundColor(Color.green)
                                                        }
                                                        
                                                        Spacer()
                                                            .frame(width:20)

                                                    }
                                                    Spacer()
                                                        .frame(height:10)
                                                    VStack{
                                                        ForEach(orderH.meals){ meal in
                                                                HStack{
                                                                    Spacer()
                                                                        .frame(width:20)
                                                                    Text(String(meal.countt) + " x " + meal.name)
                                                                       // .frame(height:26)
                                                                        .font(.custom("SFProRounded-Light", size: 15) )
                                                                    Spacer()
                                                                    Text(String(meal.totalSum) + " ₼")
                                                                       // .frame(height:26)
                                                                        .font(.custom("SFProRounded-Light", size: 15) )
                                                                    Spacer()
                                                                        .frame(width:20)

                                                                }

                                                        }
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
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)
                                                        Text("Full cost")
                                                           // .frame(height:26)
                                                            .font(.custom("SFProRounded-Light", size: 18) )
                                                        Spacer()
                                                        Text(String(orderH.fullCost) + " ₼")
                                                           // .frame(height:26)
                                                            .font(.custom("SFProRounded-Light", size: 18) )
                                                        Spacer()
                                                            .frame(width:20)

                                                    }
                                                    HStack{
                                                        Spacer()
                                                            .frame(width:20)

                                                        Text("Re-Order")
                                                           // .frame(height:26)
                                                            .font(.custom("SFProRounded-Light", size: 21) )
                                                            
                                                            .lineLimit(1)
                                                            .frame(width:UIScreen.screenWidth - 40, height: 40)
                                                            .background(Color("Color-red"))
                                                            .foregroundColor(Color("Color-white"))
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

                        }
                        .background(Color("Color-white"))
                        }
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)

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
            .foregroundColor(Color("Color-black"))
            .background(Color("Color-white"))
        }
        .task({
            await loadData()
        })
    }
    func loadData() async{
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/user/orders") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["userID": loggedID]
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
                        for order in json! {
//                            let orderMeals = (order["meals"] as! NSArray)
                            if order["StatusID"] as! Int == 4{
                                let o = Order(name: order["Name"] as! String, countt: (order["meals"] as! NSArray).count, id: order["ID"] as! Int, statusID: order["StatusID"] as! Int, fullCost: (Double(order["CourierTip"] as! Int) + Double(order["CostInPenny"] as! Int))/100)
                                let oMeals = (order["meals"] as? [NSDictionary])!
                                
                                for meal in oMeals{
                                    o.meals.append(Meal(name: meal["Name"] as! String, countt: meal["Count"] as! Int, totalSum: Double((meal["TotalSum"] as! Int))/100))
                                }
                                history.append(o)

                            }
                            else{
                                upcoming.append(Order(name: order["Name"] as! String, countt: (order["meals"] as! NSArray).count, id: order["ID"] as! Int, statusID: order["StatusID"] as! Int, fullCost: (Double(order["CourierTip"] as! Int) + Double(order["CostInPenny"] as! Int))/100))
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

struct TopBar: View {
    @Binding var selected : Int
    var body: some View{
        HStack{
            Spacer()
                .frame(width: 20)
            HStack{
                
                Button(action: {
                    self.selected = 0

                }, label: {
                    Text("Upcoming")
                        .frame(width:(UIScreen.screenWidth - 50)/2,height:50)
                        .font(.custom("SFProRounded-Light", size: 21))
                        .foregroundColor(self.selected == 0 ? Color("Color-white") : Color("Color-red"))
                        .background(self.selected == 0 ?  Color("Color-red") : Color("Color-white"))
                        .cornerRadius(30)
                })
                Button(action: {
                    self.selected = 1
                }, label: {
                    Text("History")
                        .frame(width:(UIScreen.screenWidth - 50)/2,height:50)
                        .font(.custom("SFProRounded-Light", size: 21))
                        .foregroundColor(self.selected == 1 ? Color("Color-white") : Color("Color-red"))
                        .background(self.selected == 1 ?  Color("Color-red") : Color("Color-white"))
                        .cornerRadius(30)
                })
                }
                .padding(8)
        //        .cornerRadius(30)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.gray, lineWidth: 1)
                )
            Spacer()
                .frame(width: 20)
        }
        .background(Color("Color-white"))
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
            .previewDevice("iPhone 13 Pro Max")
//            .previewDevice("iPhone 13 Pro Max")
    }
}
extension String {
    func PadLeft( totalWidth: Int,byString:String) -> String {
    let toPad = totalWidth - self.count
    if toPad < 1 {
        return self
    }
    
    return "".padding(toLength: toPad, withPad: byString, startingAt: 0) + self
}
}
