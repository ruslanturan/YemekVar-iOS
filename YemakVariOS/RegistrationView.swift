//
//  RegistrationView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 06.05.22.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name: String = ""
    @State private var pass: String = ""
    @State private var confirmPass: String = ""
    @State var goToHome = false
    @State var isLoading = false
    @State var showAlert = false
    @State var closeApp = false
    @State var message = ""
    @State private var number = UserDefaults.standard.string(forKey: "number") ?? "number"
    @State private var prefix = UserDefaults.standard.string(forKey: "prefix") ?? "prefix"
    @FocusState private var focusedField: Field?
    enum Field: Int, Hashable {
        case name
        case pass
        case confirmPass
    }
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
                ScrollView{
                    VStack{
                        Spacer()
                            .frame(height:50)
                        HStack{
                            Spacer()
                            Button(action: {
                                UserDefaults.standard.set("", forKey: "loggedID")
                                withAnimation{
                                    goToHome.toggle()
                                }
                            }, label: {
                                HStack{
                                    Text("Skip")
                                        .foregroundColor(Color("Color-red"))
                                        .font(.custom("SFProRounded-Regular", size: 20) )
                                    Image("Icon-skip")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 15)
                                    
                                }
                                .padding(.horizontal)
                                .padding(.vertical,8)
                                .lineLimit(1)
                                .background(Color("Color-white"))
                                .cornerRadius(30)
                                .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                            })
                            .fullScreenCover(isPresented: $goToHome, content: {
                                TabBar()
                                    .edgesIgnoringSafeArea(.all)

                            })
                            Spacer()
                                .frame(width:20)
                        }
                        HStack{
                            Spacer()
                                .frame(width:30)
                            Text("Your name and surname")
                                .font(.custom("SFProRounded-Regular", size: 21))
                            Spacer()
                        }
                        HStack{
                            Spacer()
                                .frame(width:20)
                            TextField("Name", text: $name)
                                .foregroundColor(Color.black)
                                .font(.custom("SFProRounded-Regular", size: 18) )
                                .lineLimit(1)
                                .focused($focusedField, equals: .name)
                                .onSubmit {
                                    self.focusNextField($focusedField)
                                }
                            Spacer()
                        }
                            .background(Color("Color-white"))
                            .frame(width:UIScreen.screenWidth - 40, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("Color-red"), lineWidth: 3)
                            )

                    }
                    VStack{
                        HStack{
                            Spacer()
                                .frame(width:30)
                            Text("Password")
                                .font(.custom("SFProRounded-Regular", size: 21))
                            Spacer()
                        }
                        HStack{
                            Spacer()
                                .frame(width:20)
                            SecureField("Password", text: $pass)
                                .foregroundColor(Color.black)
                                .font(.custom("SFProRounded-Regular", size: 18) )
                                .lineLimit(1)
                                .focused($focusedField, equals: .pass)
                                .onSubmit {
                                    self.focusNextField($focusedField)
                                }
                            Spacer()
                        }
                            .background(Color("Color-white"))
                            .frame(width:UIScreen.screenWidth - 40, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("Color-red"), lineWidth: 3)
                            )
                        HStack{
                            Spacer()
                                .frame(width:30)
                            Text("Repeat password")
                                .font(.custom("SFProRounded-Regular", size: 21))
                            Spacer()
                        }
                        HStack{
                            Spacer()
                                .frame(width:20)
                            SecureField("Repeat password", text: $confirmPass)
                                .foregroundColor(Color.black)
                                .font(.custom("SFProRounded-Regular", size: 18) )
                                .lineLimit(1)
                                .focused($focusedField, equals: .confirmPass)
                            Spacer()
                        }
                            .background(Color("Color-white"))
                            .frame(width:UIScreen.screenWidth - 40, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("Color-red"), lineWidth: 3)
                            )
                        Spacer()
                            .frame(height:90)
                        Button(action: {
                            if name.isEmpty{
                                message = "Please enter your name"
                                withAnimation{
                                    showAlert.toggle()
                                }
                            }
                            else if pass.isEmpty{
                                message = "Please enter a password"
                                withAnimation{
                                    showAlert.toggle()
                                }
                            }
                            else if confirmPass.isEmpty{
                                message = "Please repeat your password"
                                withAnimation{
                                    showAlert.toggle()
                                }
                            }
                            else if pass != confirmPass{
                                message = "Passwords don't match"
                                withAnimation{
                                    showAlert.toggle()
                                }
                            }
                            else{
                                withAnimation{
                                    isLoading.toggle()
                                }
                                guard let url = URL(string: "https://yemekvar.az/api/user/register") else {
                                    return
                                }
                                var request = URLRequest(url: url)
                                request.httpMethod = "POST"
                                let body: [String: String] = ["number": number, "prefix": prefix, "pass": pass, "name": name]
                                let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                request.httpBody = finalBody
                                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                URLSession.shared.dataTask(with: request) { (data, response, error) in
                                    guard let data = data else { return }
    //                                do{
                                    let str = String(decoding: data, as: UTF8.self)

    //                                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as

                                    if str.contains("ID:"){
                                        withAnimation{
                                            isLoading.toggle()
                                        }
                                        let newStr = str.components(separatedBy:": ")[1]
                                        let loggedID = newStr.replacingOccurrences(of: "\"", with: "")
                                        UserDefaults.standard.set(loggedID, forKey: "loggedID")
                                        goToHome.toggle()
                                        
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
                            Text("Finish")
                                .font(.custom("SFProRounded-Light", size: 18) )
                                .foregroundColor(Color("Color-white"))
                                .lineLimit(1)
                            Spacer()
                        })
                        .padding()
                        .background(Color("Color-red"))
                        .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .trailing)
                        .cornerRadius(30)
                        Spacer()
                            .frame(height:150)
                    }
                }
                .background(Color("Color-white"))
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                }
                .ignoresSafeArea(.all)
                .frame(width:UIScreen.screenWidth, height: UIScreen.screenHeight)
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
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .preferredColorScheme(.dark)
    }
}
