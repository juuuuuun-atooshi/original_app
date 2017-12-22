class NoticeMailer < ApplicationMailer

  def sendmail_contact(contact)
    @contact = contact

    mail(
      to: @contact.email,
      subject: '問い合わせありがとうございます。'
    ) do |format|
      format.text
    end
  end

  def sendmail_contact_admin(contact)
    @contact = contact

    mail(
      to: ENV['ADMIN_ADDRESS'],
      subject: '利用者様より問い合わせがありました。'
    ) do |format|
      format.text
    end
  end

  def sendmail_participant(event, user, artist, participant)
    @event = event
    @user = user
    @artist = artist
    @participant = participant
    mail(
      to: @user.email,
      subject: 'イベント参加ありがとうございます！'
    ) do |format|
      format.text
    end
  end

end
