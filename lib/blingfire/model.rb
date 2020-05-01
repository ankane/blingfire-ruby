module BlingFire
  class Model
    def initialize(path = nil)
      if path
        raise Error, "Model not found" unless File.exist?(path)
        @handle = FFI.LoadModel(path)
        ObjectSpace.define_finalizer(self, self.class.finalize(@handle))
      end
    end

    def text_to_words(text)
      if @handle
        BlingFire.text_to_words_with_model(@handle, text)
      else
        BlingFire.text_to_words(text)
      end
    end

    def text_to_sentences(text)
      if @handle
        BlingFire.text_to_sentences_with_model(@handle, text)
      else
        BlingFire.text_to_sentences(text)
      end
    end

    def text_to_ids(text, max_len = nil, unk_id = 0)
      if @handle
        BlingFire.text_to_ids(@handle, text, max_len, unk_id)
      else
        raise "Not implemented"
      end
    end

    def to_ptr
      @handle
    end

    def self.finalize(pointer)
      # must use proc instead of stabby lambda
      proc { FFI.FreeModel(pointer) }
    end
  end
end
