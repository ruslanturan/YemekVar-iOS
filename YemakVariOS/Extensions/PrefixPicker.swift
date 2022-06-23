//
//  PrefixPicker.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 26.05.22.
//

import SwiftUI

struct PrefixPicker: View {
    var images: [String]
    @Binding var selected: Int
    var options: [String]
    @State private var showOptions: Bool = false
    var body: some View {
        ZStack{
            HStack {
                Image(images[selected])
                    .resizable()
                    .scaledToFit()
                    .frame(width:23, height: 23)
                Image("Icon-down")
                    .resizable()
                    .scaledToFit()
                    .frame(width:20, height: 20)
                Text(options[selected])
                    .font(.custom("SFProRounded-Regular", size: 15))
                    .lineLimit(1)
                }
                .font(Font.custom("SFProRounded-Light", size: 16).weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color("Color-white"))
                .onTapGesture {
                    // show the dropdown options
                    withAnimation(Animation.spring().speed(2)) {
                        showOptions = true
                    }
                }
            if showOptions{
                VStack(alignment: .leading, spacing: 4) {
                    
                    VStack {
                        Spacer()

                        ForEach(options.indices, id: \.self) { i in
                            HStack{
                                
                                if i == selected {
                                    Image(images[i])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:23, height: 23)
                                    Text(options[i])
                                        .font(.system(size: 12))
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .background(Color("Color-white").opacity(0.2))
                                        .cornerRadius(4)
                                        .onTapGesture {
                                            // hide dropdown options - user selection didn't change
                                            withAnimation(Animation.spring().speed(2)) {
                                                showOptions = false
                                            }
                                        }
                                } else {
                                    Image(images[i])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:23, height: 23)
                                    Text(options[i])
                                        .font(.system(size: 12))
                                        .onTapGesture {
                                            // update user selection and close options dropdown
                                            withAnimation(Animation.spring().speed(2)) {
                                                selected = i
                                                showOptions = false
                                            }
                                        }
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(.vertical, 2)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    
                }
                .frame(
                      minWidth: 0,
                      maxWidth: .infinity,
                      alignment: .center
                    )
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color("Color-white"))
                .transition(.opacity)
                }
            }
    }
}

