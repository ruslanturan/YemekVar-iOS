//
//  DeliverySearchView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 07.05.22.
//

import SwiftUI

struct DeliverySearchView: View {

    @State private var isShowingMenu = false
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    @State var isEmpty = false
    @State var isLoading = false
    @State var showAlert = false
    @State var closeApp = false
    @State var goToMeal = false
    @State var goToRestaurant = false
    @State var message = ""
    @State var meals: [NSDictionary] = []
    @State var restaurants: [NSDictionary] = []
    @State var word: String = UserDefaults.standard.string(forKey: "DeliverySearchText")!

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
                if isShowingMenu {
                    SideMenuView(isShowingMenu: $isShowingMenu)
                }
                ScrollView{
                    VStack{
                        Spacer()
                            .frame(height:30)
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Button(action: {
                                UserDefaults.standard.set("", forKey: "DeliverySearchText")
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
                        HStack{
                            Spacer()
                                .frame(width:10)
                            Image("Icon-search")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                            TextField("Search for food or restaurant...", text: $word)
                                .foregroundColor(Color.gray)
                                .font(.custom("SFProRounded-Regular", size: 18) )
                                .lineLimit(1)
                                .disabled(true)
                        }
                        .frame(width: UIScreen.screenWidth - 40, height: 50, alignment: .leading)
                        .background(Color("Color-white"))
                        .cornerRadius(50)
                        .padding(.vertical)
                        .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 10)
                    }
                    if !isEmpty{
                        ForEach(meals, id: \.self) { meal in

                            HStack{
                                Spacer()
                                    .frame(width:20)
                                Text("From")
                                   // .frame(height:26)
                                    .font(.custom("SFProRounded-Light", size: 23))
                                Text(meal["Name"] as! String)
                                   // .frame(height:26)
                                    .font(.custom("SFProRounded-Light", size: 23))
                                    .foregroundColor(Color("Color-red"))
                                Spacer()
                            }
                            HStack{
                                LazyVGrid(columns: twoColumnGrid) {
            
                                    // Display the item
                                    ForEach(0..<2){ num in
            
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
//                                                        .clipped()
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
                                            .sheet(isPresented: $goToMeal) {
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
                        }
                        ForEach(restaurants, id: \.self) { restaurant in
                            Button(action: {
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
                                    Text( (restaurant["Type_1"]  as! String) )
                                        .frame(width: 50, height: 10, alignment: .leading)
                                        .padding()
                                        .foregroundColor(Color("Color-red"))
                                        .font(.custom("SFProRounded-Regular", size: 21) )
                                        .lineLimit(1)
                                        .background(Color("Color-white"))
                                        .cornerRadius(30)
                                        //.position(x: 110, y: 40)
                                        .padding(.bottom,160)
                                        .padding(.trailing,UIScreen.screenWidth/2)
                                    Image("Icon-star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 17, height: 17)
                                        //.position(x: 130, y: 40)
                                        .padding(.bottom,160)
                                        .padding(.trailing,(UIScreen.screenWidth/2 - 40))
                                    Image("Icon-heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .padding(10)
                                        .background(Color("Color-red"))
                                        .cornerRadius(30)
                                        //.position(x: 120, y: 40)
                                        .padding(.bottom,160)
                                        .padding(.leading,(UIScreen.screenWidth/2 + 40))
//                                        Text("Free delivery, 10-15 min")
//                                            .font(.custom("SFProRounded-Light", size: 15))
//                                            .lineLimit(1)
//                                            .foregroundColor(Color.white)
//                                            //.position(x: 160, y: 150)
//                                            .padding(.top,50)
//                                            .padding(.trailing,(UIScreen.screenWidth/2 - 80))
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
                                            if restaurant["IsReservable"]  as! Bool{
                                                Button(action: {}, label: {
                                                    Text("Tables available")
                                                        .font(.custom("SFProRounded-Light", size: 12) )
                                                        .lineLimit(1)
                                                        .foregroundColor(Color("Color-red"))
                                                    Image("Icon-right")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width:6, height:10)
                                                })
                                            }
                                            
                                            Spacer()
                                                .frame(width:10)
                                        }
                                        VStack (alignment: .trailing) {
                                            HStack{
                                                Spacer()
                                                    .frame(width:20)
                                                if (restaurant["Tags"] as! [String] ).count > 1{
                                                    ForEach((restaurant["Tags"] as! [String]), id: \.self) { tag in

                                                    Text(tag)
                                                        .frame(width: tag.widthOfString(usingFont: UIFont.systemFont(ofSize: 13, weight: .bold)), height:26)
                                                        
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
                                ReservationRestaurantView(id: (restaurant["ID"] as! Int))
                            })
                            Spacer()
                                .frame(height:50)
                        }
                    }
                    else{
                        VStack{
                            Spacer()
                            Image("Icon-search-gray")
                                .resizable()
                                .scaledToFit()
                                .frame(width:130,height: 130)
                            Text("Item not found")
                               // .frame(height:26)
                                .font(.custom("SFProRounded-Light", size: 30) )
                            Text("Try searching the item with a different keyword.")
                               // .frame(height:26)
                                .font(.custom("SFProRounded-Light", size: 20) )
                                .multilineTextAlignment(.center)
                                .frame(width:240)
                            Spacer()
                        }
                        .frame(height: UIScreen.screenHeight - 250)
                    }
                }
                .background(Color("Color-white"))
                .cornerRadius(30)
                .offset(x: isShowingMenu ? UIScreen.screenWidth*0.7 : 0, y: 0)
                .scaleEffect(isShowingMenu ? 0.7 : 1)
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
            .background(Color("Color-white"))
            .task({
                await loadData()
            })
        }
    }
    func loadData() async{
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/delivery/search") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print(word)
        let body: [String: String] = ["word": word]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                    meals = json!["meals"] as! [NSDictionary]
                    restaurants = json!["restaurants"] as! [NSDictionary]
                    if meals.isEmpty && restaurants.isEmpty{
                        isEmpty = true
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

struct DeliverySearchView_Previews: PreviewProvider {
    static var previews: some View {
        DeliverySearchView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 13 Pro Max")
    }
}
