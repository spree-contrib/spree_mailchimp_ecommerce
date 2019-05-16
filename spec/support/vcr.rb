require "vcr"

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
end
