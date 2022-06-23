//
//  ContentView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 19.04.22.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var location = LocationManager()
    @State private var showingAlert = true
    @State var showSidebar: Bool = false
    @State var showLoginView = false
    @State var showAlert = false
    @State var closeApp = true
    @State var message = "You need to give location permission from Phone Settings if you want to use the app"
    @State private var loggedID = UserDefaults.standard.string(forKey: "loggedID") ?? ""

    var lat: String {
        return "\(location.lastKnownLocation?.coordinate.latitude ?? 0.0)"
    }

    var lon: String {
        return "\(location.lastKnownLocation?.coordinate.longitude ?? 0.0)"
    }

    init() {
        self.location.startUpdating()
    }

    var body: some View {
        ZStack{
            VStack{
                if(location.statusString == "authorized"){
                    Group{
                        if showLoginView {
                            if loggedID == ""{
                                LoginView()
                            }
                            else{
                                TabBar()
                                    .edgesIgnoringSafeArea(.all)
//                                ReservationView(id:1)

                            }
                        }
                        else{
                            Image("Logo")
                                .resizable()
                                .scaledToFit()

                        }
                    }
                    .onAppear() {
                        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                            withAnimation {
                                self.showLoginView = true
                            }
                        }
                    }
                }
                else if(location.statusString == "denied"){
                    if #available(iOS 15.0, *) {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .onAppear(
                                perform: {showAlert.toggle()}
                            )
                    } else {
                        exit(1)
                    }
                }else{
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                }
                
            }
            .ignoresSafeArea(.all)
            .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
            .background(Color("Color-white"))
            if showAlert {
                VStack{

                    CustomAlertView(showAlert: $showAlert, closeApp: $closeApp, message: message)

                }
//                    .background(Color("Color-white"))
                .background(Color.black.opacity(0.8))
                .shadow(color: Color.black, radius: 4, x: 0, y: 1)

                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .transition(.opacity)
            }
        }
        
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

