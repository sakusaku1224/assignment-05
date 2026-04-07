HANDS = ["グー", "チョキ", "パー"]
DIRECTIONS = ["上", "下", "右", "左"]
EXIT_CHOICE = 3

#入力バリテーション
def validate_input(range)
  loop do
    input = gets.chomp
    #inputが正の整数か判定・rangeに含まれるか判定
    if input.match?(/^\d+$/) && range.include?(input.to_i)
      return input.to_i #数値で返す
    else
      puts "0~3の数字を選択してください"
    end
  end
end

#手の名前に変換するメソッド
def hand_name(hand)
  HANDS[hand]
end

#方向に変換するメソッド
def direction_name(direction)
  DIRECTIONS[direction]
end

#じゃんけん判定
def judge_janken(player, opponent)
  case (player - opponent) % 3
  when 0
    :draw
  when 2
    :win
  when 1
    :lose
  end
end

#あっち向いてホイ判定
def judge_acchi_muite_hoi(pointer, facer)
  pointer == facer
end

#じゃんけんメソッド
def play_janken
  loop do
    puts "じゃんけん..." 
    puts "0（グー）1（チョキ）2（パー）3（戦わない）"
    player_hand =  validate_input(0..3)

    # player_hand が 3 なら :exit を返して終了
    if player_hand == EXIT_CHOICE
      return :exit
    end
    # ランダムな数値を opponent_hand に格納
    opponent_hand = rand(HANDS.length) 
    
    puts "-------------"
    puts "あなた：#{hand_name(player_hand)}"
    puts "相手：#{hand_name(opponent_hand)}"

    # judge_janken に player_hand と opponent_hand を渡して、戻り値を result に格納
    result = judge_janken(player_hand, opponent_hand)
    
    # result を case 文で分岐
    case result
    when :win
      puts "あなたの勝ちです！"
      puts "あっち向いてホイであなたが指をさします"
      return :win
    when :lose
      puts "あなたの負けです..."
      puts "あっち向いてホイで顔を向ける方向を決めます"
      return :lose
    when :draw
      puts "あいこです"
    end
    puts "-------------"
  end
end

#あっち向いてホイメソッド
def acchi_muite_hoi(janken_result)
  puts "-------------"
  puts "あっち向いて〜"
  puts "0（上）1（下）2（右）3（左）"

  player_direction = validate_input(0..3)
  opponent_direction = rand(DIRECTIONS.length)
  puts "-------------"
  puts "ホイ！" 
  puts "あなた：#{direction_name(player_direction)}"
  puts "相手：#{direction_name(opponent_direction)}"
  # あっち向いてホイ判定メソッドに playerの方向 と opponentの方向 を渡して、戻り値を match に格納
  match = judge_acchi_muite_hoi(player_direction, opponent_direction)
  
  if match
    if janken_result == :win
      puts "あなたの勝ちです！"
    else
      puts "あなたの負けです..."
    end
      true
  else
    puts "セーフ！もう一度じゃんけんから"
    return false  
  end
end

round_count = 0
loop do
  round_count += 1
  janken_result = play_janken
  if janken_result == :exit
    puts "バイバイ！"
    break
  end
  settled = acchi_muite_hoi(janken_result)
  if settled
    puts "#{round_count}回目で決着がつきました！"
    break
  end     
end
