//
//  VerificationView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 06.05.22.
//

import SwiftUI

struct VerificationView: View {
    @State private var code1: String = ""
    @State private var code2: String = ""
    @State private var code3: String = ""
    @State private var code4: String = ""
    @State private var current: String = "1"
    @State private var code = UserDefaults.standard.string(forKey: "code") ?? "code"
    @State private var number = UserDefaults.standard.string(forKey: "number") ?? "number"
    @State private var prefix = UserDefaults.standard.string(forKey: "prefix") ?? "prefix"

    @State var goToLogin = false
    @State var goToRegistration = false
    @State var showResendBtn = false
    @State var timeRemaining = 30
    @State var isLoading = false
    @State var showAlert = false
    @State var closeApp = false
    @State var message = ""
    @FocusState private var focusedField: Field?
    enum Field: Int, Hashable {
        case code1
        case code2
        case code3
        case code4
    }
    let timer = Timer.publish(every: 0.9, on: .main, in: .common).autoconnect()
    var body: some View {
        LoadingView(isShowing: $isLoading) {
            ZStack{
                

                ScrollView{
                    VStack{
                        VStack{
                            HStack{
                                Spacer()
                                    .frame(width:30)
                                Text("Enter code")
                                    .font(.custom("SFProRounded-Regular", size: 36) )
                                    .foregroundColor(Color("Color-red"))
                                Spacer()
                            }
                            Spacer()
                                .frame(height:10)
                            HStack{
                                Spacer()
                                    .frame(width:30)
                                Text("An SMS code was sent to")
                                    .font(.custom("SFProRounded-Regular", size: 15) )
                                Spacer()
                            }
                            Spacer()
                                .frame(height:10)
                            HStack{
                                Spacer()
                                    .frame(width:30)
                                Text("+ " + prefix + " " + number)
                                    .font(.custom("SFProRounded-Regular", size: 18) )
                                Spacer()
                            }
                            HStack{
                                Spacer()
                                    .frame(width:30)
                                Button(action: {
                                    goToLogin.toggle()
                                }, label: {
                                    Text("Edit phone number")
                                        .font(.custom("SFProRounded-Regular", size: 15) )
                                        .foregroundColor(Color("Color-red"))
                                })
                                .fullScreenCover(isPresented: $goToLogin, content: {
                                    LoginView()
                                })
                                Spacer()
                            }
                            Spacer()
                                .frame(height:50)
                        }

                        HStack{
                            Spacer()
                                .frame(width:20)
                            TextField("1", text: $code1)
                                .foregroundColor(Color.black)
                                .font(.custom("SFProRounded-Regular", size: 36) )
                                .padding(15)
                                .lineLimit(1)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                            

                                .background(self.current != "1" ? Color("Color-gray") : .clear)
//                                .disabled(self.current != "1")
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(self.current == "1" ? Color("Color-red") : Color("Color-white"), lineWidth: self.current == "1" ? 3: 0)
                                )
                                .focused($focusedField, equals: .code1)

                                .onChange(of: code1) {
                                    if $0.count > 0 {
                                        code1 = String(code1.prefix(1))
                                        self.current = "2"
                                        self.focusNextField($focusedField)
                                    }
                                    else if $0.count == 0{
                                        self.current = "1"
                                        self.focusPreviousField($focusedField)
                                    }
                                }
                            TextField("2", text: $code2)
                                .foregroundColor(Color.black)
                                .font(.custom("SFProRounded-Regular", size: 36) )
                                .padding(15)
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .background(self.current != "2" ? Color("Color-gray") : .clear)
//                                .disabled(self.current != "2")
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(self.current == "2" ? Color("Color-red") : Color("Color-white"), lineWidth: 3)
                                )
                                .focused($focusedField, equals: .code2)
                                .onChange(of: code2) {
                                    if $0.count > 0 {
                                        code2 = String(code2.prefix(1))
                                        self.current = "3"
                                        self.focusNextField($focusedField)
                                    }
                                    else if $0.count == 0{
                                        self.current = "1"
                                        self.focusPreviousField($focusedField)
                                    }
                                }
                            TextField("3", text: $code3)
                                .foregroundColor(Color.black)
                                .font(.custom("SFProRounded-Regular", size: 36) )
                                .padding(15)
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .background(self.current != "3" ? Color("Color-gray") : .clear)
//                                .disabled(self.current != "3")
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(self.current == "3" ? Color("Color-red") : Color("Color-white"), lineWidth: 3)
                                )
                                .focused($focusedField, equals: .code3)

                                .onChange(of: code3) {
                                    if $0.count > 0 {
                                        code3 = String(code3.prefix(1))
                                        self.current = "4"
                                        self.focusNextField($focusedField)
                                    }
                                    else if $0.count == 0{
                                        self.current = "2"
                                        self.focusPreviousField($focusedField)
                                    }
                                }
                            TextField("4", text: $code4)
                                .foregroundColor(Color.black)
                                .font(.custom("SFProRounded-Regular", size: 36) )
                                .padding(15)
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .background(self.current != "4" ? Color("Color-gray") : .clear)
//                                .disabled(self.current != "4")
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(self.current == "4" ? Color("Color-red") : Color("Color-white"), lineWidth: 3)
                                )
                                .focused($focusedField, equals: .code4)
                                
                                .onChange(of: code4) {
                                    if $0.count > 0 {
                                        code1 = String(code1.prefix(1))
                                        self.current = "4"
                                        self.focusNextField($focusedField)
                                    }
                                    else if $0.count <= 0{
                                        self.current = "3"
                                        self.focusPreviousField($focusedField)
                                    }
                                }
                            Spacer()
                                .frame(width:20)
                        }
                        Spacer()
                            .frame(height:200)
                        if showResendBtn {
                            HStack{
                                Spacer()
                                    .frame(width:30)
                                Button(action: {
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

                                        if str.contains("Code:"){
                                            message = "New code sent"

                                            let newStr = str.components(separatedBy:": ")[1]
                                            code = newStr.replacingOccurrences(of: "\"", with: "")
                                            withAnimation{
                                                showResendBtn = false
                                                timeRemaining = 30
                                                showAlert.toggle()
                                                isLoading.toggle()
                                            }
                                        }
                                        else{
                                            message = "Error occured. Please try again later"

                                            withAnimation{
                                                showResendBtn = false

                                                showAlert.toggle()
                                                isLoading.toggle()
                                            }
                                        }
        //                                }
        //                                catch{
        //                                    print(error)
        //                                }
                                }.resume()
                                
                                }, label: {
                                    Text("Resend")
                                        .font(.custom("SFProRounded-Regular", size: 15) )
                                        .foregroundColor(Color("Color-red"))
                                })
                                Spacer()
                            }
                        }
                        else{
                            HStack{
                                Spacer()
                                    .frame(width:30)
                                Text("Resend code in " + String(timeRemaining) + " seconds")
                                    .font(.custom("SFProRounded-Regular", size: 15) )
                                    .onReceive(timer) { (_) in
                                        if timeRemaining > 1 {
                                            timeRemaining -= 1
                                        }
                                        else if timeRemaining == 1{
                                            timeRemaining -= 1
                                            self.timer.upstream.connect().cancel()
                                            showResendBtn = true
                                        }
                                    }
                                Spacer()
                            }
                            
                        }
                        Button(action: {
                            var enteredCode = code1 + code2 + code3 + code4
                            if enteredCode.count < 4{
                                message = "Please enter a valid code"
                                withAnimation{
                                    showAlert.toggle()
                                }
                            }
                            else{
                                enteredCode = String(enteredCode.prefix(4))
                                if enteredCode != code{
                                    message = "The code is incorrect"
                                    withAnimation{
                                        showAlert.toggle()
                                    }
                                }
                                else{
                                    goToRegistration.toggle()
                                }
                            }
                        }, label: {
                            Spacer()
                            Text("Continue")
                                .font(.custom("SFProRounded-Light", size: 18) )
                                .foregroundColor(Color("Color-white"))
                                .lineLimit(1)
                            Spacer()
                        })
                        .padding()
                        .background(Color("Color-red"))
                        .frame(width: UIScreen.screenWidth - 40, height: 40, alignment: .trailing)
                        .cornerRadius(30)
                        .fullScreenCover(isPresented: $goToRegistration, content: {
                            RegistrationView()
                        })
                    }
                }
                .padding(.top, 30)
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
            }
        }
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView()
    }
}

extension View {
    /// Focuses next field in sequence, from the given `FocusState`.
    /// Requires a currently active focus state and a next field available in the sequence.
    ///
    /// Example usage:
    /// ```
    /// .onSubmit { self.focusNextField($focusedField) }
    /// ```
    /// Given that `focusField` is an enum that represents the focusable fields. For example:
    /// ```
    /// @FocusState private var focusedField: Field?
    /// enum Field: Int, Hashable {
    ///    case name
    ///    case country
    ///    case city
    /// }
    /// ```
    func focusNextField<F: RawRepresentable>(_ field: FocusState<F?>.Binding) where F.RawValue == Int {
        guard let currentValue = field.wrappedValue else { return }
        let nextValue = currentValue.rawValue + 1
        if let newValue = F.init(rawValue: nextValue) {
            field.wrappedValue = newValue
        }
    }

    /// Focuses previous field in sequence, from the given `FocusState`.
    /// Requires a currently active focus state and a previous field available in the sequence.
    ///
    /// Example usage:
    /// ```
    /// .onSubmit { self.focusNextField($focusedField) }
    /// ```
    /// Given that `focusField` is an enum that represents the focusable fields. For example:
    /// ```
    /// @FocusState private var focusedField: Field?
    /// enum Field: Int, Hashable {
    ///    case name
    ///    case country
    ///    case city
    /// }
    /// ```
    func focusPreviousField<F: RawRepresentable>(_ field: FocusState<F?>.Binding) where F.RawValue == Int {
        guard let currentValue = field.wrappedValue else { return }
        let nextValue = currentValue.rawValue - 1
        if let newValue = F.init(rawValue: nextValue) {
            field.wrappedValue = newValue
        }
    }
}
