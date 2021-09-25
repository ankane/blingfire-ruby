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

    typealias "bool", "char"

    # https://github.com/microsoft/BlingFire/blob/master/blingfiretools/blingfiretokdll/blingfiretokdll.cpp

    # version
    extern "int GetBlingFireTokVersion()"

    # text to sentences
    extern "int TextToSentencesWithOffsetsWithModel(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int * pStartOffsets, int * pEndOffsets, int MaxOutUtf8StrByteCount, void * hModel)"
    extern "int TextToSentencesWithOffsets(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int * pStartOffsets, int * pEndOffsets, int MaxOutUtf8StrByteCount)"
    extern "int TextToSentencesWithModel(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount, void * hModel)"
    extern "int TextToSentences(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount)"

    # text to words
    extern "int TextToWordsWithOffsetsWithModel(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int * pStartOffsets, int * pEndOffsets, int MaxOutUtf8StrByteCount, void * hModel)"
    extern "int TextToWordsWithOffsets(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int * pStartOffsets, int * pEndOffsets, int MaxOutUtf8StrByteCount)"
    extern "int TextToWordsWithModel(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount, void * hModel)"
    extern "int TextToWords(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount)"

    # misc
    extern "int NormalizeSpaces(char * pInUtf8Str, int InUtf8StrByteCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount, int uSpace)"
    extern "int TextToHashes(char * pInUtf8Str, int InUtf8StrByteCount, int32_t * pHashArr, int MaxHashArrLength, int wordNgrams, int bucketSize)"

    # model
    extern "void* LoadModel(char * pszLdbFileName)"

    # text to ids
    extern "int TextToIdsWithOffsets(void* ModelPtr, char * pInUtf8Str, int InUtf8StrByteCount, int32_t * pIdsArr, int * pStartOffsets, int * pEndOffsets, int MaxIdsArrLength, int UnkId)"
    extern "int TextToIds(void* ModelPtr, char * pInUtf8Str, int InUtf8StrByteCount, int32_t * pIdsArr, int MaxIdsArrLength, int UnkId)"

    # free model
    extern "int FreeModel(void* ModelPtr)"

    # prefix
    extern "int SetNoDummyPrefix(void* ModelPtr, bool fNoDummyPrefix)"

    # ids to text
    extern "int IdsToText(void* ModelPtr, int32_t * pIdsArr, int IdsCount, char * pOutUtf8Str, int MaxOutUtf8StrByteCount, bool SkipSpecialTokens)"
  end
end
