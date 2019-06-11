module ScheduleTask

  def self.add_entries
    body =
      "河川敷クリーナーズ見事勝利！ということで、\n\n" +
      "祝勝会を都内某所にて行ってきました。" +
      "皆さんと焼肉を美味しく頂きました。" +
      "チームの調子がいいのは嬉しいのですが、\n\n" +
      "財布の調子はあまりよくありません、、、笑"

    %w(Taro Jiro Hana).each do |name|
      member = Member.find_by(name: name)
      0.upto(3) do |idx|
        entry = Entry.create(
          author: member,
          title: "河川敷クリーナーズ勝利#{idx}",
          body: body,
          posted_at: 10.days.ago.advance(days: idx),
          status: %w(draft member_only public)[idx % 3]
        )
      end
    end
  end

end
