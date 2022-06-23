//
//  SideMenuOptionView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 27.04.22.
//

import SwiftUI

struct SideMenuOptionView: View {
    @State var goToProfile = false
    @State var goToOrders = false
    @State var goToBookings = false
    @State var goToPayments = false
    @State var goToPromotions = false
    @State var goToSupport = false
    @State var goToSettings = false

    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    withAnimation{
                        goToProfile.toggle()
                    }
                }, label: {
                    HStack (spacing:6){
                        Spacer()
                            .frame(width:20)
                        Image("Icon-user-white")
                            .frame(width: 24, height: 24, alignment: .center)
                        Text("Profile")
                            .font(.custom("SFProRounded-Light", size: 18) )
                        Spacer()
                    }
                })
                .frame(width:UIScreen.screenWidth*4/7)

                .fullScreenCover(isPresented: $goToProfile, content: {
                    ProfileView()
                })
                Spacer()
            }


            HStack{
                Spacer()
                    .frame(width:50)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth/3,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray.opacity(0.6))
                Spacer()
            }
            HStack{
                Button(action: {
                    withAnimation{
                        goToOrders.toggle()
                    }
                }, label: {
                    HStack (spacing:6){
                        Spacer()
                            .frame(width:20)
                        Image("Icon-basket-white")
                            .frame(width: 24, height: 24, alignment: .center)
                        Text("My orders")
                            .font(.custom("SFProRounded-Light", size: 18) )
                        Spacer()
                    }
                })
                .frame(width:UIScreen.screenWidth*4/7)

                .fullScreenCover(isPresented: $goToOrders, content: {
                    OrdersView()
                })
                Spacer()
            }
            
            HStack{
                Spacer()
                    .frame(width:50)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth/3,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray.opacity(0.6))
                Spacer()
            }
            HStack{
                Button(action: {
                    withAnimation{
                        goToBookings.toggle()
                    }
                }, label: {
                    HStack (spacing:6){
                        Spacer()
                            .frame(width:20)
                        Image("Icon-calendar-white")
                            .frame(width: 24, height: 24, alignment: .center)
                        Text("My bookings")
                            .font(.custom("SFProRounded-Light", size: 18) )
                        Spacer()
                    }
                })
                .frame(width:UIScreen.screenWidth*4/7)

                .fullScreenCover(isPresented: $goToBookings, content: {
                    ReservationsView()
                })
                Spacer()
            }
            
            HStack{
                Spacer()
                    .frame(width:50)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth/3,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray.opacity(0.6))
                Spacer()
            }
        }
        VStack{
            HStack{
                Button(action: {
                    withAnimation{
                        goToPayments.toggle()
                    }
                }, label: {
                    HStack (spacing:6){
                        Spacer()
                            .frame(width:20)
                        Image("Icon-card-white")
                            .frame(width: 24, height: 24, alignment: .center)
                        Text("Payments")
                            .font(.custom("SFProRounded-Light", size: 18) )
                        Spacer()
                    }
                })
                .frame(width:UIScreen.screenWidth*4/7)

                .fullScreenCover(isPresented: $goToPayments, content: {
                    PaymentsView()
                })
                Spacer()
            }

            HStack{
                Spacer()
                    .frame(width:50)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth/3,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray.opacity(0.6))
                Spacer()
            }
            HStack{
                Button(action: {
                    withAnimation{
                        goToPromotions.toggle()
                    }
                }, label: {
                    HStack (spacing:6){
                        Spacer()
                            .frame(width:20)
                        Image("Icon-promotion")
                            .frame(width: 24, height: 24, alignment: .center)
                        Text("Promotions")
                            .font(.custom("SFProRounded-Light", size: 18) )
                        Spacer()
                    }
                })
                .frame(width:UIScreen.screenWidth*4/7)

                .fullScreenCover(isPresented: $goToPromotions, content: {
                    AddPromotionView()
                })
                Spacer()
            }
            
            HStack{
                Spacer()
                    .frame(width:50)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth/3,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray.opacity(0.6))
                Spacer()
            }
            HStack{
                Button(action: {
                    withAnimation{
                        goToSupport.toggle()
                    }
                }, label: {
                    HStack (spacing:6){
                        Spacer()
                            .frame(width:20)
                        Image("Icon-support")
                            .frame(width: 24, height: 24, alignment: .center)
                        Text("Support")
                            .font(.custom("SFProRounded-Light", size: 18) )
                        Spacer()
                    }
                })
                .frame(width:UIScreen.screenWidth*4/7)
                .fullScreenCover(isPresented: $goToSupport, content: {
                    SupportView()
                })
                Spacer()
            }
            
            HStack{
                Spacer()
                    .frame(width:50)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth/3,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray.opacity(0.6))
                Spacer()
            }
            HStack{
                Button(action: {
                    withAnimation{
                        goToSettings.toggle()
                    }
                }, label: {
                    HStack (spacing:6){
                        Spacer()
                            .frame(width:20)
                        Image("Icon-settings")
                            .frame(width: 24, height: 24, alignment: .center)
                        Text("Settings")
                            .font(.custom("SFProRounded-Light", size: 18) )
                        Spacer()
                    }
                })
                .frame(width:UIScreen.screenWidth*4/7)
                .fullScreenCover(isPresented: $goToSettings, content: {
                    SettingsView()
                })
                Spacer()
            }
            
            HStack{
                Spacer()
                    .frame(width:50)
                Text(" ")
                    .frame(
                      minWidth: 0,
                      maxWidth: UIScreen.screenWidth/3,
                      minHeight: 0,
                      maxHeight: 1,
                      alignment: .leading
                    )
                    .background(Color.gray.opacity(0.6))
                Spacer()
            }
        }

    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView()
    }
}
