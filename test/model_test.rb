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

  def test_text_to_words_with_model
    model = BlingFire.load_model("test/support/wbd_chuni.bin")
    text = "This is the Bling-Fire tokenizer. 2007年9月日历表_2007年9月农历阳历一览表-万年历"

    expected = "This is the Bling - Fire tokenizer . 2007 年 9 月 日 历 表 _2007 年 9 月 农 历 阳 历 一 览 表 - 万 年 历"
    assert_equal expected, model.text_to_words(text).join(" ")

    expected = "This is the Bling - Fire tokenizer . 2007年9月日历表_2007年9月农历阳历一览表 - 万年历"
    assert_equal expected, BlingFire.text_to_words(text).join(" ")
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

  def test_text_to_sentences
    text = "In order to login to Café use pi@1.2.1.2. Split the data into train/test with a test size of 20% then use recurrent model (use LSTM or GRU)."

    expected = ["In order to login to Café use pi@1.2.1.2.", "Split the data into train/test with a test size of 20% then use recurrent model (use LSTM or GRU)."]
    assert_equal expected, BlingFire.text_to_sentences(text)

    expected = ["In order to login to Café use pi@1.2.1.2.", "Split the data into train/test with a test size of 20% then use recurrent model (use LSTM or GRU)."]
    assert_equal expected, BlingFire::Model.new.text_to_sentences(text)
  end

  def test_text_to_words_multiple_spaces
    assert_equal ["hello", "world", "!"], BlingFire.text_to_words("hello   world!")
  end

  def test_text_to_sentences_newlines
    assert_equal ["hello world!"], BlingFire.text_to_sentences("hello\nworld!")
  end

  def test_load_model_invalid
    skip "terminates with uncaught exception"

    BlingFire.load_model("invalid.bin")
  end
end
