//
//  CheckboxListView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 01.06.22.
//

import SwiftUI
public struct ListItem: Identifiable {
    public let id: Int
    let name: String
    let amount: String
    let cost: Int
    var isChecked: Bool
}
struct CheckboxListView: View {
    @Binding var showCheckbox: Bool
    @Binding var items : [ListItem]
    var header: String
    var height: CGFloat
    var body: some View {
            ZStack{
                VStack (spacing:0){
                    HStack{
                        Spacer()
                            .frame(width: 10)
                        Text(header)
                            .font(.custom("SFProRounded-Light", size: 23) )
                            .foregroundColor(Color("Color-red"))

                        Spacer()
//                        Button(action: {
//                            withAnimation{
//                                for var i in items{
//                                    
//                                }
//                            }
//                            
//                        }, label: {
//                            Text("Clear all")
//                                .font(.custom("SFProRounded-Light", size: 15) )
//                                .foregroundColor(Color("Color-red"))
//                        })
//                        
//                        Spacer()
//                            .frame(width: 10)
                    }
                    .frame(width:UIScreen.screenWidth - 20, height: 60)
                    .background(Color("Color-white"))

                    List($items){ $item in
                        ItemCellView(item: $item)
                        .listRowSeparator(.hidden)
                    }
                    .frame(width: UIScreen.screenWidth - 20)
                    .listStyle(.inset)
                    .background(Color("Color-white"))
                    Spacer()
                        .frame(height:10)
                    HStack{
                        Spacer()
                            .frame(width:60)
                        Button(action: {
                            withAnimation{
                                showCheckbox.toggle()

                            }
                        }, label: {

                                
                                Text("Save")
                                   // .frame(height:26)
                                    .font(.custom("SFProRounded-Light", size: 21) )
                                    
                                    .lineLimit(1)
                                    .frame(width:UIScreen.screenWidth*2/5, height: 40)
                                    .background(Color("Color-red"))
                                    .foregroundColor(Color("Color-white"))
                                    .cornerRadius(30)
                                
                            }
                        )
                        Spacer()
                            .frame(width:60)
                    }
                    Spacer()
                        .frame(height:10)
                }
                .frame(width:UIScreen.screenWidth - 20, height: height)
                .background(Color("Color-white"))
                .cornerRadius(20)

            }
            

        

    }
}
//
//struct CheckboxListView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        CheckboxListView()
//    }
//}

struct ItemCellView: View {
    @Binding var item: ListItem
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                    .frame(width: 0)
                Text(item.name)
                    .font(.custom("SFProRounded-Light", size: 21) )
                Spacer()

                Image(item.isChecked ? "Icon-check" : "Icon-square")
                    .resizable()
                    .scaledToFit()
                    .frame(width:30,height: 30)
                    .onTapGesture {
                        withAnimation{
                            item.isChecked.toggle()
                            var itemsCost = UserDefaults.standard.integer(forKey: "SelectedMealItemsCost")
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
                            if item.isChecked{
                                itemsCost += item.cost
                                itemIDs.append(item.id)
                                let encoded = try? JSONEncoder().encode(itemIDs)
                                UserDefaults.standard.set(encoded, forKey: "SelectedItemIDs")
                                itemCosts.append(item.cost)
                                let encoded2 = try? JSONEncoder().encode(itemCosts)
                                UserDefaults.standard.set(encoded2, forKey: "SelectedItemCosts")
                                UserDefaults.standard.set(itemsCost, forKey: "SelectedMealItemsCost")
                            }
                            else{
                                itemsCost -= item.cost
                                let index = itemIDs.firstIndex(of: item.id)
                                itemIDs.remove(at: index!)
                                itemCosts.remove(at: index!)
                                if(itemIDs.count > 0){
                                    let encoded = try? JSONEncoder().encode(itemIDs)
                                    UserDefaults.standard.set(encoded, forKey: "SelectedItemIDs")
                                    let encoded2 = try? JSONEncoder().encode(itemCosts)
                                    UserDefaults.standard.set(encoded2, forKey: "SelectedItemCosts")

                                }
                                else{
                                    UserDefaults.standard.set("", forKey: "SelectedItemCosts")
                                    UserDefaults.standard.set("", forKey: "SelectedItemIDs")

                                }
                                UserDefaults.standard.set(itemsCost, forKey: "SelectedMealItemsCost")

                            }
                        }
                    }
                Spacer()
                    .frame(width: 0)
            }
            HStack{
                Spacer()
                    .frame(width: 0)
                Text(item.amount)
                    .font(.custom("SFProRounded-Light", size: 14) )
                Spacer()

                Text(String(Double(item.cost)/100) + " ₼")
                    .font(.custom("SFProRounded-Light", size: 14) )

                Spacer()
                    .frame(width: 0)
            }
            HStack{
                Spacer()
                    .frame(width: 0)
                Text(" ")
                    .frame(
                        minWidth: 0,
                        maxWidth: UIScreen.screenWidth - 20,
                        minHeight: 0,
                        maxHeight: 1,
                        alignment: .leading
                    )
                    .background(Color("Color-gray"))
                Spacer()
                    .frame(width: 0)
                
            }

        }

    }
}
