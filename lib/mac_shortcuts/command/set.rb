# encoding: utf-8

require_relative '../command'

module MacShortcuts
  class Set < Command
    self.summary = 'Set shortcut for application.'
    self.arguments = [
        CLAide::Argument.new(%w(APPLICATION PLIST_FILE), true, false),
        CLAide::Argument.new(%w(MENU_TITLE), true, false),
        CLAide::Argument.new(%w(SHORTCUT), true, false),
    ]

    def initialize(argv)
      @application = argv.shift_argument
      @menu_title = argv.shift_argument
      @shortcut_str = argv.shift_argument

      super
    end

    def validate!
      super

      help! 'You must specify APPLICATION or PLIST_FILE' if @application.nil?
      help! 'You must specify MENU_TITLE' if @menu_title.nil?
      help! 'You must specify SHORTCUT' if @shortcut_str.nil?
    end

    def run
      shortcut = Shortcut.from_pretty(@shortcut_str)

      ret = system(%{defaults write "#{@application}" NSUserKeyEquivalents -dict-add "#{@menu_title}" -string "#{shortcut.to_code}"})
      unless ret
        exit 1
      end

      puts 'Shortcut was set, now restart application to take effect.'
    end
  end
end
