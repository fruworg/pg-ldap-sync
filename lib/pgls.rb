require "pgls/application"
require "pgls/compat"
require "pgls/version"

module PgLdapSync
  class LdapError < RuntimeError
  end

  class ApplicationExit < RuntimeError
    attr_reader :exitcode

    def initialize(exitcode, error=nil)
      super(error)
      @exitcode = exitcode
    end
  end

  class InvalidConfig < ApplicationExit
  end

  class ErrorExit < ApplicationExit
  end
end
