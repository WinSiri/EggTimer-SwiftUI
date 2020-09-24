//
//  TitleView.swift
//  EggTimer-SwiftUI
//
//  Created by Kwin Sirikwin on 20/8/20.
//  Copyright © 2020 Kwin Sirikwin. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("How do you like your eggs?")
                .font(.title)
                .padding()
            Spacer()
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView().previewLayout(PreviewLayout.sizeThatFits)
    }
}
