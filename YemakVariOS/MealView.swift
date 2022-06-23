//
//  MealView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 26.04.22.
//

import SwiftUI
public struct BasketItem: Identifiable, Encodable, Decodable, Equatable, Hashable {
    public let id: Int
    let name: String
    let photoUrl: String
    var count: Int
    var cost: Int
    let itemIDs: [Int]
    let itemCosts: [Int]
//    init(id: Int, name: String, photoUrl: String, count: Int, cost: Int, itemIDs:[Int], itemCosts: [Int]){
//        self.id = id
//        self.name = name
//        self.photoUrl = photoUrl
//        self.count = count
//        self.cost = cost
//        self.itemIDs = itemIDs
//        self.itemCosts = itemCosts
//    }
}
struct MealView: View {
    var id: Int
    
     public init (id: Int) {
         self.id = id
     }
    
    @Environment(\.dismiss) var dismiss
    @State var isLoading = false
    @State var showAlert = false
    @State var showCheckBox = false
    @State var closeApp = false
    @State var message = ""
    @State var header = "Additionally"
    @State var height : CGFloat = CGFloat(0)
    @State var receipt: String = ""
    @State var photoUrl: String = ""
    @State var name: String = ""
    @State var weight: Int = 0
    @State var cost: Int = 0
    @State var items: [NSDictionary] = []
    @State var listItems: [ListItem] = []
    @State var itemsName: [String] = [""]
    @State var selection = 0
    @State var count = 1
    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""

    var body: some View {
        LoadingView(isShowing: $isLoading) {

            ZStack{
                VStack{
                    Spacer()
                        .frame(height:20)
                    ZStack{
                        AsyncImage(url: URL(string: "https://yemekvar.az/images/Meal-Images/" + photoUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)){ image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)


                        } placeholder: {
                            
                        }
                        
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth, alignment: .center)

                            .cornerRadius(30)
                        HStack{
//                            Spacer()
//                                .frame(width:20)
//                            Button {
//
//                            } label: {
//                                Image("Icon-share")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20, height: 20)
//                                    .padding(10)
//                                    .background(Color("Color-white"))
//                                    .cornerRadius(30)
//                                    .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 3)
//                            }
//                            .padding(.bottom, UIScreen.screenWidth/2 + 80)

                            Spacer()
                            Button {
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
        //                            .padding(.leading, UIScreen.screenWidth/2)
                            }
                            .padding(.bottom, UIScreen.screenWidth/2 + 80)

                            Spacer()
                                .frame(width:20)
                        }
                        

                        
                        
                    }
                    .background(Color("Color-white"))
                    .cornerRadius(30)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth - 40, alignment: .center)

                    ScrollView{
                        Spacer()
                            .frame(height:20)
                        VStack{
                            HStack{
                                Spacer()
                                    .frame(width:20)
                                Text(name)
                                    .font(.custom("SFProRounded-Regular", size: 25))
                                    .lineLimit(1)
                                    .foregroundColor(Color("Color-red"))
                                Spacer()
                            }
                            HStack{
                
                                Spacer()
                                    .frame(width:20)
                                Text(String(weight) + " g.")
                                   // .frame(height:26)
                                    .font(.custom("SFProRounded-Regular", size: 23) )
                                    .lineLimit(1)
                                    //.padding(.horizontal)
                                Image("Icon-fire")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 25)
                                Spacer()

                            }
                            Text(receipt)
                               // .frame(height:26)
                                .font(.custom("SFProRounded-Light", size: 15) )
                                .frame(width: UIScreen.screenWidth - 40)
                            if items.count > 0{
                            Button(action: {
                                withAnimation{
                                    showCheckBox.toggle()
                                }
                            }, label: {
                                HStack{
                                    Spacer()
                                        .frame(width: 20)
                                    Text(header)
                                        .font(.custom("SFProRounded-Light", size: 18) )
                                        .foregroundColor(Color("Color-red"))
                                    Spacer()
                                    Image("Icon-down-red")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 10, height: 10)
                                    Spacer()
                                        .frame(width: 20)
                                }
                                    .frame(width:UIScreen.screenWidth - 40, height: 40)
                                    .background(Color.white)
                                    .cornerRadius(30)
                                    .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 9)
                            })
                            
                            Spacer()
                                .frame(height:30)
                            }
                            VStack{
                                HStack{
                                    Spacer()
                                    HStack{
                                        Button(action: {
                                            withAnimation{
                                            if count > 1 {
                                                count -= 1
                                            }
                                            }
                                        }, label: {
                                            Text("-")
                                                .font(.custom("SFProRounded-Light", size: 40) )
                                                .lineLimit(1)
                                                //.position(x: 110, y: 40)
                                                .padding(.bottom,10)
                                                .foregroundColor(Color("Color-white"))
                                        })
                                        
                                        Spacer()
                                        Text(String(count))
                                            .foregroundColor(Color("Color-red"))
                                            .font(.custom("SFProRounded-light", size: 25) )
                                            .lineLimit(1)
                                            //.position(x: 110, y: 40)
                                            //.padding(.bottom,160)
                                        Spacer()
                                        Button(action: {
                                            withAnimation{
                                            if count < 9 {
                                                count += 1
                                            }
                                            }
                                        }, label: {
                                            Text("+")
                                                .font(.custom("SFProRounded-Light", size: 40) )
                                                .lineLimit(1)
                                                //.position(x: 110, y: 40)
                                                .padding(.bottom,10)
                                                .foregroundColor(Color("Color-white"))
                                        })
                                        
                                    }
                                    .padding()
                                    .background(Color("Color-yellow"))
                                    .frame(width: 120, height: 40, alignment: .trailing)
                                    .cornerRadius(30)
                                    .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                                    Spacer()
                                        .frame(width:30)
                                }
                                if loggedID != ""{
                                Button(action: {
                                    let data = UserDefaults.standard.data(forKey: "Basket")
                                    var basketItems: [BasketItem] = []

                                    if data != nil{
                                        let decoded = try? JSONDecoder().decode([BasketItem].self, from: data!)
                                        basketItems = decoded!

                                    }
                                    let IDdata = UserDefaults.standard.data(forKey: "SelectedItemIDs")
                                    let Costdata = UserDefaults.standard.data(forKey: "SelectedItemCosts")
                                    var itemIDs: [Int] = []
                                    var itemCosts: [Int] = []
                                    if IDdata != nil{
                                        let decoded = try? JSONDecoder().decode([Int].self, from: IDdata!)
                                        itemIDs = decoded!

                                    }
                                    if Costdata != nil{
                                        let decoded = try? JSONDecoder().decode([Int].self, from: Costdata!)
                                        itemCosts = decoded!

                                    }
                                    let meal = BasketItem(id: id, name: name, photoUrl: photoUrl, count: count, cost: (cost + UserDefaults.standard.integer(forKey: "SelectedMealItemsCost"))*count, itemIDs: itemIDs, itemCosts: itemCosts)
                                    basketItems.append(meal)
                                    var cost = 0
                                    for item in basketItems{
                                        cost += item.cost
                                    }
                                    UserDefaults.standard.set(cost, forKey: "AllCost")
                                    let encoded = try? JSONEncoder().encode(basketItems)
                                    UserDefaults.standard.set(encoded, forKey: "Basket")
                                    withAnimation{
                                        dismiss()
                                    }
                                }, label: {
                                    HStack{
                                        Text("Add to Cart")
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
                                        Spacer()
                                        
                                        Text(String(Double(cost + UserDefaults.standard.integer(forKey: "SelectedMealItemsCost"))*Double(count)/100) + " ₼")
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
                                }
                            }
                            Spacer()
                                .frame(height:30)




                        }
                        .background(Color("Color-white"))
                    }
                    .background(Color("Color-white"))
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
                if showCheckBox {
                    VStack{
                        VStack{
                            CheckboxListView(showCheckbox: $showCheckBox, items: $listItems, header: header, height: height)
                        }
                            .frame(width: UIScreen.screenWidth - 20, height: height)
                    }
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                        .background(Color.black.opacity(0.8))
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
        guard let url = URL(string: "https://yemekvar.az/api/delivery/meal") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["mealID": String(id)]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [String: Any]
                    receipt = json!["Receipt"] as? String ?? ""
                    photoUrl = json!["PhotoURL"] as! String
                    name = json!["Name"] as! String
                    cost = json!["CostInPenny"] as! Int
                    weight = json!["WeightInGram"] as? Int ?? 450
                    items = json!["items"] as! [NSDictionary]
                    for i in items{
                        listItems.append(ListItem(id: i["ID"] as! Int, name: i["Name"] as! String, amount: i["Amount"] as! String, cost: i["CostInPenny"] as! Int, isChecked: false))
                    }
                    for item in items {
                        itemsName.append(item["Name"] as! String)
                    }
                    height = UIScreen.screenHeight - 150
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

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        let id = 0

        MealView(id: id)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 13 Pro Max")
    }
}
