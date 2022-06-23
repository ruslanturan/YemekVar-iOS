//
//  DeliveryHomeView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 20.04.22.
//

import SwiftUI

struct DeliveryHomeView: View {

    @ObservedObject var location = LocationManager()
    @State var goToRestaurant = false
    @State var goToSearch = false
    @State var searchText: String = ""
    @State private var isShowingMenu = false
    @State var isLoading = false
    @State var showAlert = false
    @State var closeApp = false
    @State private var goToReservation = false
    @State var message = ""
    @State var address = ""
    @State var selectedAddress = UserDefaults.standard.string(forKey: "selectedStreet") ?? ""
    @State var featuredRestaurants: [NSDictionary] = []
    @State var nearestRestaurants: [NSDictionary] = []
    @State var topPlaces: [NSDictionary] = []
    @State var dividers: [NSDictionary] = []
    @State var dividerID: Int = 0
    @State var restID: Int = 0
    @State var favouriteRestaurants: [Int] = []
    @State private var goToAddress = false

    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""

    var lat: String {
        return "\(location.lastKnownLocation?.coordinate.latitude ?? 0.0)"
    }

    var lon: String {
        return "\(location.lastKnownLocation?.coordinate.longitude ?? 0.0)"
    }
    init() {
        self.location.startUpdating()
    }
    var body: some View {
        LoadingView(isShowing: $isLoading) {

        ZStack{
                VStack{
                    
                    HStack{
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
                    }
                    ScrollView{

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
                                .submitLabel(.done)
                                .onSubmit{
                                    UserDefaults.standard.set(searchText, forKey: "DeliverySearchText")
                                    withAnimation{
                                        goToSearch.toggle()
                                    }
                                }
                                .fullScreenCover(isPresented: $goToSearch, content: {
                                    DeliverySearchView()
                                    
                                })
                        }
                        .frame(width: UIScreen.screenWidth - 40, height: 50, alignment: .leading)
                        .background(Color("Color-white"))
                        .cornerRadius(50)
                        .padding(.vertical)
                        .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 10)
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            Spacer()
                                .frame(width:0)
                            ForEach(dividers, id: \.self) { divider in
                                Group{
                                    if dividerID == divider["ID"] as! Int {
                                        Button(action: {
                                            dividerID = divider["ID"] as! Int

                                            Task{
                                                await divide()
                                            }
                                        }, label: {
                                            VStack(spacing: 5){
                                                AsyncImage(url: URL(string: "https://yemekvar.az/images/Delivery-Divider/" + (divider["PhotoURL"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                } placeholder: {
                                                    VStack{}
                                                        .background(Color.gray)
                                                }
                                           
                                                    .frame(width: 50, height: 50, alignment: .center)
                                                    .padding(10)
                                                    .background(Color("Color-white"))
                                                    .clipShape(Circle())
                                                Text(divider["Name"] as! String)
                                                    .font(.custom("SFProRounded-Light", size: 15) )
                                                    .padding(.bottom)
                                                    .lineLimit(1)
//                                                    .foregroundColor(Color("Color-black"))

                                                
                                            }
                                            .foregroundColor(Color("Color-white"))
                                            .font(.largeTitle)
                                            .frame(width: 80, height: 120)
                                            .background(Color("Color-red"))
                                            .cornerRadius(45)
                                        })
                                    }
                                    else{
                                        Button(action: {
                                            dividerID = divider["ID"] as! Int

                                            Task{
                                                await divide()
                                            }
                                        }, label: {
                                            VStack(spacing: 5){
                                                AsyncImage(url: URL(string: "https://yemekvar.az/images/Delivery-Divider/" + (divider["PhotoURL"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                } placeholder: {
                                                    VStack{}
                                                        .background(Color.gray)
                                                    
                                                }
                                                .frame(width: 50, height: 50, alignment: .center)
                                                    .padding(10)
                                                    .background(Color("Color-yellow"))
                                                    .clipShape(Circle())
                                                Text(divider["Name"] as! String)
                                                    .font(.custom("SFProRounded-Light", size: 15) )
                                                    .padding(.bottom)
                                                    .foregroundColor(Color("Color-black"))
                                                    .lineLimit(1)
                                            }
                                            .font(.largeTitle)
                                            .frame(width: 80, height: 120)
                                            .background(Color("Color-white"))
                                            .cornerRadius(45)
                                            .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
                                        })
                                        
                                    }
                                }
                                
                            }
                            Spacer()
                                .frame(width:100)
                        }
                        .frame(height: 160)

                    }
                    
                    
                    
                    
                    
//                    ScrollView(.horizontal) {
//                        HStack(spacing: 20) {
//                            Spacer()
//                                .frame(width:0)
//                            ForEach(0..<10) {number in
//                                Group{
//                                    if number % 2 == 0 {
//                                        VStack(spacing: 5){
//                                            Text("On your first order")
//                                                .font(.custom("SFProRounded-Light", size: 15) )
//                                                .lineLimit(1)
//                                                .padding(.leading)
//                                                .foregroundColor(Color("Color-white"))
//                                                .frame(
//                                                  minWidth: 0,
//                                                  maxWidth: .infinity,
//                                                  minHeight: 0,
//                                                  maxHeight: .infinity,
//                                                  alignment: .leading
//                                                )
//                                            HStack{
//                                                Spacer()
//                                                    .frame(width:15)
//                                                Text("Up to 50% Off")
//                                                    .font(.custom("SFProRounded-Light", size: 22) )
//                                                    .lineLimit(2)
//                                                    .padding(.trailing)
//                                                    .foregroundColor(Color("Color-red"))
//                                                    .frame(width: 100, height: 70)
//                                                Spacer()
//                                            }
//                                        }
//                                        .frame(width: 160, height: 120)
//                                        .background(Color("Color-yellow"))
//                                        .cornerRadius(20)
//                                        .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
//                                    }
//                                    else{
//                                        VStack(spacing: 5){
//                                            Text("#PartyTime")
//                                                .font(.custom("SFProRounded-Light", size: 15) )
//                                                .lineLimit(1)
//                                                .padding(.leading)
//                                                .foregroundColor(Color("Color-white"))
//                                                .frame(
//                                                  minWidth: 0,
//                                                  maxWidth: .infinity,
//                                                  minHeight: 0,
//                                                  maxHeight: .infinity,
//                                                  alignment: .leading
//                                                )
//                                            HStack{
//                                                Spacer()
//                                                    .frame(width:15)
//                                                Text("Get a Free Drink Added")
//                                                    .font(.custom("SFProRounded-Light", size: 22) )
//                                                    .lineLimit(2)
//                                                    .padding(.trailing)
//                                                    .foregroundColor(Color("Color-yellow"))
//                                                    .frame(width: 160, height: 70)
//                                                Spacer()
//                                            }
//                                        }
//                                        .frame(width: 160, height: 120)
//                                        .background(Color("Color-red"))
//                                        .cornerRadius(20)
//                                        .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
//                                    }
//                                }
//                            }
//                        }
//                        .frame(width: 1050, height: 160, alignment: .leading)
//                    }
                    
                    
                    
                    
                    
                    
                    VStack{
                        Text(" ")
                            .frame(
                              minWidth: 0,
                              maxWidth: UIScreen.screenWidth - 20,
                              minHeight: 0,
                              maxHeight: 1,
                              alignment: .leading
                            )
                            .background(Color("Color-red"))
                        if !(featuredRestaurants.isEmpty){
                        HStack{
                            Spacer()
                                .frame(width:15)
                            Text("Featured restaurants")
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
//                                .frame(width:10, height:10)
//                            Spacer()
//                                .frame(width:15)
                        }
                        ScrollView(.horizontal) {
                            Spacer()
                                .frame(height:20)
                            HStack(spacing: 20) {
                                Spacer()
                                    .frame(width:0)
                                ForEach(featuredRestaurants, id: \.self) { restaurant in
                                    Button(action: {
                                        restID = (restaurant["ID"] as! Int)

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
                                                        Image("Icon-star")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 17, height: 17)
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
                                                            })
                                                    }
                                                }

                                            }
                                            .padding(.bottom,160)
                                            .frame(width: UIScreen.screenWidth - 70)

                                            
                                           
                                           
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
                                                        Button(action: {
                                                            restID = (restaurant["ID"] as! Int)
                                                            withAnimation{
                                                                goToReservation.toggle()
                                                            }
                                                        }, label: {
                                                            Text("Tables available")
                                                                .font(.custom("SFProRounded-Light", size: 12) )
                                                                .lineLimit(1)
                                                                .foregroundColor(Color("Color-red"))
                                                            Image("Icon-right")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width:6, height:10)
                                                        })
                                                        .fullScreenCover(isPresented: $goToReservation, content: {
                                                            if restID != 0{
                                                                ReservationRestaurantView(id: restID)
                                                            }
                                                        })
                                                    }
                                                    
                                                    Spacer()
                                                        .frame(width:10)
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
                                            DeliveryRestaurantView(id: restID)
                                        }
                                    })
                                    
                                }
                                Spacer()
                                    .frame(width:100)
                            }
                            .frame(height: 260, alignment: .topLeading)

                        }
                        }
                    }
                    VStack{
                        if !(topPlaces.isEmpty){
                        HStack{
                            Spacer()
                                .frame(width:15)
                            Text("Top places for you")
                                .font(.custom("SFProRounded-Light", size: 22) )
                                .lineLimit(1)
                                .padding(.trailing)
                                .foregroundColor(Color("Color-red"))
                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                Spacer()
                                    .frame(width:0)
                                ForEach(topPlaces, id: \.self) { place in
                                    VStack(spacing: 5){
                                        Button(action: {
                                            restID = (place["ID"] as! Int)
                                            withAnimation{
                                                goToRestaurant.toggle()
                                            }
                                        }, label: {
                                            VStack{
                                            AsyncImage(url: URL(string: "https://yemekvar.az/images/Restaurant-Images/" + (place["Unique_Num"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "/" + (place["PhotoURL"]  as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! )){ image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            } placeholder: {
                                                VStack{}
                                                    .background(Color.gray)
                                            }
                                                .frame(width: UIScreen.screenWidth/6, height: UIScreen.screenWidth/6, alignment: .center)
                                                .clipShape(Circle())
                                            Text(verbatim: (place["Name"]  as! String))
                                                .font(.custom("SFProRounded-Light", size: 15) )
                                                .foregroundColor(Color("Color-black"))
                                                .lineLimit(1)
                                            }
                                        })
                                        .fullScreenCover(isPresented: $goToRestaurant, content: {
                                            if restID != 0{
                                                DeliveryRestaurantView(id: restID)
                                            }
                                        })
                                    }
                                    .frame(width: (place["Name"]  as! String).widthOfString(usingFont: UIFont.systemFont(ofSize: 13, weight: .bold)), height: 100)
                                }
                                Spacer()
                                    .frame(width:100)
                            }
                        }
                        }
                    }
                        if !(nearestRestaurants.isEmpty){
                    HStack{
                        Spacer()
                            .frame(width:15)
                        Text("Nearest restaurants")
                            .font(.custom("SFProRounded-Light", size: 22) )
                            .lineLimit(1)
                            .padding(.trailing)
                            .foregroundColor(Color("Color-red"))
                        Spacer()
//                        Text("View all")
//                            .font(.custom("SFProRounded-Light", size: 15) )
//                            .lineLimit(1)
//                            .foregroundColor(Color("Color-red"))
//                        Image("Icon-right")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width:10, height:10)
//                        Spacer()
//                            .frame(width:15)
                    }
                    ScrollView(.horizontal) {
                        Spacer()
                            .frame(height:20)
                        HStack(spacing: 20) {
                            Spacer()
                                .frame(width:0)
                            ForEach(nearestRestaurants, id: \.self) { restaurant in
                                Button(action: {
                                    restID = (restaurant["ID"] as! Int)
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
                                                    Image("Icon-star")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 17, height: 17)
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
                                                        })
                                                }
                                            }

                                        }
                                        .padding(.bottom,160)
                                        .frame(width: UIScreen.screenWidth - 70)

                                        
                                       
                                       
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
                                                Text( (restaurant["name"]  as! String) )
                                                    .font(.custom("SFProRounded-Regular", size: 22) )
                                                    .lineLimit(1)
                                                    .padding(.trailing)
                                                    .foregroundColor(Color("Color-red"))
                                                Spacer()
                                                if restaurant["isReservable"]  as! Bool{
                                                    Button(action: {
                                                        restID = (restaurant["ID"] as! Int)
                                                        withAnimation{
                                                            goToReservation.toggle()
                                                        }
                                                    }, label: {
                                                        Text("Tables available")
                                                            .font(.custom("SFProRounded-Light", size: 12) )
                                                            .lineLimit(1)
                                                            .foregroundColor(Color("Color-red"))
                                                        Image("Icon-right")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width:6, height:10)
                                                    })
                                                    .fullScreenCover(isPresented: $goToReservation, content: {
                                                        if restID != 0{
                                                            ReservationRestaurantView(id: restID)
                                                        }
                                                    })
                                                }
                                                
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
                                        DeliveryRestaurantView(id: restID)
                                    }
                                })
                                
                            }
                            Spacer()
                                .frame(width:100)
                        }
                        .frame(height: 260, alignment: .topLeading)

                    }
                        Spacer()
                            .frame(height:100)
                        }
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
                    guard let url = URL(string: "https://yemekvar.az/api/delivery/homeasync") else {
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
                                address = (json!["location"] as? String)!
                                UserDefaults.standard.set(address, forKey: "loggedAddress")

                                featuredRestaurants = json!["featuredRestaurants"] as! [NSDictionary]
                                nearestRestaurants = json!["nearest"] as! [NSDictionary]
                                favouriteRestaurants = json!["favs"] as! [Int]
                                topPlaces = json!["topRestaurants"] as! [NSDictionary]
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
                    guard let url = URL(string: "https://yemekvar.az/api/delivery/homeasync") else {
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
                                address = (json!["location"] as? String)!
                                UserDefaults.standard.set(address, forKey: "loggedAddress")

                                featuredRestaurants = json!["featuredRestaurants"] as! [NSDictionary]
                                nearestRestaurants = json!["nearest"] as! [NSDictionary]
                                favouriteRestaurants = json!["favs"] as! [Int]
                                topPlaces = json!["topRestaurants"] as! [NSDictionary]
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

        guard let url = URL(string: "https://yemekvar.az/api/delivery/divide") else {
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

                    featuredRestaurants = json!["featuredRestaurants"] as! [NSDictionary]
                    nearestRestaurants = json!["nearest"] as! [NSDictionary]
                    topPlaces = json!["topRestaurants"] as! [NSDictionary]
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
    func loadData() async{
        
        UserDefaults.standard.set("2", forKey: "GuestCount")
        UserDefaults.standard.set("Now", forKey: "PickedDay")
        UserDefaults.standard.set("", forKey: "PickedHour")

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
        guard let url = URL(string: "https://yemekvar.az/api/delivery/homeasync") else {
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
                    address = (json!["location"] as? String)!
                    UserDefaults.standard.set(address, forKey: "loggedAddress")

                    featuredRestaurants = json!["featuredRestaurants"] as! [NSDictionary]
                    nearestRestaurants = json!["nearest"] as! [NSDictionary]
                    favouriteRestaurants = json!["favs"] as! [Int]
                    topPlaces = json!["topRestaurants"] as! [NSDictionary]
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

struct DeliveryHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryHomeView()
    }
}
extension Double {
    // Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
