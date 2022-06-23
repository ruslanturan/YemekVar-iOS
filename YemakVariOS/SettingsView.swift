//
//  SettingsView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 17.05.22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        VStack{
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
                    
                    Text("Settings")
                       // .frame(height:26)
                        .font(.custom("SFProRounded-Light", size: 23) )
                    Spacer()
                }
            }
        ScrollView{

            VStack{
                VStack{
                    Spacer()
                        .frame(height:50)
                    HStack{
                        Spacer()
                            .frame(width:20)
                        Text(verbatim:"Rate app")
                            .font(.custom("SFProRounded-Regular", size: 20) )
                            .lineLimit(1)
                        Spacer()
                        Image("Icon-go")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
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
                }
                .padding(.bottom, 10)
                VStack{
                    HStack{
                        Spacer()
                            .frame(width:20)
                        Text(verbatim:"Facebook")
                            .font(.custom("SFProRounded-Regular", size: 20) )
                            .lineLimit(1)
                        Spacer()
                        Image("Icon-go")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
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
                }
                .padding(.bottom, 10)
                VStack{
                    Spacer()
                        .frame(height:50)
                    HStack{
                        Spacer()
                            .frame(width:20)
                        Text(verbatim:"Dark mode")
                            .font(.custom("SFProRounded-Regular", size: 20) )
                            .lineLimit(1)
                        Spacer()
                        Text(verbatim:"System settings")
                            .font(.custom("SFProRounded-Light", size: 15) )
                            .lineLimit(1)
                            .foregroundColor(Color("Color-red"))
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
                }
                .padding(.bottom, 10)
                VStack{
                    Spacer()
                        .frame(height:50)
                    HStack{
                        Spacer()
                            .frame(width:20)
                        Text(verbatim:"Solutions for couriers")
                            .font(.custom("SFProRounded-Regular", size: 20) )
                            .lineLimit(1)
                        Spacer()
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
                }
                .padding(.bottom, 10)
                VStack{
                    HStack{
                        Spacer()
                            .frame(width:20)
                        Text(verbatim:"Yemek Var Careers")
                            .font(.custom("SFProRounded-Regular", size: 20) )
                            .lineLimit(1)
                        Spacer()
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
                }
                .padding(.bottom, 10)
                VStack{
                    Spacer()
                        .frame(height:50)
                    HStack{
                        Spacer()
                            .frame(width:20)
                        Text(verbatim:"Terms and conditions")
                            .font(.custom("SFProRounded-Regular", size: 20) )
                            .lineLimit(1)
                        Spacer()
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
                }
                .padding(.bottom, 10)
            }
            
        }
        }
        .background(Color("Color-white"))
        .foregroundColor(Color("Color-black"))


    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
