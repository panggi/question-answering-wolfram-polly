## Question Answering using WolframAlpha + Amazon Polly

This simple Python script will take the question, ask the WolframAlpha and synthesize the audio using Amazon Polly

### Installation

* Install the python libraries

`$ pip install boto3 wolframalpha`

* Install [sox](http://sox.sourceforge.net)

`$ brew install sox` for macOS, and please visit this [link](http://sox.sourceforge.net/Main/Links) for other OS

### Usage

`$ python wolframsynth.py "What's the tallest building in the world?"`
