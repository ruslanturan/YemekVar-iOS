//
//  TabBar.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 23.04.22.
//

import SwiftUI

struct TabBar: View {
    @State private var isShowingMenu = false
    @State private var goToProfile = false
    @State private var goToLogin = false
    @State var currentTab: Tab = .Delivery
    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""
    @Namespace var animation
    @State var currentXValue: CGFloat = 0
    var body: some View {
        ZStack{
            if isShowingMenu {
                SideMenuView(isShowingMenu: $isShowingMenu)
            }
            VStack(spacing:0){
                ZStack(alignment:.top){
                    
                    TabView (selection: $currentTab){
                        
                        DeliveryHomeView()
                            .tag(Tab.Delivery)
                        
                        ReservationHomeView()
                            .tag(Tab.Reservation)

                        }
                    .overlay(
                        HStack(spacing:0){
                            ForEach(Tab.allCases, id:\.rawValue){tab in
                                TabButton(tab: tab)
                            }
                        }
                        .padding(.vertical)
                        .padding(.bottom, getSafeArea().bottom == 0 ? 10 :
                                    (getSafeArea().bottom - 10))
                        .background(
                            CustomEffect(style: .systemUltraThinMaterialDark)
                                .clipShape(BottomCurve(currentXValue: currentXValue))
                        )
                        ,alignment: .bottom
                    )
                    VStack{
                        HStack(alignment:.top){
                            if loggedID != ""{
                            Spacer()
                                .frame(width:10)
                            Button(action: {
                                withAnimation(.spring()){
                                    isShowingMenu.toggle()
                                }
                            }) {
                                Image("Icon-menu")
                                    .frame(width: 22, height: 15, alignment: .center)
                                    .padding(15)
                                    .background(Color("Color-white"))
                                    .clipShape(Circle())
                                    .shadow(color: currentTab == .Delivery ? Color("Color-gray") : .clear, radius: 10, x: 0, y: 3)
                            }
                            }
                            Spacer()
                            Button(action: {
                                withAnimation(.spring()){
                                    if loggedID != ""{
                                        goToProfile.toggle()
                                    }
                                    else{
                                        goToLogin.toggle()
                                    }
                                }
                            }) {
                                Image("Icon-user")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45, alignment: .center)
                                    .background(Color("Color-white"))
                                    .cornerRadius(25)
                                    .overlay(
                                        Circle().stroke(currentTab == .Delivery ? Color("Color-red") : Color("Color-yellow"), lineWidth: 2.5))
                                    .shadow(color: currentTab == .Delivery ? Color("Color-gray") : .clear, radius: 10, x: 0, y: 3)
                            }
                            .fullScreenCover(isPresented: $goToProfile, content: {
                                ProfileView()
                            })
                            .fullScreenCover(isPresented: $goToLogin, content: {
                                LoginView()
                            })
                            
                            Spacer()
                                .frame(width:10)
                        }
                        .frame(height:100)
                        .cornerRadius(isShowingMenu ? 20 : 0, corners: [.topLeft, .topRight])
                    }
//                    .background(currentTab == .Delivery ? Color("Color-white") : Color("Color-red"))
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
                .background(.clear)


//            .ignoresSafeArea(.all, edges: .bottom)
            
            }
            .cornerRadius(isShowingMenu ? 20 : 0)
            .offset(x: isShowingMenu ? UIScreen.screenWidth*0.7 : 0, y: 0)
            .scaleEffect(isShowingMenu ? 0.7 : 1)
            .disabled(isShowingMenu)
        }
    }

    @ViewBuilder
    func TabButton(tab: Tab) -> some View{
        GeometryReader{ proxy in
            Button{
                withAnimation(.spring()){
                    currentTab = tab
                    currentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                Image(tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .padding(currentTab == tab ? 15 : 0)
                    .contentShape(Rectangle())
                    .background(
                        ZStack{
                            if currentTab == tab {
                                CustomEffect(style: .systemChromeMaterialDark)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
                    .offset(y: currentTab == tab ? -50 : 0)
            }
            .onAppear{
                if tab == Tab.allCases.first && currentXValue == 0{
                    currentXValue = proxy.frame(in: .global).midX
                }
            }
        }
        .frame(height: 30)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

enum Tab: String, CaseIterable {
    case Delivery = "Icon-delivery"
    case Reservation = "Icon-reservation"

}

extension View{
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as?
                UIWindowScene else{
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets
        else{
            return .zero
        }
        return safeArea
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
