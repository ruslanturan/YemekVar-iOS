//
//  LoginView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 06.05.22.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var number: String = ""
    @State private var pass: String = ""
    @State private var showTextField = false
    @State var selected = 0
    @State var showAlert = false
    @State var closeApp = false
    @State var message = ""
    @State var textFieldIsDisabled = false
    @State var isLoading = false
    @State var goToHome = false
    @State var goToVerification = false

    @State private var btnText = "Continue"
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
                ScrollView{
                    VStack{
                        ZStack{
                            Image("Photo-login")
                                .resizable()
                                .scaledToFit()
                            ZStack{
                                Button(action: {
                                    UserDefaults.standard.set("", forKey: "loggedID")
                                    withAnimation{
                                        goToHome.toggle()
                                    }
                                }, label: {
                                        Text("Skip")
                                            .padding(.horizontal)
                                            .padding(.vertical,8)
                                            .foregroundColor(Color("Color-red"))
                                            .font(.custom("SFProRounded-Regular", size: 20) )
                                            .lineLimit(1)
                                            .padding(.trailing,40)
                                            .background(Color("Color-white"))
                                            .cornerRadius(30)
    //                                        .position(x: UIScreen.screenWidth - 70, y: 70)
                                            .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                                })
                                .fullScreenCover(isPresented: $goToHome, content: {
                                    TabBar()
                                        .edgesIgnoringSafeArea(.all)

                                })
                            }
                            .position(x: UIScreen.screenWidth - 70, y: 70)
                            ZStack{
                                Button(action: {
                                    UserDefaults.standard.set("", forKey: "loggedID")
                                    withAnimation{
                                        goToHome.toggle()
                                    }
                                }, label: {
                                        Image("Icon-skip")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 15)
    //                                        .position(x: UIScreen.screenWidth - 50, y: 71)
     
                                })
                                .fullScreenCover(isPresented: $goToHome, content: {
                                    TabBar()
                                        .edgesIgnoringSafeArea(.all)

                                })
                            }
                            .position(x: UIScreen.screenWidth - 50, y: 70)
                            
                            
                        }
                        HStack{
                            Spacer()
                                .frame(width:30)
                            Text("Enter your number")
                                .font(.custom("SFProRounded-Regular", size: 36) )
                                .foregroundColor(Color("Color-red"))
                            Spacer()
                        }
                        VStack{
                            HStack{
                                Spacer()
                                    .frame(width:30)
                                Text("We will send a code to verify your mobile number if you're not registered yet")
                                    .font(.custom("SFProRounded-Regular", size: 15) )
                                Spacer()
                                    .frame(width:90)
                            }
                            HStack{
                                PrefixPicker(images: ["Flag-russia","Flag-aze"], selected: $selected, options: ["+7", "+994"])
                                
                                TextField("Enter your number", text: $number)
                                    .foregroundColor(Color.black)
                                    .font(.custom("SFProRounded-Regular", size: 18) )
                                    .lineLimit(1)
                                    .keyboardType(.numberPad)
                                    .disabled(textFieldIsDisabled)



                                Spacer()
                            }
                                .background(Color("Color-white"))
                                .frame(width:UIScreen.screenWidth - 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("Color-red"), lineWidth: 3)
                                )
                                .padding(.top,30)
                        }
                        
                        if showTextField {
                            HStack{
                                Spacer()
                                    .frame(width:20)
                                
                                SecureField("Password", text: $pass)
                                    .foregroundColor(Color.black)
                                    .font(.custom("SFProRounded-Regular", size: 18) )
                                    .lineLimit(1)
                                Spacer()
                            }
                                .background(Color("Color-white"))
                                .frame(width:UIScreen.screenWidth - 40, height: 38)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("Color-red"), lineWidth: 3)
                                )
                                .padding(.top,30)
                        }
                        
                        Spacer()
                            .frame(height:40)
                        Button(action: {
                            var prefix = ""
                            if selected == 0 {
                                prefix = "7"
                            }
                            else{
                                prefix = "994"
                            }
                            if(btnText == "Continue"){
                                message = "Please enter a valid phone number"
                                

                                if selected == 0 {
                                    if number.count != 10 {
                                        withAnimation{
                                            showAlert.toggle()
                                            return
                                        }
                                    }
                                    else{
                                        withAnimation{
                                            isLoading.toggle()
                                        }
                                        guard let url = URL(string: "https://yemekvar.az/api/user/check") else {
                                            return
                                        }
                                        var request = URLRequest(url: url)
                                        request.httpMethod = "POST"
                                        let body: [String: String] = ["number": number, "prefix": prefix]
                                        let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                        request.httpBody = finalBody
                                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                        URLSession.shared.dataTask(with: request) { (data, response, error) in
                                            guard let data = data else { return }
        //                                do{
                                            let str = String(decoding: data, as: UTF8.self)

        //                                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as
                                            if str.contains("Exist"){
                                                withAnimation{
                                                    showTextField.toggle()
                                                    btnText = "Login"
                                                    textFieldIsDisabled.toggle()
                                                    isLoading.toggle()
                                                }
                                            }
                                            else if str.contains("Code:"){
                                                let newStr = str.components(separatedBy:": ")[1]
                                                let code = newStr.replacingOccurrences(of: "\"", with: "")
                                                UserDefaults.standard.set(code, forKey: "code")
                                                UserDefaults.standard.set(number, forKey: "number")
                                                UserDefaults.standard.set(prefix, forKey: "prefix")
                                                withAnimation{
                                                    isLoading.toggle()
                                                    goToVerification.toggle()
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
                                }
                                else{
                                    if number.count != 9 {
                                        withAnimation{
                                            showAlert.toggle()
                                            return
                                        }
                                    }
                                    else{
                                        withAnimation{
                                            isLoading.toggle()
                                        }
                                        guard let url = URL(string: "https://yemekvar.az/api/user/check") else {
                                            return
                                        }
                                        var request = URLRequest(url: url)
                                        request.httpMethod = "POST"
                                        let body: [String: String] = ["number": number, "prefix": prefix]
                                        let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                        request.httpBody = finalBody
                                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                        URLSession.shared.dataTask(with: request) { (data, response, error) in
                                            guard let data = data else { return }
        //                                do{
                                            let str = String(decoding: data, as: UTF8.self)

        //                                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as
                                            if str.contains("Exist"){
                                                withAnimation{
                                                    showTextField.toggle()
                                                    btnText = "Login"
                                                    textFieldIsDisabled.toggle()
                                                    isLoading.toggle()
                                                }
                                            }
                                            else if str.contains("Code:"){
                                                let newStr = str.components(separatedBy:": ")[1]
                                                let code = newStr.replacingOccurrences(of: "\"", with: "")
                                                UserDefaults.standard.set(code, forKey: "code")
                                                UserDefaults.standard.set(number, forKey: "number")
                                                UserDefaults.standard.set(prefix, forKey: "prefix")
                                                withAnimation{
                                                    isLoading.toggle()
                                                    goToVerification.toggle()
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
                                }
                            }
                            else{
                                if pass.isEmpty{
                                    message = "Password is empty"

                                    withAnimation{
                                        showAlert.toggle()
                                        return
                                    }
                                }
                                else{
                                    withAnimation{
                                        isLoading.toggle()
                                    }
                                    guard let url = URL(string: "https://yemekvar.az/api/user/login") else {
                                        return
                                    }
                                    var request = URLRequest(url: url)
                                    request.httpMethod = "POST"
                                    let body: [String: String] = ["number": number, "prefix": prefix, "pass": pass]
                                    let finalBody = try! JSONSerialization.data(withJSONObject: body)
                                    request.httpBody = finalBody
                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                                        guard let data = data else { return }
    //                                do{
                                        let str = String(decoding: data, as: UTF8.self)

    //                                    let json = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed]) as
                                        if str.contains("Incorrect credentials"){
                                            message = "Password is incorrect"

                                            withAnimation{
                                                showAlert.toggle()
                                                isLoading.toggle()
                                            }
                                            return
                                        }
                                        else if str.contains("ID:"){
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

                            }
                        }, label: {
                            Spacer()
                            Text(btnText)
                                .font(.custom("SFProRounded-Light", size: 18) )
                                .foregroundColor(Color("Color-white"))
                                .lineLimit(1)
                            Spacer()
                        })
                        .fullScreenCover(isPresented: $goToHome, content: {
                            DeliveryHomeView()
                            
                        })
                        .fullScreenCover(isPresented: $goToVerification, content: {
                            VerificationView()
                        })
                        .padding()
                        .background(Color("Color-red"))
                        .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .trailing)
                        .cornerRadius(30)
                        if showTextField {
                            Button(action: {
                                withAnimation{
                                    showTextField.toggle()
                                    textFieldIsDisabled.toggle()
                                    number = ""
                                    btnText = "Continue"
                                }
                            }, label: {
                                Spacer()
                                Text("Change number")
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
                            .frame(height:80)
                        HStack{
                            Spacer()
                            Text("By continuing, you agree to our")
                                .font(.custom("SFProRounded-Regular", size: 15))
                            Spacer()
                        }
                        HStack{
                           
                            Text("Terms of Service")
                                .font(.custom("SFProRounded-Regular", size: 15))
                                .underline()
                                .lineLimit(1)
                                .foregroundColor(Color.gray)
                            Text("Privacy Policy")
                                .font(.custom("SFProRounded-Regular", size: 15))
                                .underline()
                                .lineLimit(1)
                                .foregroundColor(Color.gray)
                            Text("Content Policies")
                                .font(.custom("SFProRounded-Regular", size: 15))
                                .underline()
                                .lineLimit(1)
                                .foregroundColor(Color.gray)

                        }
                    }
                    Spacer()
                        .frame(height:30)
                }
                    .ignoresSafeArea(.all)
                    .frame(width:UIScreen.screenWidth, height: UIScreen.screenHeight)
                    .background(Color("Color-white"))
                    .statusBar(hidden: true)
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
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iPhone 13 Pro Max")
//            .preferredColorScheme(.dark)
    }
}
