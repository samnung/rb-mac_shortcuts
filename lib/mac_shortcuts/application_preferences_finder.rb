
require 'rake'


module MacShortcuts
  class ApplicationPreferencesFinder
    # @param [String] query
    #
    # @return [Array<String>] paths to preferences file
    #
    def self.find_with_query(query)
      founded = Dir[File.join(preferences_path, "*.#{query}.plist")]

      if founded.empty?
        founded = Dir["/Applications/#{query}.app"].map do |app_path|
          preferences_path_of(app_path)
        end
      end

      if founded.empty?
        founded = `mdfind "#{query}.app"`.split("\n").select { |path| path.end_with?('.app') }.map do |app_path|
          preferences_path_of(app_path)
        end
      end

      founded
    end

    private

    def self.preferences_path
      @preferences_path ||= File.join(Dir.home, 'Library', 'Preferences')
    end

    def self.preferences_path_of(app_path)
      File.join(preferences_path, "#{self.bundle_identifier_of(app_path)}.plist")
    end

    # @param [String] app_path path to application folder, example: '/Applications/Messages.app'
    #
    # @return [String, nil] bundle identifier of that application
    #
    def self.bundle_identifier_of(app_path)
      plist_path = "#{app_path}/Contents/Info.plist"
      `/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "#{plist_path}"`.chomp
    end
  end
end
