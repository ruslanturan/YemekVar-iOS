//
//  DeliveryRestaurantView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 25.04.22.
//

import SwiftUI
 struct DeliveryRestaurantView: View {
     @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    @State var goToMeal = false
     @State private var goToBasket = false
    @State var selection = 0
     @State var isLoading = false
     @State var refresh = false
    @State var showAlert = false
    @State var closeApp = false
    @State var message = ""
    @State var photoUrl: String = ""
    @State var isReservable: Bool = false
    @State var name: String = ""
    @State var address: String = ""
     @State var uniqueNum: String = ""
     @State var isFavourite: Bool = false
    @State var tags: [String] = []
    @State var gallery: String = ""
    @State var subTypes: [NSDictionary] = []
    @State var menu: [NSDictionary] = []
    @State var subTypeID: Int = 0
     @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""

    var id: Int
     public init (id: Int) {
         self.id = id

     }
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            
        ZStack{

            if refresh || !refresh{
            ScrollView {
//                Spacer()
//                    .frame(height:30)
                VStack{
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
//                                var meals: [BasketItem] = []
//
//                                let data = UserDefaults.standard.data(forKey: "Basket")
//                                if (data != nil){
//                                    let decoded = try? JSONDecoder().decode([BasketItem].self, from: data!)
//                                    meals = decoded!
//                                    meals.removeAll()
//                                }
//                                let encoded = try? JSONEncoder().encode(meals)
                                UserDefaults.standard.set("", forKey: "Basket")
                                UserDefaults.standard.set(0, forKey: "AllCost")

                                    
                                
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
                            if loggedID != ""{
                            Button(action: {
                                let data = UserDefaults.standard.data(forKey: "Basket")
                                    if data != nil{
                                        UserDefaults.standard.set(address, forKey: "RestaurantAddress")
                                        UserDefaults.standard.set(name, forKey: "RestaurantName")
                                        UserDefaults.standard.set(id, forKey: "RestaurantID")
                                        withAnimation{
                                            goToBasket.toggle()
                                        }
                                        
                                    }
                                    else{
                                        message = "Your basket is empty"
                                        withAnimation{
                                            showAlert.toggle()
                                        }
                                    }
                            }, label: {
                                HStack{
                                    Image("Icon-basket")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 15)
                                    Text(String(Double(UserDefaults.standard.integer(forKey: "AllCost") )/100) + " ₼")
                                        .foregroundColor(Color("Color-red"))
                                        .font(.custom("SFProRounded-Regular", size: 17) )
                                        .lineLimit(1)
                                        //.position(x: 110, y: 40)
                                }
                                
                                .frame(width: 90, height: 10)
                                .padding()

                                .background(Color("Color-white"))
                                .cornerRadius(30)

                                .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)

                                

                                    //.position(x: 130, y: 40)
                            })
                            .fullScreenCover(isPresented: $goToBasket, content: {
                                BasketView()
                            })
                            }
                            Spacer()
                                .frame(width:UIScreen.screenWidth/2 - 90)
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
                                                    guard let url = URL(string: "https://yemekvar.az/api/delivery/restaurant") else {
                                                        return
                                                    }
                                                    var request = URLRequest(url: url)
                                                    request.httpMethod = "POST"
                                                    let body: [String: String] = ["restID": String(id), "userID": loggedID]
                                                    let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                                    request.httpBody = finalBody
                                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                                                        guard let data = data else { return }
                                                        do{
                                                        let str = String(decoding: data, as: UTF8.self)
                                                            if !(str.lowercased().contains("error")){
                                                                let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                                                                address = json!["Display_Address"] as! String
                                                                tags = json!["Tags"] as! [String]
                                                                let gal = json!["gallery"] as! [NSDictionary]
                                                                gallery = gal[0]["PhotoURL"] as! String
                                                                subTypes = json!["subTypes"] as! [NSDictionary]
                                                                subTypeID = subTypes.first!["ID"] as! Int
                                                                isReservable = json!["IsReservable"] as! Bool
                                                                isFavourite = json!["isFavourite"] as! Bool
                                                                photoUrl = json!["PhotoURL"] as! String
                                                                name = json!["Name"] as! String
                                                                uniqueNum = json!["Unique_Num"] as! String
                                                                menu = json!["menu"] as! [NSDictionary]
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
                                                    guard let url = URL(string: "https://yemekvar.az/api/delivery/restaurant") else {
                                                        return
                                                    }
                                                    var request = URLRequest(url: url)
                                                    request.httpMethod = "POST"
                                                    let body: [String: String] = ["restID": String(id), "userID": loggedID]
                                                    let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                                    request.httpBody = finalBody
                                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                                                        guard let data = data else { return }
                                                        do{
                                                        let str = String(decoding: data, as: UTF8.self)
                                                            if !(str.lowercased().contains("error")){
                                                                let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                                                                address = json!["Display_Address"] as! String
                                                                tags = json!["Tags"] as! [String]
                                                                let gal = json!["gallery"] as! [NSDictionary]
                                                                gallery = gal[0]["PhotoURL"] as! String
                                                                subTypes = json!["subTypes"] as! [NSDictionary]
                                                                subTypeID = subTypes.first!["ID"] as! Int
                                                                isReservable = json!["IsReservable"] as! Bool
                                                                isFavourite = json!["isFavourite"] as! Bool
                                                                photoUrl = json!["PhotoURL"] as! String
                                                                name = json!["Name"] as! String
                                                                uniqueNum = json!["Unique_Num"] as! String
                                                                menu = json!["menu"] as! [NSDictionary]
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
//                                .clipped()
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
                    HStack{
                        Image("Icon-location")
                            .frame(width: 20, height: 30, alignment: .center)
        //                    .padding(.leading)
                        Text(address)
                            .lineLimit(1)
                            .font(.custom("SFProRounded-Light", size: 15) )
                    }
//                    HStack{
//                        if isReservable{
//                            Button(action: {}, label: {
//                                Text("Tables available")
//                                    .font(.custom("SFProRounded-Light", size: 21) )
//                                    .lineLimit(1)
//                                    .foregroundColor(Color("Color-red"))
//                                Image("Icon-right")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 15, height: 20, alignment: .center)
//                            })
//                        }
//
//                    }
                }

                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        Spacer()
                            .frame(width:0)
                        ForEach(subTypes, id: \.self) { subType in
                            Button(action: {
                                withAnimation{
                                    subTypeID = subType["ID"] as! Int
                                }
                            }, label: {
                                Group{
                                    if subTypeID == (subType["ID"] as! Int) {
                                        VStack(spacing: 5){

                                            Text((subType["Name"] as! String))
                                                .foregroundColor(Color.black)
                                                .font(.custom("SFProRounded-Light", size: 16) )
                                                .lineLimit(1)
                                            Text(" ")
                                                .frame(
                                                  minWidth: 0,
                                                  maxWidth: (subType["Name"] as! String).widthOfString(usingFont: UIFont.systemFont(ofSize: 13, weight: .bold)),
                                                  minHeight: 0,
                                                  maxHeight: 2,
                                                  alignment: .leading
                                                )
                                                .background(Color("Color-red"))
                                        }
                                    }
                                    else{
                                        VStack(spacing: 5){

                                            Text((subType["Name"] as! String))
                                                .foregroundColor(Color.black)
                                                .font(.custom("SFProRounded-Light", size: 16) )
                                                .lineLimit(1)

                                        }
                                    }
                                }

                            })
                        }
                    }
                    .frame(height: 40)
                    Spacer()
                        .frame(width:50)
                }
//                HStack{
//                    Spacer()
//                        .frame(width:20)
//                    DropdownPicker(title: "Sort by:", selection: $selection, options: ["Small", "Medium", "Large", "X-Large","Small", "Medium", "Large", "X-Large"])
//                        .cornerRadius(30)
//    //                    .frame(width: 120)
//
//                    Spacer()
//                }
//                Spacer()
//                    .frame(height:20)
                LazyVGrid(columns: twoColumnGrid) {
                    ForEach(menu, id: \.self) { meal in
                        if (meal["SubTypeID"] as! Int) == subTypeID{
                            Button(action: {
                                withAnimation{
                                    goToMeal.toggle()
                                }
                            }, label: {
                                ZStack{
                                    AsyncImage(url: URL(string: "https://yemekvar.az/images/Meal-Images/" + (meal["PhotoURL"] as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
//                                            .clipped()
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
                            .sheet(isPresented: $goToMeal, onDismiss: {
                                UserDefaults.standard.set(0, forKey: "SelectedMealItemsCost")
                                UserDefaults.standard.set("", forKey: "SelectedItemCosts")
                                UserDefaults.standard.set("", forKey: "SelectedItemIDs")
                                withAnimation{
                                    refresh.toggle()
                                }
                            }) {
                                VStack{
                                    Spacer()
                                    MealView(id: (meal["ID"] as! Int))
                                        .frame(height: UIScreen.screenHeight)
                                                    .clearModalBackground()
                                }
                                
                                
                            }
                            
                        }
                    }
                }
                Spacer()
                    .frame(height:50)
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
        }
        }
        .task({
            await loadData()
        })
    }
     func loadData() async{
         withAnimation{
             isLoading.toggle()
         }
         guard let url = URL(string: "https://yemekvar.az/api/delivery/restaurant") else {
             return
         }
         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         let body: [String: String] = ["restID": String(id), "userID": loggedID]
         let finalBody = try! JSONSerialization.data(withJSONObject: body)
         request.httpBody = finalBody
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         URLSession.shared.dataTask(with: request) { (data, response, error) in
             guard let data = data else { return }
             do{
             let str = String(decoding: data, as: UTF8.self)
                 if !(str.lowercased().contains("error")){
                     let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                     address = json!["Display_Address"] as! String
                     tags = json!["Tags"] as! [String]
                     let gal = json!["gallery"] as! [NSDictionary]
                     gallery = gal[0]["PhotoURL"] as! String
                     subTypes = json!["subTypes"] as! [NSDictionary]
                     subTypeID = subTypes.first!["ID"] as! Int
                     isReservable = json!["IsReservable"] as! Bool
                     isFavourite = json!["isFavourite"] as! Bool
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
//struct DeliveryRestaurantView_Previews: PreviewProvider {
//    static var previews: some View {
//        let id = 0
//        DeliveryRestaurantView(id: id)
//            .preferredColorScheme(.dark)
//            .previewDevice("iPhone 8")
//    }
//}


extension String {
   func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
