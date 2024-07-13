//
//  ContentView.swift
//  MyMap
//
//  Created by Hiro Yanagisawa on 2024/07/10.
//

import SwiftUI

struct ContentView: View {
    //入力中の文字列を保持する状態変数
    @State var inputText: String = ""
    //検索キーワードを保持する状態変数,初期値は"東京駅"
    @State var displaySearchKey: String = "東京駅"
    //マップ種類　デフォルトは標準
    @State var displayMapType: MapType = .standard
    
    var body: some View {
        VStack{
            //テキストフィールド（文字入力）
            TextField("キーワード",text: $inputText,prompt:
                        Text("キーワードを入力してください"))
            //入力が完了された時
            .onSubmit {
                //入力が完了したので検索キーワードに設定する
                displaySearchKey = inputText
            }
            //余白を設定
            .padding()
            
            //奥から手前にレイアウト（右下標準で配置する）
            ZStack(alignment: .bottomTrailing){
                //マップ表示
                MapView(searchKey: displaySearchKey, mapType: displayMapType)
                
                //マップの種類切り替えボタン
                Button{
                    //標準
                    if displayMapType == .standard{
                        displayMapType = .stellite
                    }else if displayMapType == .stellite{
                        displayMapType = .hybrid
                    }else{
                        displayMapType = .standard
                    }
                }label: {
                    //マップアイコンの表示
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0,height: 35.0)
                }
                //右の余白20空ける
                .padding(.trailing,20.0)
                //下の余白30空ける
                .padding(.bottom,30.0)
            }
        }
    }
}

#Preview {
    ContentView()
}
