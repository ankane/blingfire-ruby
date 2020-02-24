module BlingFire
  module FFI
    extend Fiddle::Importer

    libs = Array(BlingFire.ffi_lib).dup
    begin
      dlload Fiddle.dlopen(libs.shift)
    rescue Fiddle::DLError => e
      retry if libs.any?
      raise e
    end

    extern "int GetBlingFireTokVersion()"
    extern "void* LoadModel(char * pszLdbFileName)"
    extern "int FreeModel(void* ModelPtr)"
    extern "int TextToWordsWithModel(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount, void * hModel)"
    extern "int TextToWords(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount)"
    extern "int TextToIds(void* ModelPtr, char * pInUtf8Str, int InUtf8StrByteCount, int32_t * pIdsArr, int MaxIdsArrLength, int UnkId)"
    extern "int TextToSentences(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount)"
    extern "int TextToSentencesWithModel(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount, void * hModel)"
  end
end
