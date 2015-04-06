
require 'rake'


module MacShortcuts
  class ApplicationPreferencesFinder
    # @param [String] query
    #
    # @return [Array<String>] paths to preferences file
    #
    def self.find_with_query(query)
      founded = Dir[File.join(preferences_path, "*.#{query}.plist")]

      return founded unless founded.empty?

      apps_dirs_paths = [
          '/Applications',
          File.join(Dir.home, 'Applications'),
      ]

      apps_dirs_paths.each do |apps_path|
        founded = process_apps_paths(Dir[File.join(apps_path, "#{query}.app")])
        return founded unless founded.empty?
      end

      return founded unless founded.empty?

      founded = process_apps_paths(`mdfind "#{query}.app"`.split("\n").select { |path| path.end_with?('.app') })

      founded
    end

    private

    def self.preferences_path
      @preferences_path ||= File.join(Dir.home, 'Library', 'Preferences')
    end

    def self.process_apps_paths(apps_paths)
      apps_paths.map do |app_path|
        preferences_path_of(app_path)
      end
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
