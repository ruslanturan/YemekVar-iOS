//
//  PaymentsView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 03.05.22.
//

import SwiftUI

struct PaymentsView: View {
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

                Text("Payments")
                   // .frame(height:26)
                    .font(.custom("SFProRounded-Light", size: 23) )
                Spacer()
                
            }
            VStack{
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text("Payment methods")
                       // .frame(height:26)
                        .font(.custom("SFProRounded-Light", size: 15))
                        .foregroundColor(Color.gray)
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
                HStack{
                    Spacer()
                        .frame(width:30)
                    Image("Icon-cash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(10)

                    Text("Cash")
                       // .frame(height:26)
                        .font(.custom("SFProRounded-Light", size: 21) )
                    Spacer()
                    Image("Icon-done")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(10)
                    Spacer()
                        .frame(width:30)
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
                        .frame(width:30)
                    Image("Icon-card")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(10)
                    Text("Add payment card")
                       // .frame(height:26)
                        .font(.custom("SFProRounded-Light", size: 21))
                    Spacer()
                }
                Spacer()
                    .frame(height:20)
                HStack{
                    Spacer()
                        .frame(width:20)
                    Text("Promotions")
                       // .frame(height:26)
                        .font(.custom("SFProRounded-Light", size: 15))
                        .foregroundColor(Color.gray)
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
                HStack{
                    Spacer()
                        .frame(width:30)
                    Image("Icon-gift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(10)

                    Text("Enter promo code")
                       // .frame(height:26)
                        .font(.custom("SFProRounded-Light", size: 21) )
                    Spacer()
                    
                }
            }
            Spacer()
        }
        .background(Color("Color-white"))
        .foregroundColor(Color("Color-black"))
    }
}

struct PaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsView()
    }
}
