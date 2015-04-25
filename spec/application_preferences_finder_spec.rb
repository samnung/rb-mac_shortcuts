
require_relative 'spec_helper'

describe MacShortcuts::ApplicationPreferencesFinder do
  context '#find_with_query' do
    preferences_path = File.join(Dir.home, 'Library', 'Preferences')

    context 'application name' do
      applications = {
          'Terminal' => 'com.apple.Terminal.plist',
          'Safari' => 'com.apple.Safari.plist',
          'Messages' => 'com.apple.iChat.plist',
      }

      it 'can find all applications' do
        applications.each do |app_name, preferences_file_name|
          path = MacShortcuts::ApplicationPreferencesFinder.find_with_query(app_name)
          expect(path).to eq([File.join(preferences_path, preferences_file_name)])
        end
      end
    end
  end
end
