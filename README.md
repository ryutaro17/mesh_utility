# mesh_utility
基準地域メッシュを計算

## Description
・緯度、経度情報から１次メッシュコード、２次メッシュコード、３次メッシュコードを取得する機能。  
・当該３次メッシュコードの四隅の座標（左上、左下、右下、右上）を取得する機能（meshCd3ToRectangleLatLng）  
・当該３次メッシュコードの左下の緯度・経度を取得する機能（meshCd3ToLatLng）  

## Usage
    include MeshUtility
    # 3次メッシュコード
    mesh_cd = latLngToFullMeshCd3(latitude, longitude)
    # 左上、左下、右下、右上の緯度経度の連想配列 {left_up: 左上, left_down: 左下, right_down: 右下, right_up: 右上}
    mesh_cds = meshCd3ToRectangleLatLng(mesh_cd)
