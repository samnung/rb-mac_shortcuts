
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

      # use Spotlight to find applications
      apps_paths = `mdfind "#{query}.app"`.split("\n")

      # filter out not application results
      apps_paths.select! do |path|
        path.end_with?('.app')
      end

      founded = process_apps_paths(apps_paths)

      founded
    end

    private


    # @return [String] base path for user application preferences
    #
    def self.preferences_path
      @preferences_path ||= File.join(Dir.home, 'Library', 'Preferences')
    end

    # @param [Array<String>] apps_paths paths to applications folder
    #
    # @return [Array<String>] preference paths of input applications
    #
    def self.process_apps_paths(apps_paths)
      apps_paths.map do |app_path|
        preferences_path_of(app_path)
      end
    end

    # @param [String] app_path path to application folder
    #
    # @return [String] preference path of input application
    #
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
