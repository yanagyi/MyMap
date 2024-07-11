//
//  MapView.swift
//  MyMap
//
//  Created by Hiro Yanagisawa on 2024/07/10.
//

import SwiftUI
import MapKit

//画面で選択したマップの種類を示す列挙型
enum MapType{
    case standard //標準
    case stellite //衛生写真
    case hybrid //衛生写真＋交通機関ラベル
}

struct MapView: View {
    //検索キーワード
    let searchKey: String
    //キーワードから取得した緯度経度
    @State var targetCoordinate = CLLocationCoordinate2D()
    //表示するマップの位置
    @State var cameraPosition: MapCameraPosition = .automatic
    //マップ種類　デフォルトは標準
    @State var displayMapType: MapType = .standard
    
    var body: some View {
        Map(position: $cameraPosition){
            //マップにピンを表示
            Marker(searchKey, coordinate: targetCoordinate)
        }
        //検索キーワードの変更を検知
        .onChange(of: searchKey,initial: true) { oldValue, newValue
            in
            //入力されたキーワードをデバッグエリアに表示
            print("検索キーワード：\(newValue)")
            
            //地図の検索クエリ（命令）の作成
            let request = MKLocalSearch.Request()
            
            //検索クエリにキーワードの設定
            request.naturalLanguageQuery = newValue
            
            //MKLocalSearchの初期化
            let search = MKLocalSearch(request: request)
            
            //検索の開始
            search.start{response, error in
                //結果が存在するときは1件目を取り出す
                if let mapItems = response?.mapItems,
                   let mapItem = mapItems.first{
                    //位置情報から緯度経度をtargetCoordinateに取り出す
                    targetCoordinate = mapItem.placemark.coordinate
                    //緯度経度をデバッグエリアに表示
                    print("緯度経度：\(targetCoordinate)")
                    //表示するマップの領域を作成
                    cameraPosition = .region(MKCoordinateRegion(
                        center : targetCoordinate,
                        latitudinalMeters: 500.0,
                        longitudinalMeters: 500.0
                    ))
                }
            }
        }
    }
}

#Preview {
    MapView(searchKey: "東京駅")
}
