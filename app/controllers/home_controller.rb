class HomeController < ApplicationController
  def index
    @own_notes = if current_user.present?
                   current_user.notes.includes(:comments)
                 else
                   []
                 end
  end

  def help; end

  def tutorial_top; end

  def tutorial_note_index
    @own_notes = if current_user.present?
                   current_user.notes.all
                 else
                   []
                 end
  end

  def tutorial_note
    @own_notes = if current_user.notes.present?
                   current_user.notes
                 else
                   []
                 end
  end

  def tutorial_create_f_item
    @favorite_item = current_user.favorite_items.new
    @favorite_items = current_user.favorite_items.all
    @A_line = []
    @K_line = []
    @S_line = []
    @T_line = []
    @N_line = []
    @H_line = []
    @M_line = []
    @Y_line = []
    @R_line = []
    @W_line = []
    @other_line = []
    @favorite_items.each do |item|
      # i_initial = NKF.nkf('-h1 -w', item.name[0]).tr('A-Z0-9', 'Ａ-Ｚ０-９')
      # case i_initial
      # when "あ","い","う","え","お","a","i","u","e","o","A","I","U","E","O",
      #   @A_line << item
      # when "か","き","く","け","こ","が","ぎ","ぐ","げ","ご","c","k","q","C","K","Q",
      #   @K_line << item
      # else
      #   @other_line << item
      # end
      initial = NKF.nkf('-h1 -w', item.name[0]).tr('Ａ-Ｚ０-９','A-Z0-9').downcase

      case initial
      when "あ","い","う","え","お","a","i","u","e","o"
        @A_line << item
      when "か","き","く","け","こ","が","ぎ","ぐ","げ","ご","c","k","q"
        @K_line << item
      when "さ","し","す","せ","そ","ざ","じ","ず","ぜ","ぞ","s","z"
        @S_line << item
      when "た","ち","つ","て","と","だ","ぢ","づ","で","ど","t","d"
        @T_line << item
      when "な","に","ぬ","ね","の","n"
        @N_line << item
      when "は","ひ","ふ","へ","ほ","ば","び","ぶ","べ","ぼ","ぱ","ぴ","ぷ","ぺ","ぽ","h","b","p"
        @H_line << item
      when "ま","み","む","め","も","m"
        @M_line << item
      when "や","ゆ","よ","y"
        @Y_line << item
      when "ら","り","る","れ","ろ","r","l"
        @R_line << item
      when "わ","を","ん","w"
        @W_line << item
      else
        @other_line << item
      end


      # if [あ い う え お a i u e o].include?(i_initial)
      #   @A_line << item
      # elsif %w[か き く け こ が ぎ ぐ げ ご c k q C K Q].include?(i_initial)
      #   @K_line << item
      # elsif %w[さ し す せ そ ざ じ ず ぜ ぞ s z S Z].include?(i_initial)
      #   @S_line << item
      # elsif %w[た ち つ て と だ ぢ づ で ど t d T D].include?(i_initial)
      #   @T_line << item
      # elsif %w[な に ぬ ね の n N].include?(i_initial)
      #   @N_line << item
      # elsif %w[は ひ ふ へ ほ ば び ぶ べ ぼ h b H B].include?(i_initial)
      #   @H_line << item
      # elsif %w[ま み む め も m M].include?(i_initial)
      #   @M_line << item
      # elsif %w[や ゆ よ y Y].include?(i_initial)
      #   @Y_line << item
      # elsif %w[ら り る れ ろ l r L R].include?(i_initial)
      #   @R_line << item
      # elsif %w[わ を ん].include?(i_initial)
      #   @W_line << item
      # else
      #   @other_line << item
      # end

    end
  end

  def tutorial_index_f_item
    @favorite_items = current_user.favorite_items.all
    @A_line = []
    @K_line = []
    @S_line = []
    @T_line = []
    @N_line = []
    @H_line = []
    @M_line = []
    @Y_line = []
    @R_line = []
    @W_line = []
    @other_line = []

    @favorite_items.each do |item|
      i_initial = NKF.nkf('-h1 -w', item.name[0]).tr('A-Z0-9', 'Ａ-Ｚ０-９')
      if %w[あ い う え お a i u e o A I U E O].include?(i_initial)
        @A_line << item
      elsif %w[か き く け こ が ぎ ぐ げ ご c k q C K Q].include?(i_initial)
        @K_line << item
      elsif %w[さ し す せ そ ざ じ ず ぜ ぞ s z S Z].include?(i_initial)
        @S_line << item
      elsif %w[た ち つ て と だ ぢ づ で ど t d T D].include?(i_initial)
        @T_line << item
      elsif %w[な に ぬ ね の n N].include?(i_initial)
        @N_line << item
      elsif %w[は ひ ふ へ ほ ば び ぶ べ ぼ h b H B].include?(i_initial)
        @H_line << item
      elsif %w[ま み む め も m M].include?(i_initial)
        @M_line << item
      elsif %w[や ゆ よ y Y].include?(i_initial)
        @Y_line << item
      elsif %w[ら り る れ ろ l r L R].include?(i_initial)
        @R_line << item
      elsif %w[わ を ん].include?(i_initial)
        @W_line << item
      else
        @other_line << item
      end
    end
  end

  def tutorial_group_SearchUser
    @group = Group.find(params[:id])
    @members = @group.group_members.where(activated: true)
  end
end
