#!/usr/bin/env ruby

module Util
    ReplaceableLine = Struct.new(:original_prefix, :modified_line)
end