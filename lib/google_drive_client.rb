require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'

class GoogleDriveClient
  include Singleton

  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
  CREDENTIALS_PATH = Rails.root + 'config/google_drive_credentials.json'
  TOKEN_PATH = Pathname.new Rails.root + 'config/google_drive_token.yaml'
  SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS
  APPLICATION_NAME = 'Baseball CMS'.freeze

  def initialize
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
  end

  def authorize
    FileUtils.mkdir TOKEN_PATH.parent unless TOKEN_PATH.parent.exist?
    client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
    token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
    authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
    user_id = 'default'
    credentials = authorizer.get_credentials user_id
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts 'Open the following URL in the browser and enter the ' \
           "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def update_sheets(data, spreadsheet_id:, sheet_name: nil)
    value_range = Google::Apis::SheetsV4::ValueRange.new
    value_range.range = "#{sheet_name}!A1:ZZ"
    value_range.values = data
    @service.clear_values spreadsheet_id, value_range.range
    @service.update_spreadsheet_value spreadsheet_id, value_range.range, value_range, value_input_option: 'USER_ENTERED'
  end
end
