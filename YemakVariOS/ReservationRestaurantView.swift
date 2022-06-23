//
//  ReservationRestaurantView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 13.05.22.
//

import SwiftUI

struct ReservationRestaurantView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
//    @State var goToMeal = false
    @State var isLoading = false
    @State var showAlert = false
    @State var showFullScreen = false
    @State var closeApp = false
    @State var message = ""
    @State var day1 = ""
    @State var day2 = ""
    @State var day3 = ""
    @State var day4 = ""
    @State var day5 = ""
    @State var day6 = ""
    @State var day7 = ""
    @State var latitude = ""
    @State var longitude = ""
    @State var type1 = "0"
    @State var type2 = "0"
    @State var type3 = "0"
    @State var type4 = "0"
    @State var type5 = "0"
    @State var gallery = ""
    @State var address = ""
    @State var name = ""
    @State var uniqueNum = ""
    @State var isFavourite = false
    @State var photoUrl = ""
    @State var number = 0
    @State var menu: [NSDictionary] = []
    @State var tags: [String] = []
    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""

    var id: Int
     public init (id: Int) {
         self.id = id
     }
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
                ScrollView{
                    VStack{
                        if !showFullScreen{
//                        Spacer()
//                            .frame(height:30)
                        ZStack{
                            AsyncImage(url: URL(string: "https://yemekvar.az/images/Restaurant-Images/" + uniqueNum.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "/" + gallery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.screenWidth - 40, height:200)


                            } placeholder: {
                                VStack{
                                    
                                }

                            }
                                .cornerRadius(20)
                                .padding(.top, 25)
                                .frame(width: UIScreen.screenWidth - 40, height:200)

                            HStack{
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
                                        .background(Color("Color-white"))
                                        .cornerRadius(30)
            //                            .position(x: 18, y:46)
                                        
    //                                    .padding(.trailing,UIScreen.screenWidth/2 + 80)
                        //                .padding(.trailing,(UIScreen.screenWidth/2 + 120))
                                        .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)

                                })
                                Spacer()
    //                            Image("Icon-share")
    //                                .resizable()
    //                                .scaledToFit()
    //                                .frame(width: 20, height: 20)
    //                                .padding(10)
    //                                .background(Color("Color-white"))
    //                                .cornerRadius(30)
    //    //                            .position(x: UIScreen.screenWidth - 60, y: 46)
    ////                                .padding(.leading,UIScreen.screenWidth/2 + 80)
    //                                .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                            }
                            .padding(.bottom,140)
                            .frame(width: UIScreen.screenWidth - 40)
                            
                            if loggedID != ""{
                                if isFavourite{
                                    HStack{
                                        Button(action: {
                                            withAnimation{
                                                isLoading.toggle()
                                            }
                                            guard let url = URL(string: "https://yemekvar.az/api/user/removefromfavourites") else {
                                                return
                                            }
                                            var request = URLRequest(url: url)
                                            request.httpMethod = "POST"
                                            let body: [String: String] = ["userId": loggedID, "restId": String(id)]
                                            let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                            request.httpBody = finalBody
                                            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                            URLSession.shared.dataTask(with: request) { (data, response, error) in
                                                guard let data = data else { return }
                                                let str = String(decoding: data, as: UTF8.self)
                                                    if !(str.lowercased().contains("error")){
                                                        message = "Successfully removed from favourites"
                                                        guard let url = URL(string: "https://yemekvar.az/api/reservation/restaurant") else {
                                                            return
                                                        }
                                                        var request = URLRequest(url: url)
                                                        request.httpMethod = "POST"
                                                        let body: [String: String] = ["userId": loggedID, "restId": String(id)]
                                                        let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                                        request.httpBody = finalBody
                                                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                                        URLSession.shared.dataTask(with: request) { (data, response, error) in
                                                            guard let data = data else { return }
                                                            do{
                                                            let str = String(decoding: data, as: UTF8.self)
                                                                if !(str.lowercased().contains("error")){
                                                                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                                                                    day1 = json!["day1"] as! String
                                                                    day2 = json!["day2"] as! String
                                                                    day3 = json!["day3"] as! String
                                                                    day4 = json!["day4"] as! String
                                                                    day5 = json!["day5"] as! String
                                                                    day6 = json!["day6"] as! String
                                                                    day7 = json!["day7"] as! String
                                                                    latitude = json!["Latitude"] as! String
                                                                    longitude = json!["Longitude"] as! String
                                                                    UserDefaults.standard.set(latitude, forKey: "restLat")
                                                                    UserDefaults.standard.set(longitude, forKey: "restLon")

                                                                    isFavourite = json!["isFavourite"] as! Bool
                                                                    type1 = json!["type1"] as! String
                                                                    type2 = json!["type2"] as! String
                                                                    type3 = json!["type3"] as! String
                                                                    type4 = json!["type4"] as! String
                                                                    type5 = json!["type5"] as! String
                                                                    address = json!["Display_Address"] as! String
                                                                    number = json!["Number"] as! Int
                                                                    tags = json!["Tags"] as! [String]
                                                                    let gal = json!["gallery"] as! [NSDictionary]
                                                                    gallery = gal[0]["PhotoURL"] as! String
                                                                    photoUrl = json!["PhotoURL"] as! String
                                                                    name = json!["Name"] as! String
                                                                    uniqueNum = json!["Unique_Num"] as! String
                                                                    menu = json!["menu"] as! [NSDictionary]
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

                                        }, label: {
                                            Image("Icon-heart-red")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                                .padding(10)
                                                .background(Color("Color-yellow"))
                                                .cornerRadius(30)
                    //                            .position(x: UIScreen.screenWidth - 60, y: 215)
                                                
                                                .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
        //                                        .contentShape(Rectangle())

                                        })
                                    }
                                    .padding(.top,190)
                                    .padding(.leading,UIScreen.screenWidth/2 + 80)
                                }
                                else{
                                    HStack{
                                        Button(action: {
                                            withAnimation{
                                                isLoading.toggle()
                                            }
                                            guard let url = URL(string: "https://yemekvar.az/api/user/addtofavourites") else {
                                                return
                                            }
                                            var request = URLRequest(url: url)
                                            request.httpMethod = "POST"
                                            let body: [String: String] = ["userId": loggedID, "restId": String(id)]
                                            let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                            request.httpBody = finalBody
                                            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                            URLSession.shared.dataTask(with: request) { (data, response, error) in
                                                guard let data = data else { return }
                                                let str = String(decoding: data, as: UTF8.self)
                                                    if !(str.lowercased().contains("error")){
                                                        message = "Successfully added to favourites"
                                                        guard let url = URL(string: "https://yemekvar.az/api/reservation/restaurant") else {
                                                            return
                                                        }
                                                        var request = URLRequest(url: url)
                                                        request.httpMethod = "POST"
                                                        let body: [String: String] = ["userId": loggedID, "restId": String(id)]
                                                        let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                                        request.httpBody = finalBody
                                                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                                        URLSession.shared.dataTask(with: request) { (data, response, error) in
                                                            guard let data = data else { return }
                                                            do{
                                                            let str = String(decoding: data, as: UTF8.self)
                                                                if !(str.lowercased().contains("error")){
                                                                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                                                                    day1 = json!["day1"] as! String
                                                                    day2 = json!["day2"] as! String
                                                                    day3 = json!["day3"] as! String
                                                                    day4 = json!["day4"] as! String
                                                                    day5 = json!["day5"] as! String
                                                                    day6 = json!["day6"] as! String
                                                                    day7 = json!["day7"] as! String
                                                                    latitude = json!["Latitude"] as! String
                                                                    longitude = json!["Longitude"] as! String
                                                                    UserDefaults.standard.set(latitude, forKey: "restLat")
                                                                    UserDefaults.standard.set(longitude, forKey: "restLon")

                                                                    isFavourite = json!["isFavourite"] as! Bool
                                                                    type1 = json!["type1"] as! String
                                                                    type2 = json!["type2"] as! String
                                                                    type3 = json!["type3"] as! String
                                                                    type4 = json!["type4"] as! String
                                                                    type5 = json!["type5"] as! String
                                                                    address = json!["Display_Address"] as! String
                                                                    number = json!["Number"] as! Int
                                                                    tags = json!["Tags"] as! [String]
                                                                    let gal = json!["gallery"] as! [NSDictionary]
                                                                    gallery = gal[0]["PhotoURL"] as! String
                                                                    photoUrl = json!["PhotoURL"] as! String
                                                                    name = json!["Name"] as! String
                                                                    uniqueNum = json!["Unique_Num"] as! String
                                                                    menu = json!["menu"] as! [NSDictionary]
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

                                        }, label: {
                                            Image("Icon-heart")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                                .padding(10)
                                                .background(Color("Color-red"))
                                                .cornerRadius(30)
                                                //.position(x: 120, y: 40)
                                        })
                                        

                                    }
                                    .padding(.top,190)
                                    .padding(.leading,UIScreen.screenWidth/2 + 80)
                                }
                            }
                            AsyncImage(url: URL(string: "https://yemekvar.az/images/Restaurant-Images/" + uniqueNum.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "/" + photoUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
//                                    .clipped()
                            } placeholder: {
                                VStack{}
                            }
                                .frame(width: 150, height: 150)
                                .background(Color("Color-white"))
                                .cornerRadius(90)
    //                            .position(x: (UIScreen.screenWidth - 40)/2, y: 180)
                                .padding(.top,120)
                //                .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                            }
                            .frame(width: UIScreen.screenWidth, height: 200)
                            .padding(.bottom,50)

                            //.shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
                        ZStack{
                            Text(" ")
                                .frame(
                                  minWidth: 0,
                                  maxWidth: UIScreen.screenWidth - 20,
                                  minHeight: 0,
                                  maxHeight: 1,
                                  alignment: .leading
                                )
                                .background(Color("Color-red"))
            //                    .position(x: (UIScreen.screenWidth - 40)/2, y: 280)
                            Text(name)
                                .font(.custom("SFProRounded-Regular", size: 36) )
                                .foregroundColor(Color("Color-red"))
                                .background(Color("Color-white"))
            //                    .position(x: (UIScreen.screenWidth - 40)/2, y: 280)
                        }
                        VStack{
                            HStack{
                                Image("Icon-location")
                                    .frame(width: 20, height: 30, alignment: .center)
                //                    .padding(.leading)
                                Text(address)
                                    .lineLimit(1)
                                    .font(.custom("SFProRounded-Light", size: 15) )
                            }
                            HStack{
                                Spacer()
                                    .frame(width:20)
                                HStack{
                                    Spacer()
                                    Image("Icon-user-red")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:16, height:16)
                                    Text(UserDefaults.standard.string(forKey: "GuestCount")!)
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
                            if loggedID != ""{
                            HStack{
                                Button(action: {
                                    withAnimation{
                                        isLoading.toggle()
                                    }
                                    guard let url = URL(string: "https://yemekvar.az/api/reservation/createreservation") else {
                                        return
                                    }
                                    var request = URLRequest(url: url)
                                    request.httpMethod = "POST"
                                    let bookingHour = UserDefaults.standard.string(forKey: "PickedHour")!
                                    let bookingDay = UserDefaults.standard.string(forKey: "PickedDay")!
                                    var bookingDate = Date.now
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "dd-MM-yy HH:mm"

                                    if bookingDay != "Now"{
//                                        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                                        bookingDate = dateFormatter.date(from: bookingDay + " " + bookingHour)!
                                    }
                                    let body: [String: String] = ["userId": loggedID, "guestcount": UserDefaults.standard.string(forKey: "GuestCount")!, "restID": String(id), "startDate": dateFormatter.string(from: bookingDate)]
                                    let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                    request.httpBody = finalBody
                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                                        guard let data = data else { return }
                                        let str = String(decoding: data, as: UTF8.self)
                                            if !(str.lowercased().contains("error")){
                                                message = "Booking requested. You can check the status from My bookings page"

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

                                    }.resume()
                                }, label: {
                                    Spacer()
                                    Text("Book a table here")
                                        .font(.custom("SFProRounded-Light", size: 18) )
                                        .foregroundColor(Color("Color-white"))
                                        .lineLimit(1)
                                    Spacer()
                                })
                                .padding()
                                .background(Color("Color-red"))
                                .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .trailing)
                                .cornerRadius(30)
                                .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
        
                            }
                            }
                        }
        
//                        ScrollView(.horizontal) {
//                            HStack(spacing: 20) {
//                                Spacer()
//                                    .frame(width:0)
//                                ForEach(0..<10) {number in
//                                    Group{
//                                        if number == 0 {
//                                            VStack(spacing: 5){
//
//                                                Text("Burger")
//                                                    .font(.custom("SFProRounded-Light", size: 16) )
//                                                    .lineLimit(1)
//                                                Text(" ")
//                                                    .frame(
//                                                      minWidth: 0,
//                                                      maxWidth: "Burger".widthOfString(usingFont: UIFont.systemFont(ofSize: 14, weight: .bold)),
//                                                      minHeight: 0,
//                                                      maxHeight: 2,
//                                                      alignment: .leading
//                                                    )
//                                                    .background(Color("Color-red"))
//                                            }
//                                        }
//                                        else{
//                                            VStack(spacing: 5){
//
//                                                Text("Burger")
//                                                    .font(.custom("SFProRounded-Light", size: 16) )
//                                                    .lineLimit(1)
//
//                                            }
//                                        }
//                                    }
//                                }
//                            }
//                            .frame(width: 1050, height: 40, alignment: .leading)
//
//                        }
                        }
                        VStack{
                            VStack{
                                if !showFullScreen{
//                                HStack{
//                                    Spacer()
//                                        .frame(width:20)
//                                    Text("Description")
//                                        .font(.custom("SFProRounded-Regular", size: 23) )
//                                        .foregroundColor(Color("Color-red"))
//                                        .lineLimit(1)
//                                        .padding(.bottom)
//                                    Spacer()
//                                }
//                                HStack{
//                                    Spacer()
//                                        .frame(width:20)
//                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus.")
//                                        .font(.custom("SFProRounded-Regular", size: 15) )
//                                    Spacer()
//                                }
                                if menu.count > 0 {
                                    HStack{
                                        Spacer()
                                            .frame(width:20)
                                        Text("Menu")
                                            .font(.custom("SFProRounded-Regular", size: 23) )
                                            .foregroundColor(Color("Color-red"))
                                            .lineLimit(1)
                                            .padding(.vertical)
                                        Spacer()
                                    }
                                    ScrollView(.horizontal) {
                                        Spacer()
                                            .frame(height:20)
                                        HStack(spacing: 20) {
                                            Spacer()
                                                .frame(width:0)
                                            ForEach(menu, id: \.self) { meal in
                                                Button(action: {
    //                                                withAnimation{
    //                                                    goToMeal.toggle()
    //                                                }
                                                }, label: {
                                                    ZStack{
                                                        AsyncImage(url: URL(string: "https://yemekvar.az/images/Meal-Images/" + (meal["PhotoURL"] as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                                                            image
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fill)
//                                                                .clipped()
                                                        } placeholder: {
                                                            
                                                        }
                                                        Text(String((meal["CostInPenny"] as! Double)/100) + " ₼")
                                                            .frame(width: String((meal["CostInPenny"] as! Double)).widthOfString(usingFont: UIFont.systemFont(ofSize: 15, weight: .bold)) + 14, height: 20, alignment: .center)
                                                            .foregroundColor(Color("Color-red"))
                                                            .font(.custom("SFProRounded-Regular", size: 15) )
                                                            .lineLimit(1)
                                                            .background(Color("Color-white"))
                                                            .cornerRadius(30)
                                                            //.position(x: 110, y: 40)
                                                            .padding(.bottom, 110)
                                                            .padding(.trailing, 50)
                                                        VStack{
                                                            HStack{
                                                                Text((meal["Name"] as! String))
                                                                    .font(.custom("SFProRounded-Regular", size: 19) )
                                                                    .lineLimit(1)
                                                                    .foregroundColor(Color("Color-red"))
                                                            }
                                                            
                                                            
                                                            
                            //                                VStack (alignment: .center) {
                            //                                    HStack{
                            //
                            //                                        Spacer()
                            //                                        Text("450 g.")
                            //                                            .frame(height:26)
                            //                                            .font(.custom("SFProRounded-Light", size: 15) )
                            //                                            .lineLimit(1)
                            ////                                            .padding(.horizontal)
                            //                                        Image("Icon-fire")
                            //                                            .resizable()
                            //                                            .scaledToFit()
                            //                                            .frame(width: 15, height: 20)
                            //                                        Spacer()
                            //
                            //                                    }
                            //                                    .frame(height: 36)
                            //                                    Spacer()
                            //                                        .frame(height:20)
                            //                                }
                            //                                .frame(width: (UIScreen.screenWidth - 40)/2, height: 40, alignment: .leading)

                                                        }

                                                        .frame(width: (UIScreen.screenWidth - 40)/2, height: 40)
                                                        .background(Color("Color-white"))
                                                        .cornerRadius(20)
                                                        //.position(x: 221, y: 200)
                                                        .padding(.top, 100)
                        //                                .padding(.trailing, 3)
                                                    }
                                                    .frame(width: (UIScreen.screenWidth - 40)/2, height: (UIScreen.screenWidth - 40)/2)
                                                        .cornerRadius(20)
                                                        .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
                                                })
    //                                            .sheet(isPresented: $goToMeal) {
    //                                                VStack{
    //                                                    Spacer()
    //                                                    MealView(id: (meal["ID"] as! Int))
    //                                                        .frame(height: UIScreen.screenHeight)
    //                                                                    .clearModalBackground()
    //                                                }
    //
    //
    //                                            }
                                            }
                                            
                                        }
                                        Spacer()
                                            .frame(width:100)

                                    }
                                    .frame(height: 200)
                                }

//                                HStack{
//                                    Spacer()
//                                        .frame(width:20)
//                                    Text("See the whole menu")
//                                        .font(.custom("SFProRounded-Light", size: 21) )
//                                        .lineLimit(1)
//                                        .foregroundColor(Color("Color-red"))
//                                    Image("Icon-right")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 15, height: 20, alignment: .center)
//                                    Spacer()
//                                }
                                HStack{
                                    VStack{
//                                        HStack{
//                                            Spacer()
//                                                .frame(width:20)
//                                            Text("Reviews")
//                                                .font(.custom("SFProRounded-Regular", size: 23) )
//                                                .foregroundColor(Color("Color-red"))
//                                                .lineLimit(1)
//                                                .padding(.bottom)
//                                            Spacer()
//
//                                        }
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            Text("Overall rating")
                                                .font(.custom("SFProRounded-Regular", size: 18) )
                                                .lineLimit(1)
                                            Spacer()

                                        }
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            Text(type1)
                                                .font(.custom("SFProRounded-Regular", size: 40) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Image("Icon-star")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 33, height: 35, alignment: .center)
                                            Spacer()

                                        }
                                        Spacer()
                                    }
                                    .frame(height:150)

                                    VStack{
//                                        Spacer()
//                                            .frame(height:5)
//                                        HStack{
//                                            Spacer()
//                                                .frame(width:20)
//                                            Text("3,185 rates")
//                                                .font(.custom("SFProRounded-Regular", size: 18) )
//                                                .lineLimit(1)
//                                            Spacer()
//
//                                        }
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            Text("1")
                                                .font(.custom("SFProRounded-Regular", size: 13) )
                                            ProgressView("", value: Double(type1), total: 5)
                                                .accentColor(Color("Color-red"))
                                                .position(x: 65, y: -5)

                                            Spacer()
                                                .frame(width:20)

                                        }
                                        .frame(height:10)
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            Text("2")
                                                .font(.custom("SFProRounded-Regular", size: 13) )
                                            ProgressView("", value: Double(type2), total: 5)
                                                .accentColor(Color("Color-red"))
                                                .position(x: 65, y: -5)

                                            Spacer()
                                                .frame(width:20)

                                        }
                                        .frame(height:10)
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            Text("3")
                                                .font(.custom("SFProRounded-Regular", size: 13) )
                                            ProgressView("", value: Double(type3), total: 5)
                                                .accentColor(Color("Color-red"))
                                                .position(x: 65, y: -5)

                                            Spacer()
                                                .frame(width:20)

                                        }
                                        .frame(height:10)
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            Text("4")
                                                .font(.custom("SFProRounded-Regular", size: 13) )
                                            ProgressView("", value: Double(type4), total: 5)
                                                .accentColor(Color("Color-red"))
                                                .position(x: 65, y: -5)

                                            Spacer()
                                                .frame(width:20)

                                        }
                                        .frame(height:10)
                                        HStack{
                                            Spacer()
                                                .frame(width:20)
                                            Text("5")
                                                .font(.custom("SFProRounded-Regular", size: 13) )
                                            ProgressView("", value: Double(type5), total: 5)
                                                .accentColor(Color("Color-red"))
                                                .position(x: 65, y: -5)

                                            Spacer()
                                                .frame(width:20)

                                        }
                                        .frame(height:10)
                                    }
                                    .frame(height:150)
                                }
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    Text("Details")
                                        .font(.custom("SFProRounded-Regular", size: 23) )
                                        .foregroundColor(Color("Color-red"))
                                        .lineLimit(1)
                                        .padding(.bottom)
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    Image("Icon-location-black")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18, height: 18, alignment: .center)
                                    Text("Address")
                                        .font(.custom("SFProRounded-Regular", size: 18) )
                                        .lineLimit(1)
                                    Spacer()
                                    Text(address)
                                        .font(.custom("SFProRounded-Light", size: 15) )
                                        .lineLimit(1)
                                    Spacer()
                                        .frame(width:20)
                                }
                                }
                                ZStack{
                                    LocationView()
                                        .frame(width: showFullScreen ? UIScreen.screenWidth : UIScreen.screenWidth - 40, height: showFullScreen ? UIScreen.screenHeight : 150)
                                        .cornerRadius(20)
                                        .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                                    Button(action: {
                                        withAnimation{
                                            showFullScreen.toggle()
                                        }
                                    }, label: {
                                        Image("Icon-full-screen")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .padding(10)
                                            .background(Color("Color-white"))
                                            .cornerRadius(30)
                                            .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
//                                            .position(x: UIScreen.screenWidth - 60, y: 130)
                                            .padding(.top, showFullScreen ? UIScreen.screenHeight - 40 : 110)
                                            .padding(.leading, UIScreen.screenWidth/2 + 80)
                                    })
                                    
                                }
                                .frame(width: showFullScreen ? UIScreen.screenWidth : UIScreen.screenWidth - 40, height: showFullScreen ? UIScreen.screenHeight : 150)
//                                HStack{
//                                    Spacer()
//                                        .frame(width:20)
//                                    Button(action: {}, label: {
//                                        HStack{
//                                            Text("Share")
//                                               // .frame(height:26)
//                                                .font(.custom("SFProRounded-Light", size: 18) )
//                                                .lineLimit(1)
//                                                .foregroundColor(Color("Color-red"))
//                                            Image("Icon-share")
//                                                .resizable()
//                                                .scaledToFit()
//                                                .frame(width: 20, height: 20)
//                                        }
//                                    })
//                                        .frame(width:UIScreen.screenWidth/3, height: 40)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 30)
//                                                .stroke(Color("Color-red"), lineWidth: 3)
//                                        )
//                                    Spacer()
//                                    Button(action: {}, label: {
//                                        HStack{
//                                            Text("Get directions")
//                                               // .frame(height:26)
//                                                .font(.custom("SFProRounded-Light", size: 18) )
//                                                .lineLimit(1)
//                                                .foregroundColor(Color("Color-white"))
//                                            Image("Icon-arrow")
//                                                .resizable()
//                                                .scaledToFit()
//                                                .frame(width: 20, height: 20)
//                                        }
//                                    })
//                                        .frame(width:UIScreen.screenWidth/2, height: 40)
//                                        .background(Color("Color-red"))
//                                        .cornerRadius(30)
//                                    Spacer()
//                                        .frame(width:20)
//
//                                }
//                                .padding(.top)
                            }
                            if !showFullScreen{
                            VStack{
                                Text(" ")
                                    .frame(
                                      minWidth: 0,
                                      maxWidth: UIScreen.screenWidth - 40,
                                      minHeight: 0,
                                      maxHeight: 1,
                                      alignment: .leading
                                    )
                                    .background(Color.gray)
                                    .padding(.top)
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    Image("Icon-phone")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                    Text("Phone")
                                       .font(.custom("SFProRounded-Regular", size: 17) )
                                       .lineLimit(1)
                                    Spacer()
                                    Text("+994" + String(number))
                                        .font(.custom("SFProRounded-Light", size: 15) )
                                        .lineLimit(1)
                                    Spacer()
                                        .frame(width:20)
                                }
//                                Text(" ")
//                                    .frame(
//                                      minWidth: 0,
//                                      maxWidth: UIScreen.screenWidth - 40,
//                                      minHeight: 0,
//                                      maxHeight: 1,
//                                      alignment: .leading
//                                    )
//                                    .background(Color.gray)
//                                    .padding(.top)
//                                HStack{
//                                    Spacer()
//                                        .frame(width:20)
//                                    Image("Icon-money")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 20, height: 20)
//                                    Text("Average price")
//                                       .font(.custom("SFProRounded-Regular", size: 17) )
//                                       .lineLimit(1)
//                                    Spacer()
//                                    Text("$ 25-30")
//                                        .font(.custom("SFProRounded-Light", size: 15) )
//                                        .lineLimit(1)
//                                    Spacer()
//                                        .frame(width:20)
//                                }
//                                Text(" ")
//                                    .frame(
//                                      minWidth: 0,
//                                      maxWidth: UIScreen.screenWidth - 40,
//                                      minHeight: 0,
//                                      maxHeight: 1,
//                                      alignment: .leading
//                                    )
//                                    .background(Color.gray)
//                                    .padding(.top)
//                                HStack{
//                                    Spacer()
//                                        .frame(width:20)
//                                    Image("Icon-cuisine")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 20, height: 20)
//                                    Text("Cuisine")
//                                       .font(.custom("SFProRounded-Regular", size: 17) )
//                                       .lineLimit(1)
//                                    Spacer()
//                                    Text("European, Italian")
//                                        .font(.custom("SFProRounded-Light", size: 15) )
//                                        .lineLimit(1)
//                                    Spacer()
//                                        .frame(width:20)
//                                }
                                Text(" ")
                                    .frame(
                                      minWidth: 0,
                                      maxWidth: UIScreen.screenWidth - 40,
                                      minHeight: 0,
                                      maxHeight: 1,
                                      alignment: .leading
                                    )
                                    .background(Color.gray)
                                    .padding(.top)
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    Image("Icon-clock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .padding(.bottom)
                                    Text("Hours of operation")
                                       .font(.custom("SFProRounded-Regular", size: 17) )
                                       .lineLimit(1)
                                       .padding(.bottom)
                                    Spacer()
                                    
                                }
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    VStack{
                                        HStack{
                                            Text("Mon")
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Text(day1)
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                        }
                                        HStack{
                                            Text("Tue")
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Text(day2)
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                        }
                                        HStack{
                                            Text("Wen")
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Text(day3)
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                        }
                                        HStack{
                                            Text("Thu")
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Text(day4)
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                        }
                                        HStack{
                                            Text("Fri")
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Text(day5)
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                        }
                                        HStack{
                                            Text("Sat")
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Text(day6)
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                        }
                                        HStack{
                                            Text("Sun")
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                                .foregroundColor(Color("Color-red"))
                                            Text(day7)
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .lineLimit(1)
                                        }
                                    }
                                    Spacer()
                                        .frame(width:20)
                                }
//                                Text(" ")
//                                    .frame(
//                                      minWidth: 0,
//                                      maxWidth: UIScreen.screenWidth - 40,
//                                      minHeight: 0,
//                                      maxHeight: 1,
//                                      alignment: .leading
//                                    )
//                                    .background(Color.gray)
//                                    .padding(.top)
//                                HStack{
//                                    Spacer()
//                                        .frame(width:20)
//                                    Image("Icon-dress")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 20, height: 20)
//                                    Text("Dressing style")
//                                       .font(.custom("SFProRounded-Regular", size: 17) )
//                                       .lineLimit(1)
//                                    Spacer()
//                                    Text("Casual")
//                                        .font(.custom("SFProRounded-Light", size: 15) )
//                                        .lineLimit(1)
//                                    Spacer()
//                                        .frame(width:20)
//                                }
                                
                            }
//                            VStack{
//                                Text(" ")
//                                    .frame(
//                                      minWidth: 0,
//                                      maxWidth: UIScreen.screenWidth - 40,
//                                      minHeight: 0,
//                                      maxHeight: 1,
//                                      alignment: .leading
//                                    )
//                                    .background(Color.gray)
//                                    .padding(.top)
//                                HStack{
//                                    Spacer()
//                                        .frame(width:20)
//                                    Image("Icon-card")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 20, height: 20)
//                                    Text("Payment options")
//                                       .font(.custom("SFProRounded-Regular", size: 17) )
//                                       .lineLimit(1)
//                                    Spacer()
//                                    Text("Visa, Mastercard, Cash")
//                                        .font(.custom("SFProRounded-Light", size: 15) )
//                                        .lineLimit(1)
//                                    Spacer()
//                                        .frame(width:20)
//                                }
//                                Text(" ")
//                                    .frame(
//                                      minWidth: 0,
//                                      maxWidth: UIScreen.screenWidth - 40,
//                                      minHeight: 0,
//                                      maxHeight: 1,
//                                      alignment: .leading
//                                    )
//                                    .background(Color.gray)
//                                    .padding(.top)
//                                HStack{
//                                    Spacer()
//                                        .frame(width:20)
//                                    Image("Icon-dots")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 20, height: 20)
//                                    Text("Additional info")
//                                       .font(.custom("SFProRounded-Regular", size: 17) )
//                                       .lineLimit(1)
//                                    Spacer()
//                                }
//                                HStack{
//                                    Spacer()
//                                        .frame(width:45)
//                                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus.")
//                                        .font(.custom("SFProRounded-Light", size: 15) )
//                                    Spacer()
//                                        .frame(width:20)
//                                }
//                            }
                            }
                        }
                    
                    
                    
                    }
                    if !showFullScreen{
                    Spacer()
                        .frame(height:50)
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
            .task({
                await loadData()
            })
        }
        
    }
    func loadData() async{
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/reservation/restaurant") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["userId": loggedID, "restId": String(id)]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                    day1 = json!["day1"] as! String
                    day2 = json!["day2"] as! String
                    day3 = json!["day3"] as! String
                    day4 = json!["day4"] as! String
                    day5 = json!["day5"] as! String
                    day6 = json!["day6"] as! String
                    day7 = json!["day7"] as! String
                    latitude = json!["Latitude"] as! String
                    longitude = json!["Longitude"] as! String
                    UserDefaults.standard.set(latitude, forKey: "restLat")
                    UserDefaults.standard.set(longitude, forKey: "restLon")

                    isFavourite = json!["isFavourite"] as! Bool
                    type1 = json!["type1"] as! String
                    type2 = json!["type2"] as! String
                    type3 = json!["type3"] as! String
                    type4 = json!["type4"] as! String
                    type5 = json!["type5"] as! String
                    address = json!["Display_Address"] as! String
                    number = json!["Number"] as! Int
                    tags = json!["Tags"] as! [String]
                    let gal = json!["gallery"] as! [NSDictionary]
                    gallery = gal[0]["PhotoURL"] as! String
                    photoUrl = json!["PhotoURL"] as! String
                    name = json!["Name"] as! String
                    uniqueNum = json!["Unique_Num"] as! String
                    menu = json!["menu"] as! [NSDictionary]
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

struct ReservationRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationRestaurantView(id: 1)
            .preferredColorScheme(.dark)
    }
}
