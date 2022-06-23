//
//  SideMenuView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 27.04.22.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowingMenu: Bool
    @State var goToLogin = false

    var body: some View {
        ZStack{
            LinearGradient(colors: [Color("Color-red"),Color("Color-red")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{


                ScrollView(.vertical){
                    SideMenuHeaderView(isShowingMenu: $isShowingMenu)
                        .foregroundColor(Color.white)
                    
                        SideMenuOptionView()
                            .foregroundColor(Color.white)
                        
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight - 100)
                Button(action: {}, label: {
                    
                })
                HStack{
                    Spacer()
                        .frame(width:25)
                    Button(action: {
                        UserDefaults.standard.set("", forKey: "loggedID")
                        UserDefaults.standard.set("", forKey: "selectedAddressInfo")
                        UserDefaults.standard.set("", forKey: "selectedAddressName")
                        UserDefaults.standard.set(0, forKey: "selectedAddressID")
                        UserDefaults.standard.set("", forKey: "selectedStreet")
                        UserDefaults.standard.set("", forKey: "selectedLatitude")
                        UserDefaults.standard.set("", forKey: "selectedLongitude")
                        withAnimation{
                            goToLogin.toggle()
                        }
                    }, label: {
                        HStack{
                            Text("Log out")
                                .foregroundColor(Color("Color-red"))
                                .font(.custom("SFProRounded-Regular", size: 20) )
                                .lineLimit(1)
                                
                            Image("Icon-skip")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 15)
                        }
                        .padding(.horizontal)
                        .padding(.vertical,8)
    //                        .padding(.trailing,20)
                        .background(Color("Color-white"))
                        .cornerRadius(30)
                        .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                    })
                    .fullScreenCover(isPresented: $goToLogin, content: {
                        LoginView()
                        
                    })
                    Spacer()
                }
                Spacer()
                    .frame(height:30)
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowingMenu: .constant(true))
    }
}
