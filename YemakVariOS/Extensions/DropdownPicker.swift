//
//  DropdownPicker.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 26.04.22.
//

import SwiftUI

struct DropdownPicker: View {
    var title: String
    @Binding var selection: Int
    var options: [String]
    @State private var showOptions: Bool = false

    var body: some View {
        ZStack{
            HStack {
                    Text(title)
                    .foregroundColor(Color("Color-red"))
                    Spacer()
                    Text(options[selection])
                        .foregroundColor(Color("Color-red"))
                    Image("Icon-down-red")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 10, height: 10)
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
                    Text(title)
                        .font(Font.custom("SFProRounded-Light", size: 16).weight(.semibold))
                        .foregroundColor(Color("Color-white"))
                    VStack {
                        Spacer()
                        
                        ForEach(options.indices, id: \.self) { i in
                            if i == selection {
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
                                Text(options[i])
                                    .font(.system(size: 12))
                                    .onTapGesture {
                                        // update user selection and close options dropdown
                                        withAnimation(Animation.spring().speed(2)) {
                                            selection = i
                                            showOptions = false
                                        }
                                        if options[i].contains("₼"){
                                            UserDefaults.standard.set(options[i], forKey: "CourierTip")
                                        }
                                    }
                            }
                            Spacer()
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
                .background(Color("Color-red"))
                .foregroundColor(Color("Color-white"))
                .transition(.opacity)
                }
            }
        }
}
