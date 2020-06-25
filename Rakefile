require "bundler/gem_tasks"
require "rake/testtask"

task default: :test
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.warning = false
end

shared_libraries = %w(libblingfiretokdll.so libblingfiretokdll.dylib blingfiretokdll.dll)

# ensure vendor files exist
task :ensure_vendor do
  shared_libraries.each do |file|
    raise "Missing file: #{file}" unless File.exist?("vendor/#{file}")
  end
end

Rake::Task["build"].enhance [:ensure_vendor]

def download_file(file)
  require "open-uri"

  url = "https://github.com/ankane/ml-builds/releases/download/blingfire-0.1.3/#{file}"
  puts "Downloading #{file}..."
  dest = "vendor/#{file}"
  File.binwrite(dest, URI.open(url).read)
  puts "Saved #{dest}"
end

namespace :vendor do
  task :linux do
    download_file("libblingfiretokdll.so")
  end

  task :mac do
    download_file("libblingfiretokdll.dylib")
  end

  task :windows do
    download_file("blingfiretokdll.dll")
  end

  task all: [:linux, :mac, :windows]
end

namespace :download do
  task :models do
    require "open-uri"
    require "fileutils"

    ["wbd_chuni.bin", "bert_base_tok.bin", "xlnet.bin"].each do |file|
      url = "https://github.com/microsoft/BlingFire/raw/master/dist-pypi/blingfire/#{file}"
      puts "Downloading #{file}..."
      FileUtils.mkdir_p("test/support")
      dest = "test/support/#{file}"
      File.binwrite(dest, URI.open(url).read)
      puts "Saved #{dest}"
    end
  end
end
