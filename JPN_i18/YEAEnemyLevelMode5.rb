=begin
  VX Ace の YEA 敵レベルアップ モード 5
  
  著者: Modrome
  
  
	不具合: Yanfly の Enemy Leveling スクリプトは素晴らしいのですが、
	私のゲームではパーティのレベル調整が無効になっています。
	代わりに、ゲーム ワールドには敵が出現するレベルを決定する変数があります。
	アクターのレベル調整が無効になっているため、すべての敵がレベル 1 から 5 で出現します。
           
	解決： このスクリプトは、元の式を修正して「5 番目の」モードをサポートします。
	このモードでは、アクターのレベルを計算する代わりに、ゲーム変数を使用します。
	正しく動作させるには、これを Yanfly の Enemy Leveling スクリプトの下に配置してください。
             
	必要：https://yanflychannel.wordpress.com/rmvxa/gameplay-scripts/enemy-levels/
             https://github.com/Archeia/YEARepo/blob/master/Gameplay/Enemy_Levels.rb
   
	説明書：
		YEA-EnemyLevels の DEFAULT_LEVEL_TYPE を次のように 5 に設定する必要があります:
			DEFAULT_LEVEL_TYPE = 5
             
		このスクリプトは、スクリプト リストの YEA-EnemyLevels の下のどこかに配置する必要があります。
             
             	WORLD_TIERを予約変数に設定することを忘れないでください。必要に応じてゲーム全体で値を変更します。
             
            
  著作権: Apache License 2.0 
=end


module Enemy_Level_Controls
  
  # これを予約変数として設定します。
  # 変数IDを使用します。0120は120になります。
  WORLD_TIER = 120
  
end

class Game_Party < Game_Unit

  # ====================================
  # 修正する： match_party_level(level_type)
  # ====================================
  
  alias og_match_party_level match_party_level
  def match_party_level(level_type)
    case level_type
    when 5; return get_world_tier
    else return og_match_party_level(level_type)
    end
  end
  
  # ====================================
  # 新しい： World Tier
  # ====================================
  def get_world_tier
    if $game_variables[Enemy_Level_Controls::WORLD_TIER].to_i.zero?
      return 1
    else return $game_variables[Enemy_Level_Controls::WORLD_TIER]
    end
  end
  
end
