module BlingFire
  class Model
    def initialize(path = nil, prefix: nil)
      @handle = nil
      if path
        raise Error, "Model not found" unless File.exist?(path)
        @handle = FFI.LoadModel(path)
        ObjectSpace.define_finalizer(self, self.class.finalize(@handle))

        BlingFire.change_settings_dummy_prefix(@handle, prefix) unless prefix.nil?
      else
        raise Error, "prefix option requires path" unless prefix.nil?
      end
    end

    def text_to_words(text)
      if @handle
        BlingFire.text_to_words_with_model(@handle, text)
      else
        BlingFire.text_to_words(text)
      end
    end

    def text_to_words_with_offsets(text)
      if @handle
        BlingFire.text_to_words_with_offsets_with_model(@handle, text)
      else
        BlingFire.text_to_words_with_offsets(text)
      end
    end

    def text_to_sentences(text)
      if @handle
        BlingFire.text_to_sentences_with_model(@handle, text)
      else
        BlingFire.text_to_sentences(text)
      end
    end

    def text_to_sentences_with_offsets(text)
      if @handle
        BlingFire.text_to_sentences_with_offsets_with_model(@handle, text)
      else
        BlingFire.text_to_sentences_with_offsets(text)
      end
    end

    def text_to_ids(text, max_len = nil, unk_id = 0)
      if @handle
        BlingFire.text_to_ids(@handle, text, max_len, unk_id)
      else
        raise "Not implemented"
      end
    end

    def text_to_ids_with_offsets(text, max_len = nil, unk_id = 0)
      if @handle
        BlingFire.text_to_ids_with_offsets(@handle, text, max_len, unk_id)
      else
        raise "Not implemented"
      end
    end

    def ids_to_text(ids, skip_special_tokens: true, output_buffer_size: nil)
      if @handle
        BlingFire.ids_to_text(@handle, ids, skip_special_tokens: skip_special_tokens, output_buffer_size: output_buffer_size)
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
