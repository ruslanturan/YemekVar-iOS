//
//  AddPromotionView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 03.05.22.
//

import SwiftUI

struct AddPromotionView: View {
    @State private var code: String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
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
                Text("Promotions")
                   // .frame(height:26)
                    .font(.custom("SFProRounded-Light", size: 23) )
                Spacer()
            }
            Spacer()
                .frame(height:40)
            HStack{
                TextField("Enter promo code", text: $code)
                    .foregroundColor(Color.gray)
                    .font(.custom("SFProRounded-Regular", size: 18) )
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
            }
            .frame(width:260)
            Text(" ")
                .frame(
                  minWidth: 0,
                  maxWidth: 260,
                  minHeight: 0,
                  maxHeight: 1,
                  alignment: .leading
                )
                .background(Color("Color-red"))
            Text("Enter the code and it will be applied to your next order.")
                .frame(width:260)
                .font(.custom("SFProRounded-Light", size: 15))
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
            Spacer()
            Button(action: {}, label: {
                Text("Apply")
                    .font(.custom("SFProRounded-Light", size: 21))
                    .foregroundColor(Color("Color-white"))
                    .frame(width: UIScreen.screenWidth - 60, height: 50, alignment: .center)
                    .background(Color("Color-red"))
                    .cornerRadius(30)

            })
            Spacer()
                .frame(height:20)
        }
        .background(Color("Color-white"))
        .foregroundColor(Color("Color-black"))
    }
}

struct AddPromotionView_Previews: PreviewProvider {
    static var previews: some View {
        AddPromotionView()
            .preferredColorScheme(.dark)
    }
}
