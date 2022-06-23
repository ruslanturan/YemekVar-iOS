//
//  EditAddressView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 13.05.22.
//

import SwiftUI

struct EditAddressView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    UserDefaults.standard.set(address["ID"] as! Int, forKey: "selectedAddressID")
//    UserDefaults.standard.set(address["Street"] as! String, forKey: "selectedStreet")
//    UserDefaults.standard.set(address["Latitude"] as! String, forKey: "selectedLatitude")
//    UserDefaults.standard.set(address["Longtitude"] as! String, forKey: "selectedLongitude")
//    UserDefaults.standard.set(address["Additional_Info"] as! String, forKey: "selectedAddressInfo")
    @State private var street: String = UserDefaults.standard.string(forKey: "selectedStreet")!
    @State private var apartment: String = UserDefaults.standard.string(forKey: "selectedAddressInfo")!
    @State private var name: String = UserDefaults.standard.string(forKey: "selectedAddressName")!
    @State var isLoading = false
    @State var goToHome = false
    @State var addressFound = true
    @State var selected = 0
    @State var showAlert = false
    @State var textFieldIsDisabled = true
    @State var closeApp = false
    @State var message = ""
    @State var btnText = "Save"
    @State var lat = UserDefaults.standard.double(forKey: "selectedLatitude")
    @State var lng = UserDefaults.standard.double(forKey: "selectedLongitude")
    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
                VStack{
                    Button(action: {
                        withAnimation{
                            self.mode.wrappedValue.dismiss()
                        }
                    }, label: {
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Image("Icon-back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                                .cornerRadius(30)
                                .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                            Spacer()
                        }
                    })

                    ScrollView{
                        VStack{
                            VStack{
                               
                                HStack{
                                    Text("Edit address")
                                        .font(.custom("SFProRounded-Regular", size: 23) )
                                        .foregroundColor(Color("Color-red"))
                                        .lineLimit(1)
                                        .padding(.bottom)
                                }
                                HStack{
                                    Spacer()
                                        .frame(width:30)
                                    Text("Let’s start with your location")
                                        .font(.custom("SFProRounded-Regular", size: 21))
                                    Spacer()
                                }
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    TextField("Street", text: $street)
                                        .foregroundColor(Color.black)
                                        .font(.custom("SFProRounded-Regular", size: 18) )
                                        .lineLimit(1)
                                        .disabled(textFieldIsDisabled)

                                    Spacer()
                                }
                                    .frame(width:UIScreen.screenWidth - 40, height: 50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color("Color-red"), lineWidth: 3)
                                    )
                                Spacer()
                                    .frame(height:20)
                                if addressFound{
                                HStack{
                                    Spacer()
                                        .frame(width:20)
                                    TextField("Staircase/apartment/floor", text: $apartment)
                                        .font(.custom("SFProRounded-Regular", size: 18) )
                                        .lineLimit(1)
                                    Spacer()
                                }
                                    .frame(width:UIScreen.screenWidth - 40, height: 50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color("Color-red"), lineWidth: 3)
                                    )
                                }
                            }
                            
            //                HStack{
            //                    Text("Use a map to do this")
            //                        .font(.custom("SFProRounded-Light", size: 23) )
            //                        .lineLimit(1)
            //                        .foregroundColor(Color("Color-red"))
            //                    Image("Icon-right")
            //                        .resizable()
            //                        .scaledToFit()
            //                        .frame(width: 15, height: 20, alignment: .center)
            //                }
                            if addressFound{
                            HStack{
                                Spacer()
                                    .frame(width:30)
                                Text("Name this location")
                                    .font(.custom("SFProRounded-Regular", size: 21))
                                    .lineLimit(1)
                                    .padding(.top)
                                Spacer()
                            }
                            HStack{
                                Spacer()
                                    .frame(width:20)
                                TextField("Name", text: $name)
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
                            Spacer()
                                .frame(height:30)
                            }
                            Button(action: {
                                if btnText == "Check"{
                                    textFieldIsDisabled.toggle()
                                withAnimation{
                                    isLoading.toggle()
                                }
                                if street.isEmpty{
                                    message = "Please enter a valid address"
                                    withAnimation{
                                        showAlert.toggle()
                                        isLoading.toggle()
                                    }
                                }
                                else{
                                guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=" +  street.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=AIzaSyAMaA2mmR2cLAaIgqBiPSjgNv3HfpJylYI") else {
                                    return
                                }
                                var request = URLRequest(url: url)
                                request.httpMethod = "GET"
                                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                URLSession.shared.dataTask(with: request) { (data, response, error) in
                                    guard let data = data else { return }
                                    do{
                                    let str = String(decoding: data, as: UTF8.self)
                                        if !(str.lowercased().contains("error")){
                                            let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? NSDictionary
                                            
                                            withAnimation{
                                                let candidates = json!["candidates"] as? [NSDictionary]
                                                let geometry = candidates?.first!["geometry"] as? NSDictionary
                                                let location = geometry!["location"] as? NSDictionary
                                                 lat = location!["lat"] as! Double
                                                 lng = location!["lng"] as! Double
                                                street = candidates?.first!["name"] as! String
                                                btnText = "Save"
                                                addressFound.toggle()
                                                isLoading.toggle()
                                            }
                                        }
                                        else{
                                            message = "Address not found"

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
                                else{
                                    if apartment.isEmpty{
                                        message = "Please add apartment info"
                                        withAnimation{
                                            showAlert.toggle()
                                        }
                                        return
                                    }
                                    else if name.isEmpty{
                                        message = "Please add address name"
                                        withAnimation{
                                            showAlert.toggle()
                                        }
                                        return
                                    }
                                    withAnimation{
                                        isLoading.toggle()
                                    }
                                    guard let url = URL(string: "https://yemekvar.az/api/user/editaddress") else {
                                        return
                                    }
                                    var request = URLRequest(url: url)
                                    request.httpMethod = "POST"
                                    let body: [String: String] = ["id":UserDefaults.standard.string(forKey: "selectedAddressID")!,"userid": loggedID, "street": street, "name": name, "additional_info": apartment, "Latitude": String(lat), "Longtitude": String(lng)]
                                    let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                    request.httpBody = finalBody
                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                                        guard let data = data else { return }
    //                                do{
                                        let str = String(decoding: data, as: UTF8.self)

    //                                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as
                                        if str.lowercased().contains("ok"){
                                            message = "Address added"

                                            withAnimation{
                                                showAlert.toggle()
                                                isLoading.toggle()
                                                goToHome.toggle()
                                            }
                                            
                                        }
                                        else{
                                            message = "Error occured. Please try again later"

                                            withAnimation{
                                                showAlert.toggle()
                                                isLoading.toggle()
                                            }
                                        }
    //                                }
    //                                catch{
    //                                    print(error)
    //                                }
                                }.resume()
                                
                                }
                            }, label: {
                                Spacer()
                                Text(btnText)
                                    .font(.custom("SFProRounded-Light", size: 18) )
                                    .foregroundColor(Color("Color-white"))
                                    .lineLimit(1)
                                Spacer()
                            })
                            .padding()
                            .background(Color("Color-red"))
                            .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .trailing)
                            .cornerRadius(30)
                            .fullScreenCover(isPresented: $goToHome, content: {
                                TabBar()
                                    .edgesIgnoringSafeArea(.all)
                                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                            })
                            if addressFound {
                                Button(action: {
                                    withAnimation{
                                        textFieldIsDisabled.toggle()
                                        addressFound.toggle()
                                        street = ""
                                        btnText = "Check"
                                    }
                                }, label: {
                                    Spacer()
                                    Text("Change address")
                                        .font(.custom("SFProRounded-Light", size: 18) )
                                        .foregroundColor(Color("Color-white"))
                                        .lineLimit(1)
                                    Spacer()
                                })
                                .padding()
                                .background(Color("Color-red"))
                                .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .trailing)
                                .cornerRadius(30)
                            }
                            Spacer()
                                .frame(height:30)
                            
                        }
                    }
                }

        .background(Color("Color-white"))
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
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
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
}

struct NewAddressView_Previews: PreviewProvider {
    static var previews: some View {
        NewAddressView()
            .preferredColorScheme(.dark)
    }
}
