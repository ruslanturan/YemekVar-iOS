//
//  AddressView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 12.05.22.
//

import SwiftUI

@available(iOS 15.0, *)
struct AddressesView: View {
    @State private var showSheet = true
    @Environment(\.dismiss) var dismiss
    @State var showAlert = false
    @State var goToNew = false
    @State var goToEdit = false
    @State var isLoading = false
    @State var selected = 0
    @State var closeApp = false
    @State var message = ""
    @State var addresses: [NSDictionary] = []
    @State var refresh: Bool = false

    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
                if refresh || !refresh{
                VStack {
        //             Spacer()
                    VStack {
                        Spacer()
                            .frame(height:20)
                        HStack{
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
                            }
                            Spacer()
                                .frame(width:10)
                        }
                        HStack{
                            Spacer()
                                .frame(width:30)
                            Text("Location")
                                .font(.custom("SFProRounded-Regular", size: 26) )
                                .lineLimit(1)
                                .foregroundColor(Color.white)
                            if UserDefaults.standard.string(forKey: "selectedAddressID") != ""{
                                Button(action: {
                                    withAnimation{
                                        goToEdit.toggle()
                                    }
                                }, label: {
                                    HStack{
                                        Image("Icon-location")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 31, height: 31)
                                        Text("Change address")
                                            .font(.custom("SFProRounded-Regular", size: 16) )
                                            .foregroundColor(Color("Color-yellow"))
                                            .padding(.top, 10)
                                            .lineLimit(1)
                                    }
                                })
                                .fullScreenCover(isPresented: $goToEdit, content: {
                                    EditAddressView()
                                })
                            }

                            Spacer()
                        }
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                Spacer()
                                    .frame(width:0)
                                ForEach(addresses, id:\.self) {address in
                                    Group{
                                        if UserDefaults.standard.integer(forKey: "selectedAddressID") == address["ID"] as! Int {
                                            Button(action: {
                                                
                                            }, label: {
                                                VStack(spacing: 5){

                                                    Text(address["Name"] as! String)
                                                        .font(.custom("SFProRounded-Light", size: 21) )
                                                        .lineLimit(1)
                                                        .foregroundColor(Color("Color-red"))
                                                        .padding()
                                                        .background(Color("Color-yellow"))
                                                        .frame(height:40)
                                                        .cornerRadius(20)
                                                    
                                                }
                                            })

                                        }
                                        else{
                                            Button(action: {
                                                withAnimation{
                                                    UserDefaults.standard.set(address["ID"] as! Int, forKey: "selectedAddressID")
                                                    UserDefaults.standard.set(address["Street"] as! String, forKey: "selectedStreet")
                                                    UserDefaults.standard.set(address["Latitude"] as! String, forKey: "selectedLatitude")
                                                    UserDefaults.standard.set(address["Longtitude"] as! String, forKey: "selectedLongitude")
                                                    UserDefaults.standard.set(address["Additional_Info"] as? String ?? "", forKey: "selectedAddressInfo")
                                                    UserDefaults.standard.set(address["Name"] as! String, forKey: "selectedAddressName")
                                                    refresh.toggle()
                                                }
                                                
                                            }, label: {
                                                VStack(spacing: 5){

                                                    Text(address["Name"] as! String)
                                                        .font(.custom("SFProRounded-Light", size: 21) )
                                                        .lineLimit(1)
                                                        .foregroundColor(Color("Color-black"))
                                                        .padding()
                                                        .background(Color("Color-white"))
                                                        .frame(height:40)
                                                        .cornerRadius(20)
                                                   
                                                }
                                            })
                                            
                                        }
                                    }
                                }
                            }
                            Spacer()
                                .frame(width:30)
                        }
                        .frame(height: 40, alignment: .leading)

                        Spacer()
                            .frame(height:20)
                    }
                    .background(Color("Color-red"))
           //          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
           //          .padding()
                    Spacer()
                        .frame(height:20)
                    HStack{
                        Spacer()
                            .frame(width:30)
                        if UserDefaults.standard.integer(forKey: "selectedAddressID") != 0{
                            ForEach(addresses, id:\.self){ address in
                                if address["ID"] as! Int == UserDefaults.standard.integer(forKey: "selectedAddressID"){
                                    Text(address["Street"] as! String)
                                        .lineLimit(1)
                                        .font(.custom("SFProRounded-Regular", size: 18) )
                                }
                            }
                            
                        }
                        else{
                            Text(UserDefaults.standard.string(forKey: "loggedAddress") ?? "")
                                .lineLimit(1)
                                .font(.custom("SFProRounded-Regular", size: 18) )
                            
                        }
                        Spacer()
                    }
                    Spacer()
                        .frame(height:40)
                    Button(action: {
                        withAnimation{
                            goToNew.toggle()
                        }
                    }, label: {
                        HStack{
                            Spacer()
                                .frame(width:30)
                            Image("Icon-plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                            Text("Add new address")
                                .font(.custom("SFProRounded-Regular", size: 23) )
                                .foregroundColor(Color("Color-red"))
                                .lineLimit(1)
                            Spacer()
                        }
                    })
                    .fullScreenCover(isPresented: $goToNew, content: {
                        NewAddressView()
                    })
                    Spacer()
        //                 .frame(height:80)

                }
                .frame(width: UIScreen.screenWidth, height: 400)
                .background(Color("Color-white"))
                .cornerRadius(30)
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
            .task({
                await loadData()
            })
            
        }
        
    }
    func loadData() async{
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/user/addresses") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["userID": loggedID]
//        let body: [String: String] = ["reservID": "1"]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? [NSDictionary]
                    addresses = json!
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

@available(iOS 15.0, *)
struct AddressesView_Previews: PreviewProvider {
    static var previews: some View {
        AddressesView()
    }
}
