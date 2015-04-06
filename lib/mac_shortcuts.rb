
module MacShortcuts
  require_relative 'mac_shortcuts/version'

  require 'bundler/setup'

  autoload :Shortcut, 'mac_shortcuts/shortcut'
  autoload :Command, 'mac_shortcuts/command'
  autoload :ApplicationPreferencesFinder, 'mac_shortcuts/application_preferences_finder'
end
