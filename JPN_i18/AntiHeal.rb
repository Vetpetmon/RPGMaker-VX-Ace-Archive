=begin
  VX Ace の逆治癒
  バージョン: 1
  
  著者: Modrome
  
    	不具合: PHA または REC を負の値に設定することはできません。
	回復を逆転させるステータスが必要です。
	また、特定のステータス ID が存在する場合は、そのステータスをオーバーライドする必要があります。
	可能であれば、特定のステータス ID によってバイパスできないステータス ID も追加してください。
    
    	解決： 2 つのステータス ID を設定し、もう 1 つはそれらのステータスの 1 つに対するカウンターとして機能します。
	アンチヒールが可能な場合は、ヒールを -1 倍にします。
	HP ドレインまたはライフスティールを逆転させることもできる方法で行います。
            
  著作権: Apache License 2.0 
=end

module AntiHealCore
  ANTIHEALSTATUSID = 67
  OTHERANTIHEALSTATUSID = 69
  ANTIANTIHEALSTATUSID = 68 # ANTIHEALSTATUSID には対抗しますが、OTHERANTIHEALSTATUSID には対抗しません。
end # 設定終了 - ここより先は編集しないでください。

class Game_Battler
  
  def hasAntiHealStatus?
    (state?(AntiHealCore::ANTIHEALSTATUSID) && !state?(AntiHealCore::ANTIANTIHEALSTATUSID)) || (state?(AntiHealCore::OTHERANTIHEALSTATUSID)) 
  end
  
  def antiheal_heal_effects
    if hasAntiHealStatus?
      # 逆排水
      if @result.hp_drain > 0
        @result.hp_damage *= -1 
        @result.hp_drain *= -1
      # 逆治癒
      elsif @result.hp_damage < 0
        @result.hp_damage *= -1
      end
    end
  end
  
  alias :og_execute_damage :execute_damage
  def execute_damage(user)
    antiheal_heal_effects 
    # ダメージ操作を実行する前に反転を計算します。
    og_execute_damage(user)
  end
end
