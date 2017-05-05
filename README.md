## Question Answering using WolframAlpha + Amazon Polly

This simple Python and Ruby scripts will take the question, ask the WolframAlpha and synthesize the audio using Amazon Polly

### Installation

* Install the libraries

`$ pip install boto3 wolframalpha`

`$ gem install aws-sdk wolfram-alpha`

* Install [sox](http://sox.sourceforge.net)

`$ brew install sox` for macOS, and please visit this [link](http://sox.sourceforge.net/Main/Links) for other OS

### Usage

`$ python wolframsynth.py "What's the tallest building in the world?"`

`$ ruby wolframsynth.rb "What's the tallest building in the world?"`
