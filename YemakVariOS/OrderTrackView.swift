//
//  OrderTrackView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 02.05.22.
//

import SwiftUI

struct OrderTrackView: View {
    @State var isLoading = false
    @State var showAlert = false
    @State var closeApp = false
    @State var message = ""
    @State var statusID = 0
    @State var name = ""
    @State var count = 0
    @State var courierTip = 0
    @State var cost = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var id: Int
     public init () {
         self.id = UserDefaults.standard.integer(forKey: "OrderID")
     }
    var body: some View {
        LoadingView(isShowing: $isLoading) {

        ZStack{
            GoogleMapsView()
                .frame(width:UIScreen.screenWidth, height: UIScreen.screenHeight)
            HStack{
                Spacer()
                    .frame(width:20)
                Button(action: {
                    UserDefaults.standard.set(0, forKey: "OrderID")
                    withAnimation{
                        self.mode.wrappedValue.dismiss()
                    }
                }, label: {
                    Image("Icon-back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .background(Color("Color-white"))
                        .cornerRadius(30)
//                            .position(x: 18, y:46)
                        
//                                    .padding(.trailing,UIScreen.screenWidth/2 + 80)
        //                .padding(.trailing,(UIScreen.screenWidth/2 + 120))
                        .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)

                })
                Spacer()
            }
            .padding(.bottom, UIScreen.screenHeight - 100)
            VStack{
                Spacer()
                    .frame(height:UIScreen.screenHeight/2)
                VStack{
                    VStack{
                        Spacer()
                            .frame(height:10)
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Text(name)
                                .font(.custom("SFProRounded-Regular", size: 30) )
                                .lineLimit(1)
                                .foregroundColor(Color("Color-red"))
                            Spacer()
                            Text("#" + String(id).PadLeft(totalWidth: 6, byString: "0"))
                               // .frame(height:26)
                                .font(.custom("SFProRounded-Light", size: 20) )
                            Spacer()
                                .frame(width:20)

                        }
                        HStack{
                            Spacer()
                                .frame(width:20)
                            
                            Text(String(count) + " items")
                               // .frame(height:26)
                                .font(.custom("SFProRounded-Ultralight", size: 16) )
                            Spacer()
                        }
                        HStack{
                            Spacer()
//                                .frame(width:20)
//                            VStack{
//                                HStack{
//                                    Text("Estimated time")
//                                       // .frame(height:26)
//                                        .font(.custom("SFProRounded-Light", size: 21) )
//                                        .lineLimit(1)
//                                    Spacer()
//                                }
//                                HStack{
//                                    Text("25 min.")
//                                        .font(.custom("SFProRounded-Regular", size: 30) )
//                                        .lineLimit(1)
//                                        .foregroundColor(Color("Color-red"))
//                                    Spacer()
//                                }
//                            }
                            VStack{
                                HStack{
                                    Spacer()
                                    Text("Status:")
                                       // .frame(height:26)
                                        .font(.custom("SFProRounded-Light", size: 21) )
                                }
                                HStack{
                                    Spacer()
                                    if statusID == 1{
                                        Text("Preparing")
                                            .font(.custom("SFProRounded-Regular", size: 15) )
                                            .lineLimit(1)
                                            .foregroundColor(Color.green)
                                    }
                                    else if statusID == 2{
                                        Text("Ready")
                                            .font(.custom("SFProRounded-Regular", size: 15) )
                                            .lineLimit(1)
                                            .foregroundColor(Color.green)
                                    }
                                    else if statusID == 3{
                                        Text("On it's way")
                                            .font(.custom("SFProRounded-Regular", size: 15) )
                                            .lineLimit(1)
                                            .foregroundColor(Color.green)
                                    }
                                    
                                }
                            }
                            .frame(width:100)
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
                            Text(String(Double(cost + courierTip)/100) + " ₼")
                               // .frame(height:26)
                                .font(.custom("SFProRounded-Light", size: 18) )
                            Spacer()
                                .frame(width:20)

                        }
                       
                        HStack{
                            Spacer()
                                .frame(width:20)
//                            Text("Cancel")
//                               // .frame(height:26)
//                                .font(.custom("SFProRounded-Light", size: 18) )
//
//                                .lineLimit(1)
//                                .foregroundColor(Color("Color-red"))
//                                .frame(width:UIScreen.screenWidth/3, height: 40)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 30)
//                                        .stroke(Color("Color-red"), lineWidth: 3)
//                                )
//                            Spacer()
                            Text("Contact")
                               // .frame(height:26)
                                .font(.custom("SFProRounded-Light", size: 18) )
                                
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
                Spacer()
                    .frame(height:20)
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
        .task {
            await loadData()
        }
        }
        .edgesIgnoringSafeArea(.all)

    }
    func loadData() async{
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/user/orderTrack") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["orderid": String(id)]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)

                if !(str.lowercased().contains("error")){
                    let json = try ((JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? NSDictionary)!)
                    name = json["Name"] as! String
                    courierTip = json["CourierTip"] as! Int
                    cost = json["CostInPenny"] as! Int
                    statusID = json["StatusID"] as! Int
                    count = json["Count"] as! Int
                    //id = json["ID"] as! Int
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

struct OrderTrackView_Previews: PreviewProvider {
    static var previews: some View {
        OrderTrackView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 13 Pro Max")
            
    }
}
