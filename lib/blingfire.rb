# stdlib
require "fiddle/import"

# modules
require "blingfire/model"
require "blingfire/version"

module BlingFire
  class Error < StandardError; end

  class << self
    attr_accessor :ffi_lib
  end
  lib_name =
    if Gem.win_platform?
      "blingfiretokdll.dll"
    elsif RbConfig::CONFIG["host_os"] =~ /darwin/i
      "libblingfiretokdll.dylib"
    else
      "libblingfiretokdll.so"
    end
  vendor_lib = File.expand_path("../vendor/#{lib_name}", __dir__)
  self.ffi_lib = [vendor_lib]

  # friendlier error message
  autoload :FFI, "blingfire/ffi"

  class << self
    def lib_version
      FFI.GetBlingFireTokVersion
    end

    def load_model(path)
      Model.new(path)
    end

    def text_to_words(text)
      text = encode_utf8(text.dup) unless text.encoding == Encoding::UTF_8
      out = Fiddle::Pointer.malloc(text.bytesize * 3)
      out_size = FFI.TextToWords(text, text.bytesize, out, out.size)
      check_status out_size
      str_arr(out, out_size, " ")
    end

    def text_to_words_with_model(model, text)
      text = encode_utf8(text.dup) unless text.encoding == Encoding::UTF_8
      out = Fiddle::Pointer.malloc(text.bytesize * 3)
      out_size = FFI.TextToWordsWithModel(text, text.bytesize, out, out.size, model)
      check_status out_size
      str_arr(out, out_size, " ")
    end

    def text_to_sentences(text)
      text = encode_utf8(text.dup) unless text.encoding == Encoding::UTF_8
      out = Fiddle::Pointer.malloc(text.bytesize * 3)
      out_size = FFI.TextToSentences(text, text.bytesize, out, out.size)
      check_status out_size
      str_arr(out, out_size, "\n")
    end

    def text_to_sentences_with_model(model, text)
      text = encode_utf8(text.dup) unless text.encoding == Encoding::UTF_8
      out = Fiddle::Pointer.malloc(text.bytesize * 3)
      out_size = FFI.TextToSentencesWithModel(text, text.bytesize, out, out.size, model)
      check_status out_size
      str_arr(out, out_size, "\n")
    end

    def text_to_ids(model, text, max_len = nil, unk_id = 0)
      text = encode_utf8(text.dup) unless text.encoding == Encoding::UTF_8
      ids = Fiddle::Pointer.malloc((max_len || text.size) * Fiddle::SIZEOF_INT)
      out_size = FFI.TextToIds(model, text, text.bytesize, ids, ids.size, unk_id)
      check_status out_size
      ids[0, (max_len || out_size) * Fiddle::SIZEOF_INT].unpack("i!*")
    end

    def free_model(model)
      FFI.FreeModel(model)
    end

    private

    def check_status(ret)
      raise Error, "Bad status" if ret == -1
    end

    def str_arr(out, out_size, sep)
      encode_utf8(out.to_str(out_size - 1)).split(sep)
    end

    def encode_utf8(text)
      text.force_encoding(Encoding::UTF_8)
    end
  end
end
