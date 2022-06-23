//
//  SupportView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 17.05.22.
//

import SwiftUI

struct SupportView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State private var searchText: String = ""
    @State var isLoading = false
    @State var showAlert = false
    @State var closeApp = false
    @State var message = ""
    @State var name = ""
    @State var email = ""
    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""
    var body: some View {
        LoadingView(isShowing: $isLoading) {

        ZStack{
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
                    
                    Text("Support")
                       // .frame(height:26)
                        .font(.custom("SFProRounded-Light", size: 23) )
                    Spacer()
                }
                ScrollView{

                HStack{
                    Spacer()
                        .frame(width:20)
                    Text(verbatim:"Help with any issues")
                        .font(.custom("SFProRounded-Regular", size: 20) )
                        .lineLimit(1)
                        .foregroundColor(Color.gray)
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
                            Text(verbatim:email)
                                .font(.custom("SFProRounded-Regular", size: 20) )
                                .lineLimit(1)
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                    }
                }

            VStack{
                Spacer()
                    .frame(height:150)
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text(verbatim:"Issue with the recent order")
                        .font(.custom("SFProRounded-Regular", size: 20) )
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 20)
                    Spacer()
                        .frame(width:20)
                }
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth - 40,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray)
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text(verbatim:"Another issue")
                        .font(.custom("SFProRounded-Regular", size: 20) )
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 20)
                    Spacer()
                        .frame(width:20)
                }
                .padding(.top,5)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth - 40,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray)
                HStack{
                    Spacer()
                        .frame(width:10)

                    TextField("Support", text: $searchText)
                        .foregroundColor(Color.gray)
                        .font(.custom("SFProRounded-Regular", size: 18) )
                        .lineLimit(1)
                    Image("Icon-search")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .center)

                }
                .frame(width: UIScreen.screenWidth - 40, height: 30, alignment: .leading)
                .padding(.vertical)
            }
            .padding(.bottom, 10)
            VStack{
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text(verbatim:"Account")
                        .font(.custom("SFProRounded-Regular", size: 20) )
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 20)
                    Spacer()
                        .frame(width:20)
                }
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth - 40,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray)
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text(verbatim:"Payments & pricing")
                        .font(.custom("SFProRounded-Regular", size: 20) )
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 20)
                    Spacer()
                        .frame(width:20)
                }
                .padding(.top,5)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth - 40,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray)
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text(verbatim:"Using Eattable")
                        .font(.custom("SFProRounded-Regular", size: 20) )
                        .lineLimit(1)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 20)
                    Spacer()
                        .frame(width:20)
                }
                .padding(.top,5)
            }
            Spacer()
                .frame(height:50)
            HStack{
                Spacer()
                    .frame(width:20)
                Text(verbatim:"Your conversations")
                    .font(.custom("SFProRounded-Regular", size: 20) )
                    .lineLimit(1)
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 20)
                Spacer()
                    .frame(width:20)
            }
            .padding(.top,5)
            Text(" ")
                .frame(
                  minWidth: 0,
                  maxWidth: UIScreen.screenWidth - 40,
                  minHeight: 0,
                  maxHeight: 1,
                  alignment: .leading
                )
                .background(Color.gray)
        }
            }
        .background(Color("Color-white"))
        .foregroundColor(Color("Color-black"))

        .task({
            await loadData()
        })
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

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
//            .preferredColorScheme(.dark)
    }
}
