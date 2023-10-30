require_relative "test_helper"

class ModelTest < Minitest::Test
  def test_lib_version
    assert BlingFire.lib_version
  end

  def test_text_to_words
    text = "This is the Bling-Fire tokenizer"
    output = BlingFire.text_to_words(text)
    assert_equal "This is the Bling - Fire tokenizer", output.join(" ")
    assert_equal Encoding::UTF_8, output[0].encoding
  end

  def test_text_to_words_with_offsets
    text = "hello world!"
    output = BlingFire.text_to_words_with_offsets(text)
    assert_equal [["hello", "world", "!"], [0, 6, 11], [5, 11, 12]], output
  end

  def test_text_to_words_with_offsets_utf8
    text = "“ hello ”"
    output = BlingFire.text_to_words_with_offsets(text)
    assert_equal [["“", "hello", "”"], [0, 2, 8], [1, 7, 9]], output
  end

  def test_text_to_words_with_model
    model = BlingFire.load_model("test/support/wbd_chuni.bin")
    text = "This is the Bling-Fire tokenizer. 2007年9月日历表_2007年9月农历阳历一览表-万年历"

    expected = "This is the Bling - Fire tokenizer . 2007 年 9 月 日 历 表 _2007 年 9 月 农 历 阳 历 一 览 表 - 万 年 历"
    assert_equal expected, model.text_to_words(text).join(" ")

    expected = "This is the Bling - Fire tokenizer . 2007年9月日历表_2007年9月农历阳历一览表 - 万年历"
    assert_equal expected, BlingFire.text_to_words(text).join(" ")

    model.text_to_words_with_offsets(text)
    model.text_to_sentences_with_offsets(text)
  end

  def test_text_to_ids
    s = "Эpple pie. How do I renew my virtual smart card?: /Microsoft IT/ 'virtual' smart card certificates for DirectAccess are valid for one year. In order to get to microsoft.com we need to type pi@1.2.1.2."
    model = BlingFire.load_model("test/support/bert_base_tok.bin")

    expected = [1208, 9397, 2571, 11345, 1012, 2129, 2079, 1045, 20687, 2026, 7484, 6047, 4003, 1029, 1024, 1013, 7513, 2009, 1013, 1005, 7484, 1005, 6047, 4003, 17987, 2005, 3622, 6305, 9623, 2015, 2024, 9398, 2005, 2028, 2095, 1012, 1999, 2344, 2000, 2131, 2000, 7513, 1012, 4012, 2057, 2342, 2000, 2828, 14255, 1030, 1015, 1012, 1016, 1012, 1015, 1012, 1016, 1012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    assert_equal expected, model.text_to_ids(s, 128, 100)

    expected = [1208, 9397, 2571, 11345, 1012, 2129, 2079, 1045, 20687, 2026, 7484, 6047, 4003, 1029, 1024, 1013, 7513, 2009, 1013, 1005, 7484, 1005, 6047, 4003, 17987, 2005, 3622, 6305, 9623, 2015, 2024, 9398, 2005, 2028, 2095, 1012, 1999, 2344, 2000, 2131, 2000, 7513, 1012, 4012, 2057, 2342, 2000, 2828, 14255, 1030, 1015, 1012, 1016, 1012, 1015, 1012, 1016, 1012, 1208, 9397, 2571, 11345, 1012, 2129, 2079, 1045, 20687, 2026, 7484, 6047, 4003, 1029, 1024, 1013, 7513, 2009, 1013, 1005, 7484, 1005, 6047, 4003, 17987, 2005, 3622, 6305, 9623, 2015, 2024, 9398, 2005, 2028, 2095, 1012, 1999, 2344, 2000, 2131, 2000, 7513, 1012, 4012, 2057, 2342, 2000, 2828, 14255, 1030, 1015, 1012, 1016, 1012, 1015, 1012, 1016, 1012, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    assert_equal expected, model.text_to_ids(s + s, 128, 100)

    expected = [1208, 9397, 2571, 11345, 1012, 2129, 2079, 1045, 20687, 2026, 7484, 6047, 4003, 1029, 1024, 1013, 7513, 2009, 1013, 1005, 7484, 1005, 6047, 4003, 17987, 2005, 3622, 6305, 9623, 2015, 2024, 9398, 2005, 2028, 2095, 1012, 1999, 2344, 2000, 2131, 2000, 7513, 1012, 4012, 2057, 2342, 2000, 2828, 14255, 1030, 1015, 1012, 1016, 1012, 1015, 1012, 1016, 1012]
    assert_equal expected, model.text_to_ids(s)
  end

  def test_text_to_ids_with_offsets
    model = BlingFire.load_model("test/support/bert_base_tok.bin")
    text = "hello world!"
    output = model.text_to_ids_with_offsets(text)
    assert_equal [[7592, 2088, 999], [0, 6, 11], [5, 11, 12]], output
  end

  def test_text_to_sentences
    text = "In order to login to Café use pi@1.2.1.2. Split the data into train/test with a test size of 20% then use recurrent model (use LSTM or GRU)."

    expected = ["In order to login to Café use pi@1.2.1.2.", "Split the data into train/test with a test size of 20% then use recurrent model (use LSTM or GRU)."]
    assert_equal expected, BlingFire.text_to_sentences(text)

    expected = ["In order to login to Café use pi@1.2.1.2.", "Split the data into train/test with a test size of 20% then use recurrent model (use LSTM or GRU)."]
    assert_equal expected, BlingFire::Model.new.text_to_sentences(text)
  end

  def test_text_to_sentences_with_offsets
    text = "This is one sentence. Another sentence."
    output = BlingFire.text_to_sentences_with_offsets(text)
    assert_equal [["This is one sentence.", "Another sentence."], [0, 22], [21, 39]], output
  end

  def test_text_to_words_multiple_spaces
    assert_equal ["hello", "world", "!"], BlingFire.text_to_words("hello   world!")
  end

  def test_text_to_sentences_newlines
    assert_equal ["hello world!"], BlingFire.text_to_sentences("hello\nworld!")
  end

  def test_ids_to_text
    model = BlingFire.load_model("test/support/bert_base_cased_tok.i2w")
    assert_equal "This is a test", model.ids_to_text([1188, 1110, 170, 2774])
    assert_equal "", model.ids_to_text([])
    assert_equal "", model.ids_to_text([100, 101, 102]) # special tokens
    assert_equal "[UNK] [CLS] [SEP]", model.ids_to_text([100, 101, 102], skip_special_tokens: false)
  end

  def test_ids_to_text_wrong_model_type
    model = BlingFire.load_model("test/support/bert_base_tok.bin")
    # ideally would raise an error
    # but no way to differentiate between all special tokens
    assert_equal "", model.ids_to_text([1188, 1110, 170, 2774])
  end

  def test_normalize_spaces
    assert_equal "hello world!", BlingFire.normalize_spaces("hello   world!")
  end

  def test_xlnet
    model = BlingFire.load_model("test/support/xlnet.bin")
    assert_equal [24717, 185, 136, 0], model.text_to_ids("hello world!", 4, 100)
  end

  def test_roberta
    model = BlingFire.load_model("test/support/roberta.bin")
    assert_equal [152, 16, 10, 1296], model.text_to_ids("This is a test", 4, 100)

    ids, start_offsets, end_offsets = model.text_to_ids_with_offsets("This is a test", 4, 100)
    assert_equal [152, 16, 10, 1296], ids
    # TODO fix offsets
    # keep consistent with 0.1.5 for now
    assert_equal [0, 4, 7, 9], start_offsets
    assert_equal [4, 7, 9, 14], end_offsets
  end

  def test_roberta_no_prefix
    model = BlingFire.load_model("test/support/roberta.bin", prefix: false)
    assert_equal [713, 16, 10, 1296], model.text_to_ids("This is a test", 4, 100)

    ids, start_offsets, end_offsets = model.text_to_ids_with_offsets("This is a test", 4, 100)
    assert_equal [713, 16, 10, 1296], ids
    # TODO fix offsets
    # keep consistent with 0.1.5 for now
    assert_equal [0, 4, 7, 9], start_offsets
    assert_equal [4, 7, 9, 14], end_offsets
  end

  def test_load_model_invalid
    error = assert_raises(BlingFire::Error) do
      BlingFire.load_model("invalid.bin")
    end
    assert_equal "Model not found", error.message
  end

  def test_copy
    model = BlingFire.load_model("test/support/bert_base_tok.bin")
    model.dup
    model.clone
  end
end
