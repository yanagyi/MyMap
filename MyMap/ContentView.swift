//
//  ContentView.swift
//  MyMap
//
//  Created by Hiro Yanagisawa on 2024/07/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            //マップ表示
            MapView(searchKey: "羽田空港")
        }
    }
}

#Preview {
    ContentView()
}
