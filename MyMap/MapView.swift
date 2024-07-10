//
//  MapView.swift
//  MyMap
//
//  Created by Hiro Yanagisawa on 2024/07/10.
//

import SwiftUI
import MapKit

struct MapView: View {
    //検索キーワード
    let searchKey: String
    var body: some View {
        Map(){
            
        }
        //検索キーワードの変更を検知
        .onChange(of: searchKey,initial: true) { oldValue, newValue
            in
            //入力されたキーワードをデバッグエリアに表示
            print("検索キーワード：\(newValue)")
        }
    }
}

#Preview {
    MapView(searchKey: "東京駅")
}
