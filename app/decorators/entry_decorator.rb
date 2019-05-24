class EntryDecorator < Draper::Decorator

  delegate_all

  def self.status_text(status)
    I18n.t("activerecord.attributes.entry.status_#{status}")
  end

  def self.status_options
    STATUS_VALUES.map { |status| [status_text(status), status] }
  end

end
