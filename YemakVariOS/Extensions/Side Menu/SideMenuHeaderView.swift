//
//  SideMenuHeaderView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 27.04.22.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var isShowingMenu: Bool
    var body: some View {
        ZStack(alignment:.topTrailing){
            Button(action: {
                withAnimation(.spring()){
                    isShowingMenu.toggle()
                }
                
            }, label: {
                HStack{
                    Spacer()
                    Image(systemName: "xmark")
                        .frame(width:32, height:32)
                        .foregroundColor(Color.white)
                        .padding()
                    Spacer()
                        .frame(width:20)
                }
                
            })
            Spacer()
        }
        .frame(width:UIScreen.screenWidth)
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowingMenu: .constant(true))
    }
}
