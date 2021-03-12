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

  url = "https://github.com/ankane/ml-builds/releases/download/blingfire-0.1.3/#{file}"
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
    download_file("libblingfiretokdll.so", "b1d557405ec061b412e725b94141086d7120adec7a2291fde61d635557e62272")
    download_file("libblingfiretokdll.arm64.so", "bbed6967b00e24ee533205a6b7dea4d297c8cdabfa4aad2e31fe11212b474377")
  end

  task :mac do
    download_file("libblingfiretokdll.dylib", "51fe6ab0ee0d4f9de7531be9ea36d5c44557f8fe29539413287dd2b9e11b863c")
    download_file("libblingfiretokdll.arm64.dylib", "22e12e3f57aa2205745cea27469a0ed5a090255256914be2c58cf527fbd8c10a")
  end

  task :windows do
    download_file("blingfiretokdll.dll", "155ada310a0dbbb3f3646e7b3c5d4f366eb933a2efa957c4752e47da72997700")
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
