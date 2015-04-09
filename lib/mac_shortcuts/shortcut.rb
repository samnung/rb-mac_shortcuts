
module MacShortcuts
  class Shortcut
    attr_accessor :command
    attr_accessor :shift
    attr_accessor :control
    attr_accessor :alt
    attr_accessor :key

    PRETTY_MAP = {
        command: %w(⌘ @ cmd command),
        alt:     %w(⌥ ~ alt option),
        shift:   %w(⇧ $ shift),
        control: %w(^ ^ ctrl control),
    }.freeze

    CODE_MAP = PRETTY_MAP.map { |key, values|
      [key, values[1]]
    }.freeze

    KEYS_MAP = {
          left: %w(← left),
         right: %w(→ right),
           top: %w(↑ top),
        bottom: %w(↓ bottom),
         enter: %w(↩ enter return),
    }


    def initialize
      @command = @shift = @control = @alt = false
      @key = nil
    end


    # @param [String] shortcut_str
    #
    def self.from_code(shortcut_str)
      inst = self.new
      CODE_MAP.each do |key, value|
        inst.send("#{key}=", shortcut_str.include?(value))
      end
      inst.key = shortcut_str[-1]
      inst
    end

    # @param [String] shortcut_str
    #
    def self.from_pretty(shortcut_str)
      inst = self.new
      components = components_from_pretty(shortcut_str)
      components.each do |cmp|
        case cmp
        when String
          inst.key = cmp
        when Symbol
          inst.send("#{cmp}=", true)
        end
      end
      inst
    end


    def to_s
      components = []
      PRETTY_MAP.each do |key, value|
        components << value.first if self.send(key)
      end
      components << @key if @key
      components.join(' + ')
    end

    def to_code
      components = []
      CODE_MAP.each do |key, value|
        components << value if self.send(key)
      end
      components << @key if @key
      components.join
    end

    private

    # @param cmp [String]
    #
    # @return [Symbol, nil]
    #
    def self.key_for_pretty(map, cmp)
      key = nil
      map.each do |curr_key, values|
        if values.include?(cmp)
          key = curr_key
          break
        end
      end
      key
    end

    # @param str [String]
    #
    # @return [Array<Symbol, String>]
    #
    def self.components_from_pretty(str)
      components = str.split(/( |\+)/)
      components.reject! { |cmp| cmp.strip.empty? }
      components.reject! { |cmp| cmp == '+' }
      last = components.pop

      last_key = key_for_pretty(KEYS_MAP, last)

      correct_last = if last_key.nil?
                       last
                     else
                       KEYS_MAP[last_key].first
                     end

      components.map! do |cmp|
        key = key_for_pretty(PRETTY_MAP, cmp)
        if key.nil?
          raise "Unknown text for #{cmp}"
        end
        key
      end
      components + [correct_last]
    end
  end
end
