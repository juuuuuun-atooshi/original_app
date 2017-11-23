class ParticipantsController < ApplicationController
  def participation
    @event = Event.find(params[:format])
  end

  def create
    @participant = Participant.create(event_id: params[:id], participant_id: current_user.id)

    if @participant.save
      redirect_to root_path, notice: "イベント参加が完了しました！"
    else
      redirect_to root_path, notice: "参加登録中に異常がありました。。。御手数ですが、初めからやり直してください。"
    end
  end

end
