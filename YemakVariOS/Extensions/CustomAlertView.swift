//
//  CustomAlertView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 27.05.22.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var showAlert: Bool
    @Binding var closeApp: Bool
    var message: String
    var body: some View {
        ZStack {
                VStack {                                 
                    Spacer()
                     Text(message)
                       // .foregroundColor(Color.white)
                        .font(.custom("SFProRounded-Semibold", size: 16) )
                        .multilineTextAlignment(.center)
                        .frame(width: UIScreen.main.bounds.width-60)
                    Spacer()
                    HStack {
                        Button(action: {
                            withAnimation{
                                showAlert.toggle()
                            }
                            if closeApp{
                                exit(1)
                            }
                        }, label: {
                            Text("Close")
                               // .frame(height:26)
                                .font(.custom("SFProRounded-Light", size: 19) )
                                
                                .lineLimit(1)
                                .frame(width:UIScreen.screenWidth*2/5, height: 40)
                                .background(Color("Color-red"))
                                .foregroundColor(Color("Color-white"))
                                .cornerRadius(30)
                        })
                      }
                    Spacer()
                        .frame(height:10)
                    }
                .frame(width: UIScreen.main.bounds.width-50, height: 150)
                 .background(Color("Color-white"))
                 .cornerRadius(12)
                 .clipped()
                 .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)

        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .background(Color("Color-white"))
        .transition(.opacity)

    }
}
//
//struct CustomAlertView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAlertView()
//    }
//}
