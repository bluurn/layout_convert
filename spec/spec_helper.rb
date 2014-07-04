require "codeclimate-test-reporter"
ENV['CODECLIMATE_REPO_TOKEN'] = "51960221e8151ad9b40733ea47d536f89f5da3f418b350297c06f23e45f11e14"
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
]
CodeClimate::TestReporter.start
