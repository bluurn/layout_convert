if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start
else
  require "codeclimate-test-reporter"
  ENV['CODECLIMATE_REPO_TOKEN'] = "51960221e8151ad9b40733ea47d536f89f5da3f418b350297c06f23e45f11e14"
  CodeClimate::TestReporter.start
end
