module Padrino
  PADRINO_IGNORE_CALLERS = [
    %r{/padrino-.*$},            # all padrino code
    %r{/sinatra},                # all sinatra code
    %r{lib/tilt.*\.rb$},         # all tilt code
    %r{\(.*\)},                  # generated code
    %r{shoulda/context\.rb$},    # shoulda hacks
    %r{mocha/integration},       # mocha hacks
    %r{test/unit},               # test unit hacks
    %r{rake_test_loader\.rb},    # rake hacks
    %r{custom_require\.rb$},     # rubygems require hacks
    %r{active_support},          # active_support require hacks
    %r{/thor},                   # thor require hacks
  ]

  # add rubinius (and hopefully other VM impls) ignore patterns ...
  PADRINO_IGNORE_CALLERS.concat(RUBY_IGNORE_CALLERS) if defined?(RUBY_IGNORE_CALLERS)

  # Returns the filename for the file that is the direct caller (first caller)
  def self.first_caller
    caller_files.first
  end

  # Like Kernel#caller but excluding certain magic entries and without
  # line / method information; the resulting array contains filenames only.
  def self.caller_files
    caller_locations.map { |file,line| file }
  end

  def self.caller_locations
    caller(1).
      map    { |line| line.split(/:(?=\d|in )/)[0,2] }.
      reject { |file,line| PADRINO_IGNORE_CALLERS.any? { |pattern| file =~ pattern } }
  end
end