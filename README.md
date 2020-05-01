# Bling Fire

[Bling Fire](https://github.com/microsoft/BlingFire) - high speed text tokenization - for Ruby

[![Build Status](https://travis-ci.org/ankane/blingfire.svg?branch=master)](https://travis-ci.org/ankane/blingfire) [![Build status](https://ci.appveyor.com/api/projects/status/3gyca4gsjw2w9ns1/branch/master?svg=true)](https://ci.appveyor.com/project/ankane/blingfire/branch/master)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'blingfire'
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

## Pre-trained Models

BlingFire comes with a default model that follows the tokenization logic of NLTK with a few changes. You can also download other models:

- [BERT Base](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/bert_base_tok.bin)
- [BERT Base Cased](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/bert_base_cased_tok.bin)
- [BERT Chinese](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/bert_chinese.bin)
- [BERT Multilingual Cased](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/bert_multi_cased.bin)
- [WBD](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/wbd_chuni.bin)
- [XLNet](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/xlnet.bin)
- [XLNet No Norm](https://github.com/microsoft/BlingFire/blob/master/dist-pypi/blingfire/xlnet_nonorm.bin)

Load a model

```ruby
model = BlingFire.load_model("bert_base_tok.bin")
```

Convert text to ids

```ruby
model.text_to_ids(text)
```

## History

View the [changelog](https://github.com/ankane/blingfire/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/blingfire/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/blingfire/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/blingfire.git
cd blingfire
bundle install
bundle exec rake vendor:all
bundle exec rake test
```
