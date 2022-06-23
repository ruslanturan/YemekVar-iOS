//
//  NoConnectionView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 17.05.22.
//

import SwiftUI

struct NoConnectionView: View {
    var body: some View {
        VStack{
            Spacer()
            Image("Icon-no-internet")
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
            Text("No internet Connection")
               // .frame(height:26)
                .font(.custom("SFProRounded-Light", size: 30) )
            Text("Your internet connection is currently not available please check or try again.")
               // .frame(height:26)
                .font(.custom("SFProRounded-Light", size: 20) )
                .multilineTextAlignment(.center)
                .frame(width:UIScreen.screenWidth - 50)
            Spacer()
            Button(action: {}, label: {
                Text("Try again")
                    .font(.custom("SFProRounded-Light", size: 21))
                    .foregroundColor(Color("Color-white"))
                    .frame(width: UIScreen.screenWidth - 60, height: 50, alignment: .center)
                    .background(Color("Color-red"))
                    .cornerRadius(30)

            })
            Spacer()
                .frame(height:30)
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .background(Color("Color-white"))
    }
}

struct NoConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        NoConnectionView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 8")
    }
}
