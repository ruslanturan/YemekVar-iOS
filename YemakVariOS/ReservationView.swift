//
//  ReservationView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 16.05.22.
//

import SwiftUI

struct ReservationView: View {
    @Environment(\.dismiss) var dismiss
    @State var isLoading = false
    @State var showAlert = false
    @State var closeApp = false
    @State var message = ""
    @State var latitude = ""
    @State var longitude = ""
    @State var date = ""
    @State var name = ""
    @State var address = ""
    @State var statusID = 0
    @State var meals: [NSDictionary] = []
    var id: Int
    public init(){
        self.id = UserDefaults.standard.integer(forKey: "ReservID")
    }
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
                ScrollView{
                    VStack{
                        VStack{
                            Spacer()
                                .frame(height:30)
                            HStack{
//                                Spacer()
//                                    .frame(width:20)
//                                Button {
//
//                                } label: {
//                                    Image("Icon-share")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 20, height: 20)
//                                        .padding(10)
//                                        .background(Color("Color-white"))
//                                        .cornerRadius(30)
//                                        .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
//                                }
                                Spacer()
                                Button {
                                    UserDefaults.standard.set(0, forKey: "ReservID")

                                    dismiss()

                                } label: {
                                    Image("Icon-close")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:20, height:20)
                                        .padding(10)
                                        .background(Color("Color-white"))
                                        .cornerRadius(20)
                                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                }
                                Spacer()
                                    .frame(width:20)
                            }
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
                                VStack{
                                    HStack{
                                        HStack{
                                            Spacer()
                                            Image("Icon-user-red")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:16, height:16)
                                            Text("2")
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
                                            Text("Now")
                                                .font(.custom("SFProRounded-Light", size: 18))
                                                .foregroundColor(Color("Color-red"))
                                                .lineLimit(1)
                                                //.position(x: 110, y: 40)
                                            Spacer()
                                        }
                                        .background(Color("Color-yellow"))
                                        .frame(width: 140, height: 40, alignment: .trailing)
                                        .cornerRadius(30)
                //                        .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                        Spacer()
                                    }
                                }
                                VStack{
                                    HStack{
                                        Spacer()
                                        Text("Status:")
                                           // .frame(height:26)
                                            .font(.custom("SFProRounded-Light", size: 21) )
                                    }
                                    HStack{
                                        Spacer()
                                        if statusID == 0{
                                            Text("Waiting")
                                                .font(.custom("SFProRounded-Regular", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color.green)
                                        }
                                        else if statusID == 1{
                                            Text("Confirmed")
                                                .font(.custom("SFProRounded-Regular", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color.green)
                                        }
                                        else if statusID == 2{
                                            Text("Rejected")
                                                .font(.custom("SFProRounded-Regular", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color.green)
                                        }
                                        else if statusID == 3{
                                            Text("Finished")
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
//                            HStack{
//                                Spacer()
//                                    .frame(width:20)
//                                Text("Cancel booking")
//                                   // .frame(height:26)
//                                    .font(.custom("SFProRounded-Light", size: 21) )
//
//                                    .lineLimit(1)
//                                    .foregroundColor(Color("Color-red"))
//                                    .frame(width:UIScreen.screenWidth - 40, height: 40)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 30)
//                                            .stroke(Color("Color-red"), lineWidth: 3)
//                                    )
//                                Spacer()
//                                    .frame(width:20)
//
//                            }
//                            Spacer()
//                                .frame(height:10)
        //                    HStack{
        //                        Spacer()
        //                            .frame(width:20)
        //                        Text("Booking is held with")
        //                            .font(.custom("SFProRounded-Regular", size: 23) )
        //                            .lineLimit(1)
        //                            .foregroundColor(Color("Color-red"))
        //                        Spacer()
        //                    }
                        }
                        VStack{
        //                    HStack{
        //                        Spacer()
        //                            .frame(width:30)
        //                        Image("Icon-card-red")
        //                            .resizable()
        //                            .scaledToFit()
        //                            .frame(width: 20, height: 20)
        //                            .padding(10)
        //                        Text("Credit card")
        //                           // .frame(height:26)
        //                            .font(.custom("SFProRounded-Light", size: 21))
        //                        Spacer()
        //                        Text("*1234")
        //                           // .frame(height:26)
        //                            .font(.custom("SFProRounded-Regular", size: 21))
        //                            .foregroundColor(Color("Color-red"))
        //                        Image("Icon-done")
        //                            .resizable()
        //                            .scaledToFit()
        //                            .frame(width: 20, height: 20)
        //                            .padding(10)
        //                        Spacer()
        //                            .frame(width:30)
        //                    }
        //                    Text(" ")
        //                        .frame(
        //                          minWidth: 0,
        //                          maxWidth: UIScreen.screenWidth - 40,
        //                          minHeight: 0,
        //                          maxHeight: 1,
        //                          alignment: .leading
        //                        )
        //                        .background(Color.gray)
        //                    HStack{
        //                        Spacer()
        //                            .frame(width:30)
        //                        Image("Icon-card")
        //                            .resizable()
        //                            .scaledToFit()
        //                            .frame(width: 20, height: 20)
        //                            .padding(10)
        //                        Text("Credit card")
        //                           // .frame(height:26)
        //                            .font(.custom("SFProRounded-Light", size: 21))
        //                        Spacer()
        //                        Text("*1234")
        //                           // .frame(height:26)
        //                            .font(.custom("SFProRounded-Regular", size: 21))
        //                            .foregroundColor(Color("Color-red"))
        //                        Spacer()
        //                            .frame(width:80)
        //                    }
        //                    HStack{
        //                        Spacer()
        //                        Text("See payment methods")
        //                            .font(.custom("SFProRounded-Light", size: 15) )
        //                            .lineLimit(1)
        //                            .foregroundColor(Color("Color-red"))
        //                            .padding(.bottom)
        //                        Spacer()
        //                    }
        //                    HStack{
        //                        Spacer()
        //                            .frame(width:20)
        //                        Text("People invited")
        //                            .font(.custom("SFProRounded-Regular", size: 23) )
        //                            .lineLimit(1)
        //                            .foregroundColor(Color("Color-red"))
        //                        Spacer()
        //                    }
        //                    HStack{
        //                        Spacer()
        //                            .frame(width:20)
        //                        VStack{
        //                            Image("Icon-user")
        //                                .resizable()
        //                                .scaledToFit()
        //                                .frame(width: 50, height: 50, alignment: .center)
        //                                .background(Color("Color-white"))
        //                                .cornerRadius(25)
        //                                .overlay(
        //                                    Circle().stroke(Color("Color-yellow"), lineWidth: 2.5))
        //                                .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 10)
        //                            Text("John W.")
        //                               // .frame(height:26)
        //                                .font(.custom("SFProRounded-Light", size: 15))
        //                        }
        //                        VStack{
        //                            Image("Icon-user")
        //                                .resizable()
        //                                .scaledToFit()
        //                                .frame(width: 50, height: 50, alignment: .center)
        //                                .background(Color("Color-white"))
        //                                .cornerRadius(25)
        //                                .overlay(
        //                                    Circle().stroke(Color("Color-yellow"), lineWidth: 2.5))
        //                                .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 10)
        //                            Text("John W.")
        //                               // .frame(height:26)
        //                                .font(.custom("SFProRounded-Light", size: 15))
        //                        }
        //                        VStack{
        //                            Image("Icon-user")
        //                                .resizable()
        //                                .scaledToFit()
        //                                .frame(width: 50, height: 50, alignment: .center)
        //                                .background(Color("Color-white"))
        //                                .cornerRadius(25)
        //                                .overlay(
        //                                    Circle().stroke(Color("Color-yellow"), lineWidth: 2.5))
        //                                .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 10)
        //                            Text("John W.")
        //                               // .frame(height:26)
        //                                .font(.custom("SFProRounded-Light", size: 15))
        //                        }
        //                        Spacer()
        //                    }
        //                    Text("Send invitation")
        //                       // .frame(height:26)
        //                        .font(.custom("SFProRounded-Light", size: 21) )
        //
        //                        .lineLimit(1)
        //                        .frame(width:UIScreen.screenWidth - 40, height: 40)
        //                        .background(Color("Color-red"))
        //                        .foregroundColor(Color("Color-white"))
        //                        .cornerRadius(30)
                            HStack{
                                Spacer()
                                    .frame(width:20)
                                Text("Location")
                                    .font(.custom("SFProRounded-Regular", size: 23))
                                    .lineLimit(1)
                                    .foregroundColor(Color("Color-red"))
                                Spacer()
                                Text(address)
                                   // .frame(height:26)
                                    .font(.custom("SFProRounded-Light", size: 15) )
                                    .lineLimit(1)
                                Spacer()
                                    .frame(width:20)

                            }
//                            ZStack{
//                                LocationView()
//                                    .frame(width:UIScreen.screenWidth - 40, height: 150)
//                                    .cornerRadius(20)
//                                    .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
//                                Image("Icon-full-screen")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20, height: 20)
//                                    .padding(10)
//                                    .background(Color("Color-white"))
//                                    .cornerRadius(30)
//                                    .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
//                                    .position(x: UIScreen.screenWidth - 60, y: 130)
//                            }
//                                .frame(width:UIScreen.screenWidth - 40, height: 150)
                        }
                        VStack{
        //                    HStack{
        //                        Spacer()
        //                            .frame(width:20)
        //                        Button(action: {}, label: {
        //                            HStack{
        //                                Text("Share")
        //                                   // .frame(height:26)
        //                                    .font(.custom("SFProRounded-Light", size: 18) )
        //                                    .lineLimit(1)
        //                                    .foregroundColor(Color("Color-red"))
        //                                Image("Icon-share")
        //                                    .resizable()
        //                                    .scaledToFit()
        //                                    .frame(width: 20, height: 20)
        //                            }
        //                        })
        //                            .frame(width:UIScreen.screenWidth/3, height: 40)
        //                            .overlay(
        //                                RoundedRectangle(cornerRadius: 30)
        //                                    .stroke(Color("Color-red"), lineWidth: 3)
        //                            )
        //                        Spacer()
        //                        Button(action: {}, label: {
        //                            HStack{
        //                                Text("Get directions")
        //                                   // .frame(height:26)
        //                                    .font(.custom("SFProRounded-Light", size: 18) )
        //                                    .lineLimit(1)
        //                                    .foregroundColor(Color("Color-white"))
        //                                Image("Icon-arrow")
        //                                    .resizable()
        //                                    .scaledToFit()
        //                                    .frame(width: 20, height: 20)
        //                            }
        //                        })
        //                            .frame(width:UIScreen.screenWidth/2, height: 40)
        //                            .background(Color("Color-red"))
        //                            .cornerRadius(30)
        //                        Spacer()
        //                            .frame(width:20)
        //
        //                    }
        //                    .padding(.top)
                        
                        }
//                        HStack{
//                           Spacer()
//                               .frame(width:20)
//                           Text("Menu")
//                               .font(.custom("SFProRounded-Regular", size: 23) )
//                               .foregroundColor(Color("Color-red"))
//                               .lineLimit(1)
//                               .padding(.vertical)
//                           Spacer()
//                       }
//                       ScrollView(.horizontal) {
//                           Spacer()
//                               .frame(height:20)
//                           HStack(spacing: 20) {
//                               Spacer()
//                                   .frame(width:0)
//                               ForEach(meals, id:\.self) {meal in
//                                   ZStack{
//                                       ZStack{
//                                           AsyncImage(url: URL(string: "https://yemekvar.az/images/Meal-Images/" + (meal["PhotoURL"] as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
//                                               image
//                                                   .resizable()
//                                                   .aspectRatio(contentMode: .fill)
////                                                   .clipped()
//                                           } placeholder: {
//                                               Image("Image-2")
//                                                   .resizable()
//                                                   .aspectRatio(contentMode: .fill)
//                                                   .clipped()
//                                           }
//
//                                       Text(String(Double(meal["CostInPenny"] as! Int)/100) + " ₼")
//            //                                    .frame(width: 50, height: 10, alignment: .leading)
//                                           .padding(10)
//                                           .foregroundColor(Color("Color-red"))
//                                           .font(.custom("SFProRounded-Regular", size: 14) )
//                                           .lineLimit(1)
//                                           .background(Color("Color-white"))
//                                           .cornerRadius(20)
//                                           .position(x: 40, y: 55)
//            //                                    .padding(.bottom,160)
//            //                                    .padding(.trailing,UIScreen.screenWidth/2)
//                                       VStack{
//                                           Spacer()
//                                               .frame(height:10)
//                                           HStack{
//                                               Spacer()
//                                                   .frame(width:20)
//                                               Text(meal["Name"] as! String)
//                                                   .font(.custom("SFProRounded-Light", size: 15) )
//                                                   .lineLimit(1)
//                                                   .padding(.trailing)
//                                               Spacer()
//                                               Image("Icon-fire")
//                                                   .resizable()
//                                                   .scaledToFit()
//                                                   .frame(width: 15, height: 20)
//                                               Spacer()
//                                                   .frame(width:20)
//                                           }
//
//                                       }
//                                       .frame(width: 180, height: 40, alignment: .top)
//                                       .background(Color("Color-white"))
//                                       .cornerRadius(20)
//                                       .position(x: 90, y: 130)
//                                   }
//                                   .frame(width: 180, height: 120)
//                                   .background(Color("Color-white"))
//                                       .cornerRadius(20)
//                                       .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
//                               }
//                               }
//                               Spacer()
//                                   .frame(width:50)
//                           }
//                           .frame(height: 150)
//
//                       }
//                       HStack{
//                           Spacer()
//                               .frame(width:20)
//                           Text("See the whole menu")
//                               .font(.custom("SFProRounded-Light", size: 21) )
//                               .lineLimit(1)
//                               .foregroundColor(Color("Color-red"))
//                           Image("Icon-right")
//                               .resizable()
//                               .scaledToFit()
//                               .frame(width: 15, height: 20, alignment: .center)
//                           Spacer()
//                       }
                        
                    }
                    Spacer()
                        .frame(height:50)
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
            .task {
                await loadData()
            }
        }
        
    }
    func loadData() async{
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/user/reservationInfo") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["reservID": String(id)]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)

                if !(str.lowercased().contains("error")){
                    let json = try ((JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? NSDictionary)!)
                    latitude = json["Latitude"] as! String
                    longitude = json["Longitude"] as! String
                    UserDefaults.standard.set(latitude, forKey: "restLat")
                    UserDefaults.standard.set(longitude, forKey: "restLon")
                    date = json["StartDate"] as! String
                    statusID = json["StatusID"] as! Int
                    name = json["Name"] as! String
                    meals = json["meals"] as! [NSDictionary]
                    address = json["Display_Address"] as? String ?? "Baki"

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

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
            .preferredColorScheme(.dark)

    }
}
