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

  url = "https://github.com/ankane/ml-builds/releases/download/blingfire-0.1.5/#{file}"
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
    download_file("libblingfiretokdll.so", "9aa1d3781a413968a8b56d7bd683f84b534bfac768cad73de2735d5121107018")
    download_file("libblingfiretokdll.arm64.so", "6ecc1acee622806545283a2d671554477c3a583781806194d17668d41ed67d35")
  end

  task :mac do
    download_file("libblingfiretokdll.dylib", "ef299a3f52fdcbb1628a6511073b98285a3977ebd5c926bf66230162f74e17be")
    download_file("libblingfiretokdll.arm64.dylib", "bba3534f2ad8171214f0a23fc73f5332587d15ab1032ab9a58705e3eacad05c4")
  end

  task :windows do
    download_file("blingfiretokdll.dll", "6ed448dec31f33417957488fd9ef522210007fa81232804c33287a1721ad9a2f")
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
