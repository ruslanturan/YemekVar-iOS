//
//  ProfileView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 28.04.22.
//

import SwiftUI

struct ProfileView: View {
    @State var isLoading = false
    @State var showAlert = false
    @State var closeApp = false
    @State var message = ""
    @State var name = ""
    @State var email = ""
    @State var number = 0
    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
            ScrollView{
                Spacer()
                    .frame(height:30)
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

                        })

                        Text("Profile")
                           // .frame(height:26)
                            .font(.custom("SFProRounded-Light", size: 23) )
                        Spacer()
                    }
                    HStack{
                        Spacer()
                            .frame(width:20)
                        Image("Icon-user")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .center)
                            .background(Color("Color-white"))
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color("Color-yellow"), lineWidth: 2.5))
                            .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 10)
                        VStack{
                            HStack{
                                Text(name)
                                    .font(.custom("SFProRounded-Regular", size: 30) )
                                    .lineLimit(1)
                                    .foregroundColor(Color("Color-red"))
                                Spacer()
                            }
                            HStack{
                                Text(verbatim: email )
                                    .font(.custom("SFProRounded-Regular", size: 20) )
                                    .lineLimit(1)
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                        }
                    }
                    VStack{
                        Spacer()
                            .frame(height:40)
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Text(verbatim:"Phone number")
                                .font(.custom("SFProRounded-Regular", size: 18) )
                                .lineLimit(1)
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Text(verbatim: "+994 " + String(number))
                                .font(.custom("SFProRounded-Regular", size: 23) )
                                .lineLimit(1)
        //                        .foregroundColor(Color.gray)
                            Spacer()
                            
                        }
                        Spacer()
                            .frame(height:20)
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Text(verbatim:"Personal name")
                                .font(.custom("SFProRounded-Regular", size: 18) )
                                .lineLimit(1)
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        HStack{
                            Spacer()
                                .frame(width:20)
                            Text(verbatim: name)
                                .font(.custom("SFProRounded-Regular", size: 23) )
                                .lineLimit(1)
        //                        .foregroundColor(Color.gray)
                            Spacer()
                        }
                        Spacer()
                            .frame(height:20)
//                        HStack{
//                            Spacer()
//                                .frame(width:20)
//                            Text(verbatim:"Client rating")
//                                .font(.custom("SFProRounded-Regular", size: 18) )
//                                .lineLimit(1)
//                                .foregroundColor(Color.gray)
//                            Spacer()
//                        }
//                        HStack{
//                            Spacer()
//                                .frame(width:20)
//                            Text(verbatim:"5.0")
//                                .font(.custom("SFProRounded-Regular", size: 23) )
//                                .lineLimit(1)
//        //                        .foregroundColor(Color.gray)
//                            Spacer()
//                            Image("Icon-info")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width:20,height:20)
//                            Spacer()
//                                .frame(width:20)
//                        }
                        
                    }
//                    Spacer()
//                        .frame(height:20)
//                    HStack{
//                        Spacer()
//                            .frame(width:20)
//                        Text(verbatim:"Current promotion")
//                            .font(.custom("SFProRounded-Regular", size: 18) )
//                            .lineLimit(1)
//                            .foregroundColor(Color.gray)
//                        Spacer()
//                    }
//                    HStack{
//                        Spacer()
//                            .frame(width:20)
//                        Text(verbatim:"10%")
//                            .font(.custom("SFProRounded-Regular", size: 21) )
//                            .lineLimit(1)
//                            .padding(.horizontal,10)
//                            .padding(.vertical,3)
//                            .background(Color("Color-yellow"))
//                            .cornerRadius(20)
//    //                        .foregroundColor(Color.gray)
//                        Spacer()
//                    }
//
                    
                }
                .task({
                    await loadData()
                })
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

        }
        .foregroundColor(Color("Color-black"))
    }
    func loadData() async{
        withAnimation{
            isLoading.toggle()
        }
        guard let url = URL(string: "https://yemekvar.az/api/user/profile") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: String] = ["userID": loggedID]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
            let str = String(decoding: data, as: UTF8.self)
                if !(str.lowercased().contains("error")){
                    let json = try ((JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as? NSDictionary)!)
                    name = json["Name"] as! String
                    email = json["Email"] as? String ?? "no saved e-mail"
                    number = json["Number"] as! Int
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
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .previewDevice("iPhone 13 Pro Max")
    }
}
