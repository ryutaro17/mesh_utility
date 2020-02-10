# mesh_utility
基準地域メッシュを計算

## Description
緯度、経度情報から１次メッシュコード、２次メッシュコード、３次メッシュコードを取得する機能。
３次メッシュコードから、当該メッシュの四隅の緯度経度座標を取得する機能

## Usage
    include MeshUtility
    mesh_cd = latLngToFullMeshCd3(loc.lat, loc.lon)
