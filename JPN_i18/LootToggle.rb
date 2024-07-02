=begin
  VX Ace の戦利品は切り替え可能 [機能]
  
  著者: Modrome
  
  
    	不具合: ボス戦のシミュレーションなど、特定の戦闘セットからは戦利品や EXP/ゴールドを獲得できないようにしたいと考えていました。
	しかし、プレイヤーにそれらの戦闘からの戦利品を与えることは不必要であり、ストーリー内の戦闘からのみ報酬を獲得してもらいたいのです。
             
	私が遭遇したもう 1 つの問題は、Yanfly の Enemy Leveling スクリプトのように、EXP とゴールドの獲得のために数式を修正しようとする既存の方法があることでした。
	これらの関数をオーバーライドすると、結果として、プレイヤーはより高いレベルの敵と対峙しても報酬を得られなくなります。
           
   	解決： このスクリプトは、構成されたゲーム スイッチがオフに切り替えられた場合に、多くの関数にパッチを適用して元のコード/機能を返します。
	これは、数式に対する既存の変更と互換性があるように記述されているので、このスクリプトをそれらのスクリプトの下に置くだけです。
             
	説明書：
	     	このスクリプトは、戦利品や EXP ドロップを変更する可能性のあるスクリプトの下に配置します。

		このスクリプトには予約済みのスイッチを使用します。
		戦利品を無効にするには、これを ON に設定します。
		戦利品を無効にする必要がある戦闘を完了したら、これを OFF に戻すことを忘れないでください。
             
            
  著作権: Apache License 2.0 
=end

module Loot_Controls
  
  # これを予備スイッチとして設定します。ID 0011 は 11 になります。
  LOOT_DISABLE_SWITCH = 11
  # 設定はここで終了です
end



class Game_Enemy < Game_Battler
  
#--------------------------------------------------------------------------
# 修正する： exp
#--------------------------------------------------------------------------
  alias prior_exp_funct exp
  def exp
    if $game_switches[Loot_Controls::LOOT_DISABLE_SWITCH]
      return 0
    else
      return prior_exp_funct
    end
  end

#--------------------------------------------------------------------------
# 修正する： gold
#--------------------------------------------------------------------------
  alias prior_gold_funct gold
  def gold
    if $game_switches[Loot_Controls::LOOT_DISABLE_SWITCH]
      return 0
    else
      return prior_gold_funct
    end
  end
  
#--------------------------------------------------------------------------
# 修正する： make_drop_items
#--------------------------------------------------------------------------
  alias prior_item_dropt_funct make_drop_items
  def make_drop_items
    if $game_switches[Loot_Controls::LOOT_DISABLE_SWITCH]
      
      # 最終的には、nil を返さずに「r」という名前の空の配列を返すことで何も返しません。
      enemy.drop_items.inject([]) do |r, di|
        r
      end
      
    else
        # スイッチがオンになっていない場合は、前のコードを実行します。
      prior_item_dropt_funct
    end
    
  end
  
end
