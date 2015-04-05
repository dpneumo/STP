require 'rake/testtask'
require 'pry'

Rake::TestTask.new do |t|
  t.libs = ["lib", "tests"]
  t.warning = false
  t.verbose = true
  t.test_files = FileList['tests/*_test.rb']
end
