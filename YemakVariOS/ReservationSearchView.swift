//
//  ReservationSearchView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 16.05.22.
//

import SwiftUI

struct ReservationSearchView: View {
    @State private var isShowingMenu = false
    @State private var name: String = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    @State var isEmpty = false
    @State var isLoading = false
    @State var showAlert = false
    @State var closeApp = false
    @State var goToMeal = false
    @State var goToRestaurant = false
    @State var message = ""
    @State var meals: [NSDictionary] = []
    @State var restaurants: [NSDictionary] = []
//    @State var word: String
//    public init(word: String){
//        self.word = word
//    }

    var body: some View {
        LoadingView(isShowing: $isLoading) {

        ZStack{
            AllLocationsView()
                .frame(width:UIScreen.screenWidth, height: UIScreen.screenHeight)
            ZStack{
                if isShowingMenu {
                    SideMenuView(isShowingMenu: $isShowingMenu)
                }
                    VStack{
                        Spacer()
                            .frame(height:40)
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
                                    .background(Color("Color-white"))
                                    .cornerRadius(30)
        //                            .position(x: 18, y:46)
                                    
//                                    .padding(.trailing,UIScreen.screenWidth/2 + 80)
                    //                .padding(.trailing,(UIScreen.screenWidth/2 + 120))
                                    .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)

                            })
                            Spacer()
                            HStack{
                                Spacer()
                                Image("Icon-user-red")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:16, height:16)
                                Text("2")
                                    .font(.custom("SFProRounded-Light", size: 18) )
                                    .foregroundColor(Color("Color-red"))
                                    .lineLimit(1)
                                    //.position(x: 110, y: 40)
                                    //.padding(.bottom,10)
                                Text(".")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50, weight: .heavy, design: .default))
                                    .lineLimit(1)
                                    //.position(x: 110, y: 40)
                                    .padding(.bottom,30)
                                Text("Now")
                                    .font(.custom("SFProRounded-Light", size: 18))
                                    .foregroundColor(Color("Color-red"))
                                    .lineLimit(1)
                                    //.position(x: 110, y: 40)
                                Spacer()
                            }
                            .background(Color("Color-yellow"))
                            .frame(width: 140, height: 40, alignment: .trailing)
                            .cornerRadius(30)
                            .shadow(color: Color("Color-gray"), radius: 6, x: 0, y: 3)
                            Spacer()
                                .frame(width:20)
                        }
                        HStack{
                            Spacer()
                                .frame(width:10)
                            Image("Icon-search")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20, alignment: .center)
                            TextField("Search for food or restaurant...", text: $name)
                                .foregroundColor(Color.gray)
                                .font(.custom("SFProRounded-Regular", size: 18) )
                                .lineLimit(1)
                                
                        }
                        .frame(width: UIScreen.screenWidth - 40, height: 50, alignment: .leading)
                        .background(Color("Color-white"))
                        .cornerRadius(50)
                        .padding(.vertical)
                        .shadow(color: Color("Color-gray"), radius: 10, x: 0, y: 10)
                        Spacer()

                    }
                    .background(isShowingMenu ? Color("Color-white") : Color.clear)
                    .cornerRadius(30)
                    .offset(x: isShowingMenu ? UIScreen.screenWidth*0.7 : 0, y: 0)
                    .scaleEffect(isShowingMenu ? 0.7 : 1)
            }

        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("Color-white"))
        }
    }
}

struct ReservationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationSearchView()
            .preferredColorScheme(.dark)
    }
}
