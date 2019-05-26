class EntryDecorator < Draper::Decorator

  delegate_all

  def self.status_text(status)
    I18n.t("activerecord.attributes.entry.status_#{status}")
  end

  def self.status_options
    Entry::STATUS_VALUES.map { |status| [status_text(status), status] }
  end

  def posted_date
    posted_at.strftime('%Y/%m/%d %H:%M')
  end

end
