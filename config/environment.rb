require 'bundler'
require 'pry'
Bundler.require

module Concerns
  require_all 'lib/concerns'
end

require_all 'lib'
