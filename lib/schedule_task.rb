module ScheduleTask

  def self.export_members
    data = [['背番号', 'ユーザー名', '氏名', 'メールアドレス', '誕生日', '性別', '出身地']]
    Member.all.decorate.each do |member|
      data << [
        member.number,
        member.name,
        member.full_name,
        member.email,
        member.birthday,
        member.show_sex,
        member.prefecture.name
      ]
    end
    GoogleDriveClient.instance.update_sheets data, spreadsheet_id: "#{Rails.application.credentials.dig(:spread_sheet_id)}", sheet_name: 'メンバー一覧'
  end

end
