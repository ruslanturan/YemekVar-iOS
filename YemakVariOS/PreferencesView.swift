//
//  PreferencesView.swift
//  YemakVariOS
//
//  Created by Ruslan Cahangirov on 06.05.22.
//

import SwiftUI
import SpriteKit
class GameScene: SKScene {
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let box = SKSpriteNode(color: SKColor.red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
}

struct PreferencesView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 216, height: 216)
        scene.scaleMode = .fill
        return scene
    }
    var body: some View {
        ScrollView{
            SpriteView(scene: self.scene)
                       .frame(width: 256, height: 256)
                       .ignoresSafeArea()
            HStack{
                Spacer()
                    .frame(width:20)
                Image("Icon-back")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                Spacer()
                HStack{
                    Text("Skip")
                        .foregroundColor(Color("Color-red"))
                        .font(.custom("SFProRounded-Regular", size: 20) )
                    Image("Icon-skip")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 15)
                    
                }
                .padding(.horizontal)
                .padding(.vertical,8)
                .lineLimit(1)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(color: Color("Color-gray"), radius: 4, x: 0, y: 1)
                Spacer()
                    .frame(width:20)
            }
            HStack{
                Spacer()
                    .frame(width:20)
                Text("Tell us what you like")
                    .font(.custom("SFProRounded-Regular", size: 36) )
                    .foregroundColor(Color("Color-red"))
                Spacer()
            }
            HStack{
                Spacer()
                    .frame(width:20)
                Text("Tap once if you like the category, tap twice if it is your favourite one, hold if you dislike the category")
                    .font(.custom("SFProRounded-Regular", size: 15) )
                Spacer()
                    .frame(width:80)
            }
            
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
