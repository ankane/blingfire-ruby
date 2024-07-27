# Bling Fire Ruby

[Bling Fire](https://github.com/microsoft/BlingFire) - high speed text tokenization - for Ruby

[![Build Status](https://github.com/ankane/blingfire-ruby/actions/workflows/build.yml/badge.svg)](https://github.com/ankane/blingfire-ruby/actions)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem "blingfire"
```

## Getting Started

Create a model

```ruby
model = BlingFire::Model.new
```

Tokenize words

```ruby
model.text_to_words(text)
```

Tokenize sentences

```ruby
model.text_to_sentences(text)
```

Get offsets for words

```ruby
words, start_offsets, end_offsets = model.text_to_words_with_offsets(text)
```

Get offsets for sentences

```ruby
sentences, start_offsets, end_offsets = model.text_to_sentences_with_offsets(text)
```

## Pre-trained Models

Bling Fire comes with a default model that follows the tokenization logic of NLTK with a few changes. You can also download other models:

- [BERT Base](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/bert_base_tok.bin), [BERT Base Cased](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/bert_base_cased_tok.bin), [BERT Chinese](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/bert_chinese.bin), [BERT Multilingual Cased](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/bert_multi_cased.bin)
- [GPT-2](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/gpt2.bin)
- [Laser 100k](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/laser100k.bin), [Laser 250k](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/laser250k.bin), [Laser 500k](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/laser500k.bin)
- [RoBERTa](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/roberta.bin)
- [Syllab](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/syllab.bin)
- [URI 100k](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/uri100k.bin), [URI 250k](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/uri250k.bin), [URI 500k](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/uri500k.bin)
- [XLM-RoBERTa](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/xlm_roberta_base.bin)
- [XLNet](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/xlnet.bin), [XLNet No Norm](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/xlnet_nonorm.bin)
- [WBD](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/wbd_chuni.bin)

Load a model

```ruby
model = BlingFire.load_model("bert_base_tok.bin")
```

Convert text to ids

```ruby
model.text_to_ids(text)
```

Get offsets for ids

```ruby
ids, start_offsets, end_offsets = model.text_to_ids_with_offsets(text)
```

Disable prefix space

```ruby
model = BlingFire.load_model("roberta.bin", prefix: false)
```

## Ids to Text

Load a model

```ruby
model = BlingFire.load_model("bert_base_tok.i2w")
```

Convert ids to text

```ruby
model.ids_to_text(ids)
```

## History

View the [changelog](https://github.com/ankane/blingfire-ruby/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/blingfire-ruby/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/blingfire-ruby/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/blingfire-ruby.git
cd blingfire-ruby
bundle install
bundle exec rake vendor:all download:models
bundle exec rake test
```
