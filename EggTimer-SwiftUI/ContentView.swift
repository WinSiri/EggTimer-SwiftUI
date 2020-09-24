//
//  ContentView.swift
//  EggTimer-SwiftUI
//
//  Created by Kwin Sirikwin on 20/8/20.
//  Copyright © 2020 Kwin Sirikwin. All rights reserved.
//

import SwiftUI
import UIKit


struct ContentView: View {
    
    let eggTimes = ["Soft": 13, "Medium": 14, "Hard": 17]
//        let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.7960784314, green: 0.9490196078, blue: 0.9882352941, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack {
                TitleView()
                HStack {
                    EggView(eggImage: #imageLiteral(resourceName: "Soft_egg"), eggHardness: "Soft", duration: eggTimes["Soft"]!)
                    EggView(eggImage: #imageLiteral(resourceName: "Medium_egg"), eggHardness: "Medium", duration: eggTimes["Medium"]!)
                    EggView(eggImage: #imageLiteral(resourceName: "Hard_egg"), eggHardness: "Hard", duration: eggTimes["Hard"]!)
                }
                EggProgressView()
            }
        }
    }
}

struct EggView: View {
    var eggImage: UIImage
    var eggHardness: String
    var duration: Int
    @EnvironmentObject var eggTimer: EggTimerObject
    
    var body: some View {
        ZStack {
            Image(uiImage: eggImage)
                .resizable()
                .scaledToFit()
            Button(action: {
                self.eggTimer.startCountDown(duration: TimeInterval(self.duration), step: 1.0)
            }, label: {
                Text(eggHardness)
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
        }
    }
}

struct EggProgressView: View {
    @EnvironmentObject var eggTimer: EggTimerObject
    
    var body: some View {
        VStack {
            Spacer()
            if #available(iOS 14.0, *) {
                ProgressView(value: eggTimer.timeElapsed, total: eggTimer.timeTotal)
                    .padding()
                Text(eggTimer.timeElapsed == eggTimer.timeTotal ? "Done!" : "Wait...")
                    .font(.largeTitle)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                // Fallback on earlier versions
                Text(eggTimer.timeElapsed == eggTimer.timeTotal ? "Done!" : "")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(ProgressRectangle(progress: CGFloat(eggTimer.timeElapsed)/CGFloat(eggTimer.timeTotal)))
                    .padding()
            }
            Spacer()
        }
    }
}

struct ProgressRectangle: View {
//    @Binding var progress: CGFloat // [0..1]
    var progress: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .trim(from: 0.0, to: CGFloat(progress))
            .stroke(Color.red, lineWidth: 2.0)
            .animation(.linear)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(EggTimerObject())
    }
}

