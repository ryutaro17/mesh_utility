module MeshUtility	
	# 当該３次メッシュコードの左下の座標を計算する
    def meshCd3ToLatLng(mesh_cd)
        
		mesh_cd_str = mesh_cd.class == Integer ? mesh_cd.to_s : mesh_cd
		
		# 8桁のメッシュコードではない場合はnilを返す
		return nil if mesh_cd.to_s.length != 8

		# 分解する
		mesh1_1 = mesh_cd_str[0,2].to_f
		mesh1_2 = mesh_cd_str[2,2].to_f
		mesh2_1 = mesh_cd_str[4,1].to_f
		mesh2_2 = mesh_cd_str[5,1].to_f
		mesh3_1 = mesh_cd_str[6,1].to_f
		mesh3_2 = mesh_cd_str[7,1].to_f
		
		# 度
		lat1 = mesh1_1 / 1.5
		lng1 = mesh1_2 + 100

		# 分
		lat2 = mesh2_1 * 5
		lng2 = mesh2_2 * 7.5

		# 秒
		lat3 = mesh3_1 * 30
		lng3 = mesh3_2 * 45
		
		lat = lat1 + lat2.fdiv(60) + lat3.fdiv(3600)
		lng = lng1 + lng2.fdiv(60) + lng3.fdiv(3600)
		
		{lat: lat, lng: lng}
	end
	
	# 当該３次メッシュコードの四隅の座標を左上、左下、右下、右上で返す
    def meshCd3ToRectangleLatLng(mesh_cd)

        target_mesh_cd = mesh_cd.class == String ? mesh_cd.to_i : mesh_cd
        
        # 上
        up_mesh_cd = meshCdUp(target_mesh_cd)
        # 右
        right_mesh_cd = meshCdRight(target_mesh_cd)
        # 右上
        right_up_mesh_cd = meshCdUp(right_mesh_cd)
        
		# 当該メッシュ → 当該メッシュの左下座標の計算
		left_down = meshCd3ToLatLng(target_mesh_cd)
		
		# 当該メッシュの上 → 当該メッシュの左上座標の計算
		left_up = meshCd3ToLatLng(up_mesh_cd)
		
		# 当該メッシュの右 → 当該メッシュの右下座標の計算
		right_down = meshCd3ToLatLng(right_mesh_cd)
		
		#当該メッシュの右上 → 当該メッシュの右上座標の計算
		right_up = meshCd3ToLatLng(right_up_mesh_cd)
		
		{left_up: left_up, left_down: left_down, right_down: right_down, right_up: right_up}
    end
    
    # 当該３次メッシュの北側（上）のメッシュコード
    def meshCdUp(mesh_cd)
		
        mesh_cd_str = mesh_cd.class == Integer ? mesh_cd.to_s : mesh_cd
    	mesh2_1 = mesh_cd_str[4,1].to_i
    	mesh3_1 = mesh_cd_str[6,1].to_i
		
		if mesh2_1.to_i == 7 && mesh3_1.to_i == 9 then
			# １次メッシュが切り替わる
			mesh_cd + 1000000 - 7000 - 90
		elsif mesh3_1.to_i == 9 then
			# ２次メッシュが切り替わる
			mesh_cd + 1000 - 90
		else
			mesh_cd + 10
		end
    end

    # 当該３次メッシュの右側のメッシュコード
    def meshCdRight(mesh_cd)
		
        mesh_cd_str = mesh_cd.class == Integer ? mesh_cd.to_s : mesh_cd
		mesh2_2 = mesh_cd_str[5,1].to_i
		mesh3_2 = mesh_cd_str[7,1].to_i
		
		if mesh2_2.to_i == 7 && mesh3_2.to_i == 9 then
			# １次メッシュが切り替わる
			mesh_cd + 10000 - 700 - 9
		elsif mesh3_2.to_i == 9 then
			# ２次メッシュが切り替わる
			mesh_cd + 100 - 9
		else
			mesh_cd + 1
		end
    end
	
	# 緯度経度から１次メッシュコード（４桁）を取得する
	def latLngToMeshCd1(lat, lng)
		up = (lat.to_r * 60.0r / 40.0r).to_i
		dn = (lng.to_r - 100.0r).to_i

		return up.to_s + dn.to_s
	end

	# 緯度経度から２次メッシュコード（２桁）を取得する
	def latLngToMeshCd2(lat, lng)
		up = (lat * 60.0 % 40.0 / 5.0).to_i
		dn = ((lng.to_r - lng.to_i.to_r) * 60.0r / 7.5r).to_i

		return up.to_s + dn.to_s
	end

	# 緯度経度から２次メッシュコード（４＋２桁）を取得する
	def latLngToFullMeshCd2(lat, lng)
		return latLngToMeshCd1(lat, lng) + latLngToMeshCd2(lat, lng)
	end
	
	# 緯度経度から３次メッシュコード（２桁）を取得する
	def latLngToMeshCd3(lat, lng)
		up = (lat * 60.0 % 40.0 % 5.0 * 60.0 / 30.0).to_i
		dn = ((lng.to_r - lng.to_i.to_r) * 60.0r % 7.5r * 60.0r / 45.0r).to_i

		return up.to_s + dn.to_s
	end

	# 緯度経度から３次メッシュコード（４＋２＋２桁）を取得する
	def latLngToFullMeshCd3(lat, lng)
		return latLngToMeshCd1(lat, lng) + latLngToMeshCd2(lat, lng) + latLngToMeshCd3(lat, lng)
	end
	
end