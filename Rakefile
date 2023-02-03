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

  url = "https://github.com/ankane/ml-builds/releases/download/blingfire-0.1.8/#{file}"
  puts "Downloading #{file}..."
  contents = URI.parse(url).read

  computed_sha256 = Digest::SHA256.hexdigest(contents)
  raise "Bad hash: #{computed_sha256}" if computed_sha256 != sha256

  dest = "vendor/#{file}"
  File.binwrite(dest, contents)
  puts "Saved #{dest}"
end

namespace :vendor do
  task :linux do
    download_file("libblingfiretokdll.so", "6e06cddbbb76f615b16e2feff3ab30f64f7132d9a9da59630ec713a11573934e")
    download_file("libblingfiretokdll.arm64.so", "65e337cc612282c983b75717f91c50bcaba26cb7b6697cfce18a1045a8accf1f")
  end

  task :mac do
    download_file("libblingfiretokdll.dylib", "e623b2d3d4b12be5533a647b21324fd05bbfd7dfc5918e0f82b5283f5dd34827")
    download_file("libblingfiretokdll.arm64.dylib", "dec6015e1b186f9d023f87bb530f16406520609c2b1dc28067cf9ed4327ecf20")
  end

  task :windows do
    download_file("blingfiretokdll.dll", "939e716ac90e78a53a2b7d2323c464795e8138ba64a72712c363c9cc02c6f3a6")
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

    ["wbd_chuni.bin", "bert_base_tok.bin", "xlnet.bin", "roberta.bin", "bert_base_cased_tok.i2w"].each do |file|
      url = "https://github.com/microsoft/BlingFire/raw/master/dist-pypi/blingfire/#{file}"
      puts "Downloading #{file}..."
      FileUtils.mkdir_p("test/support")
      dest = "test/support/#{file}"
      File.binwrite(dest, URI.parse(url).read)
      puts "Saved #{dest}"
    end
  end
end
