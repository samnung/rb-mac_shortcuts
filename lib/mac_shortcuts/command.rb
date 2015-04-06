# encoding: utf-8

require 'claide'

module MacShortcuts
  class PlainInformative < StandardError
    include CLAide::InformativeError

    def message
      "[!] #{super}".red
    end
  end

  class Command < CLAide::Command
    require_relative 'command/set'

    self.abstract_command = true
    self.command = 'mac_shortcuts'
    self.version = VERSION
    self.description = 'Command line tool to modify custom shortcuts in Mac applications.'
    self.plugin_prefixes = plugin_prefixes + %w(mac_shortcuts)
  end
end
