require "bundler/gem_tasks"
require "rake/testtask"

task default: :test
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end

shared_libraries = %w(libblingfiretokdll.so libblingfiretokdll.dylib blingfiretokdll.dll)

# ensure vendor files exist
task :ensure_vendor do
  shared_libraries.each do |file|
    raise "Missing file: #{file}" unless File.exist?("vendor/#{file}")
  end
end

Rake::Task["build"].enhance [:ensure_vendor]

def download_file(file, sha256)
  require "open-uri"

  url = "https://github.com/ankane/ml-builds/releases/download/blingfire-0.1.7/#{file}"
  puts "Downloading #{file}..."
  contents = URI.open(url).read

  computed_sha256 = Digest::SHA256.hexdigest(contents)
  raise "Bad hash: #{computed_sha256}" if computed_sha256 != sha256

  dest = "vendor/#{file}"
  File.binwrite(dest, contents)
  puts "Saved #{dest}"
end

namespace :vendor do
  task :linux do
    download_file("libblingfiretokdll.so", "2a37cfeef4b16ee37b5f54ad4c497c64aa7ae1dc3b9427eb3ba32921dafeb5fb")
    download_file("libblingfiretokdll.arm64.so", "fc141c270a3cdb378a8e586d6ad6bed8f7b694b8f371adfcce58de7ca20eb15f")
  end

  task :mac do
    download_file("libblingfiretokdll.dylib", "c8c28d815831c553cc21ca8ff279059e69a2440cc2843d74dda5223578187ee3")
    download_file("libblingfiretokdll.arm64.dylib", "49fae9d5fe7c2dd13961fcd05fdc3e619f43d3962a80695d507513b196c6766f")
  end

  task :windows do
    download_file("blingfiretokdll.dll", "28b1a24988b2175c760d4b551fd6ad2bfc4c7dad4df5522e87722007090567f9")
  end

  task all: [:linux, :mac, :windows]

  task :platform do
    if Gem.win_platform?
      Rake::Task["vendor:windows"].invoke
    elsif RbConfig::CONFIG["host_os"] =~ /darwin/i
      Rake::Task["vendor:mac"].invoke
    else
      Rake::Task["vendor:linux"].invoke
    end
  end
end

namespace :download do
  task :models do
    require "open-uri"
    require "fileutils"

    ["wbd_chuni.bin", "bert_base_tok.bin", "xlnet.bin", "roberta.bin"].each do |file|
      url = "https://github.com/microsoft/BlingFire/raw/master/dist-pypi/blingfire/#{file}"
      puts "Downloading #{file}..."
      FileUtils.mkdir_p("test/support")
      dest = "test/support/#{file}"
      File.binwrite(dest, URI.open(url).read)
      puts "Saved #{dest}"
    end
  end
end
