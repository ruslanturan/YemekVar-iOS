//
//  BasketView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 27.04.22.
//

import SwiftUI

struct BasketView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State private var comment: String = ""
    var allCount: Int = 0
    var allCost: Int = 0
    var basketItems: [BasketItem] = []
    @State var goToConfirmation = false

    
        public init(){
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
                    Text("Basket")
                       // .frame(height:26)
                        .font(.custom("SFProRounded-Light", size: 23) )
                    Spacer()
                    Button(action: {
                        UserDefaults.standard.set("", forKey: "Basket")
                        UserDefaults.standard.set(0, forKey: "AllCost")

                        withAnimation{
                            self.mode.wrappedValue.dismiss()
                        }
                        
                    }, label: {
                        Text("Clear all")
                           // .frame(height:26)
                            .font(.custom("SFProRounded-light", size: 15) )
                            .padding(.trailing,10)
                            .foregroundColor(Color("Color-red"))
                            .lineLimit(1)

                    })
                    
                    Spacer()
                        .frame(width:20)
                }
                ScrollView{

                HStack{
                    Spacer()
                        .frame(width:20)
                    Text(String(allCount) + " dish for " + String(Double(allCost)/100) + " ₼")
                        .font(.custom("SFProRounded-Regular", size: 30) )
                        .lineLimit(1)
                        .foregroundColor(Color("Color-red"))
                    Spacer()
                }
                    ForEach(basketItems, id:\.self){ item in
                    HStack{
                        Spacer()
                            .frame(width:20)
                        AsyncImage(url: URL(string: "https://yemekvar.az/images/Meal-Images/" + item.photoUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                            image
                                .resizable()
                                .scaledToFit()


                        } placeholder: {
                            Image("Image-2")
                                .resizable()
                                .scaledToFit()
                        }
                        
                            .frame(width:UIScreen.screenWidth/4, height: UIScreen.screenWidth/4)
                            .cornerRadius(20)
                            .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 3)
                        Spacer()
                            .frame(width:20)
                        VStack{
                            HStack{
                                Text(item.name)
                                    .font(.custom("SFProRounded-Light", size: 20) )
                                    .lineLimit(1)
                                    .foregroundColor(Color("Color-red"))
                                Spacer()
                            }

                            HStack{
//                                Text("450 g.")
//                                   // .frame(height:26)
//                                    .font(.custom("SFProRounded-Light", size: 15) )
//                                    .lineLimit(1)
//                                    //.padding(.horizontal)
//                                Image("Icon-fire")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 15, height: 20)
                                Text(String(item.count) + " x ")
                                    .foregroundColor(Color("Color-red"))
                                    .font(.custom("SFProRounded-light", size: 21) )
                                    .lineLimit(1)
                                    //.position(x: 110, y: 40)
                                    //.padding(.bottom,160)
                                Text(String(Double(item.cost)/100) + " ₼")
                                    .font(.custom("SFProRounded-Light", size: 20) )
                                    .lineLimit(1)
                                    .foregroundColor(Color("Color-red"))
                                Spacer()
//                                HStack{
//                                    HStack{
//                                        Button(action: {
//                                            withAnimation{
//                                                let index = basketItems.firstIndex(of: item)
//                                                var i = basketItems[index!]
//                                                if item.count > 1{
//
//                                                    i.count -= 1
//                                                }
////                                                else{
////                                                    basketItems.remove(at: index)
////                                                }
//                                            }
//                                        }, label: {
//                                            Text("-")
//                                                .font(.custom("SFProRounded-Light", size: 30) )
//                                                .lineLimit(1)
//                                                //.position(x: 110, y: 40)
//                                                .padding(.bottom,10)
//                                                .foregroundColor(Color("Color-white"))
//                                        })
//
//                                        Spacer()
//                                        Text(String(item.count))
//                                            .foregroundColor(Color("Color-red"))
//                                            .font(.custom("SFProRounded-light", size: 21) )
//                                            .lineLimit(1)
//                                            //.position(x: 110, y: 40)
//                                            //.padding(.bottom,160)
//                                        Spacer()
//                                        Button(action: {
//                                            withAnimation{
//                                                let index = basketItems.firstIndex(of: item)
//                                                var i = basketItems[index!]
//                                                if item.count != 9{
//
//                                                    i.count += 1
//                                                }
////                                                else{
////                                                    basketItems.remove(at: index)
////                                                }
//                                            }
//                                        }, label: {
//                                            Text("+")
//                                                .font(.custom("SFProRounded-Light", size: 30) )
//                                                .lineLimit(1)
//                                                //.position(x: 110, y: 40)
//                                                .foregroundColor(Color("Color-white"))
//                                                .padding(.bottom,10)
//                                        })
//
//                                    }
//                                    .padding()
//                                    .background(Color("Color-yellow"))
//                                    .frame(width: 90, height: 40, alignment: .trailing)
//                                    .cornerRadius(30)
//                                    .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
//
//                                    Spacer()
//                                }

                            }
                            Spacer()
                                .frame(height:10)
                        }
//                        VStack{
//                            HStack{
//                                Text("499 M")
//                                    .font(.custom("SFProRounded-Light", size: 20) )
//                                    .lineLimit(1)
//                                    .foregroundColor(Color("Color-red"))
//                            }
//
//                            Spacer()
//                        }
                        Spacer()
                            .frame(width:20)
                    }

                }
//                .frame(height:UIScreen.screenWidth/4)
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
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Text("Delivery")
                                .font(.custom("SFProRounded-Light", size: 20) )
                                .lineLimit(1)
                                //.foregroundColor(Color("Color-red"))
//                            Image("Icon-info")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width:20,height:20)
                            Spacer()
                            Text("Free")
                                .font(.custom("SFProRounded-Light", size: 20) )
                                .lineLimit(1)
                                .foregroundColor(Color("Color-red"))
                            Spacer()
                                .frame(width:20)
                        }
                        Text(" ")
                            .frame(
                              minWidth: 0,
                              maxWidth: UIScreen.screenWidth - 20,
                              minHeight: 0,
                              maxHeight: 1,
                              alignment: .leading
                            )
                            .background(Color("Color-red"))
                    }
                
//                HStack{
//                    Spacer()
//                        .frame(width:20)
//                    Text("Servie charge")
//                        .font(.custom("SFProRounded-Light", size: 20) )
//                        .lineLimit(1)
//                        //.foregroundColor(Color("Color-red"))
//                    Image("Icon-info")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width:20,height:20)
//                    Spacer()
//                    Text("0.90 M")
//                        .font(.custom("SFProRounded-Light", size: 20) )
//                        .lineLimit(1)
//                        .foregroundColor(Color("Color-red"))
//                    Spacer()
//                        .frame(width:20)
//                }
//                VStack(spacing: 5){
//                    Text("On your first order")
//                        .font(.custom("SFProRounded-Light", size: 15) )
//                        .lineLimit(1)
//                        .padding(.leading)
//                        .foregroundColor(Color("Color-white"))
//                        .frame(
//                          minWidth: 0,
//                          maxWidth: .infinity,
//                          minHeight: 0,
//                          maxHeight: .infinity,
//                          alignment: .leading
//                        )
//                    HStack{
//                        Spacer()
//                            .frame(width:15)
//                        Text("Up to 50% Off")
//                            .font(.custom("SFProRounded-Light", size: 22) )
//                            .lineLimit(2)
//                            .padding(.trailing)
//                            .foregroundColor(Color("Color-red"))
//                            .frame(width: 100, height: 70)
//                        Spacer()
//                    }
//
//                }
//                .frame(width: UIScreen.screenWidth - 40, height: 120)
//                .background(Color("Color-yellow"))
//                .cornerRadius(20)
//                .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
//                .padding(.bottom)
//            }
            HStack{
                Spacer()
                    .frame(width:20)
                TextField("Add comments for the restaurant", text: $comment)
                    .foregroundColor(Color.black)
                    .font(.custom("SFProRounded-Regular", size: 18) )
                    .lineLimit(1)
                Spacer()
            }
                .frame(width:UIScreen.screenWidth - 40, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("Color-red"), lineWidth: 3)
                )
            Text("Let the restaurant know if you have allergies, dietary limitation, special requests etc.")
               // .frame(height:26)
                .font(.custom("SFProRounded-Light", size: 15) )
                .frame(width:UIScreen.screenWidth - 60)
            Spacer()
                .frame(height:20)
//            HStack{
//                Spacer()
//                    .frame(width:20)
//                Text("Recommended for you")
//                    .font(.custom("SFProRounded-Regular", size: 23) )
//                    .lineLimit(1)
//                    .foregroundColor(Color("Color-red"))
//                Spacer()
//            }
//
//            ScrollView(.horizontal) {
//                HStack(spacing: 20) {
//                    Spacer()
//                        .frame(width:0)
//                    ForEach(0..<10) {number in
//                        ZStack{
//                            Image("Image-2")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .clipped()
//                            Text("4.55 M")
//                                //.frame(width: 50, height: 10, alignment: .leading)
//                                .padding(10)
//                                .foregroundColor(Color("Color-red"))
//                                .font(.custom("SFProRounded-Regular", size: 15) )
//                                .lineLimit(1)
//                                .background(Color("Color-white"))
//                                .cornerRadius(30)
//                                .position(x: 100, y: 100)
////                                .padding(.bottom,160)
////                                .padding(.leading,UIScreen.screenWidth/2)
//
//
//                            HStack{
//                                Spacer()
//                                    .frame(width:10)
//                                VStack(spacing:5){
//                                    HStack{
//                                        Text("Roman breeze")
//                                            .font(.custom("SFProRounded-Regular", size: 20) )
//                                            .lineLimit(1)
//                                            .padding(.top, 10)
//                                            .foregroundColor(Color("Color-red"))
//                                        Spacer()
//                                    }
//
//                                    HStack{
//                                        Text("450 g.")
//                                           // .frame(height:26)
//                                            .font(.custom("SFProRounded-Light", size: 15) )
//                                            .lineLimit(1)
//                                            //.padding(.horizontal)
//
//                                        Image("Icon-fire")
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(width: 15, height: 20)
//
//                                        Spacer()
//                                    }
//                                    Spacer()
//
//                                }
//
//                                HStack{
//                                    HStack{
//                                        Text("Add")
//                                            .foregroundColor(Color("Color-white"))
//                                            .font(.custom("SFProRounded-Light", size: 20) )
//                                            .lineLimit(1)
//                                            //.position(x: 110, y: 40)
//                                            //.padding(.bottom,160)
//                                        Spacer()
//                                        Text("+")
//                                            .font(.custom("SFProRounded-Light", size: 25) )
//                                            .lineLimit(1)
//                                            .foregroundColor(Color("Color-white"))
//                                            //.position(x: 110, y: 40)
//                                            //.padding(.top,10)
//                                    }
//                                    .padding()
//                                    .background(Color("Color-red"))
//                                    .frame(width: 90, height: 40, alignment: .trailing)
//                                    .cornerRadius(30)
//
//                                    Spacer()
//                                        .frame(width:10)
//                                }
//
//                            }
//
//                            .frame(width:UIScreen.screenWidth*0.6, height: 70, alignment: .top)
//                            .background(Color("Color-white"))
//                            .cornerRadius(20)
//                            .position(x: 130, y: 180)
//                        }
//                        .frame(width: UIScreen.screenWidth*0.6, height: 180)
//                        .background(Color("Color-white"))
//                            .cornerRadius(20)
//                            .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
//                    }
//
//                }
//                .frame(width: 1050, height: 200, alignment: .topLeading)
//            }
            Text(" ")
                .frame(
                  minWidth: 0,
                  maxWidth: UIScreen.screenWidth - 20,
                  minHeight: 0,
                  maxHeight: 1,
                  alignment: .leading
                )
                .background(Color("Color-red"))
            Spacer()
                .frame(height:20)
                    Button {
                        if !comment.isEmpty{
                            UserDefaults.standard.set(comment, forKey: "UserComment")
                        }
                        else{
                            UserDefaults.standard.set("", forKey: "UserComment")

                        }
                        withAnimation{
                            goToConfirmation.toggle()
                        }
                    } label: {
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
                    }
                    .fullScreenCover(isPresented: $goToConfirmation, content: {
                        OrderConfirmationView()
                    })
                    Spacer()
                        .frame(height:30)
        }
                
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
            .background(Color("Color-white"))

    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 13 Pro Max")
    }
}
