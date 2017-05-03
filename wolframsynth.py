from contextlib import closing
import wolframalpha
import boto3
import sys
import os

wolfram_app_id = "APPID-WOLFRAM"
wolfram_client = wolframalpha.Client(wolfram_app_id)
query = str(sys.argv[1])

print(":: Question: " + query + "\n")
print("++ Getting Answer from WolframAlpha...\n")
wolfram_response = wolfram_client.query(query)
wolfram_answer = next(wolfram_response.results).text.encode('ascii','ignore')

print(":: Answer:")
print(wolfram_answer)

cwd = os.getcwd()
aws_client = boto3.client('polly')
print("\n++ Getting synthesized audio file from Amazon Polly...\n")
aws_response = aws_client.synthesize_speech(
  OutputFormat='pcm',
  SampleRate='16000',
  Text="for the question " + query + ", the answer is: " + wolfram_answer + ".",
  TextType='text',
  VoiceId='Joanna',
 )

if "AudioStream" in aws_response:
    with closing(aws_response["AudioStream"]) as stream:
        output = cwd + "/answer.pcm"

        try:
            with open(output, "wb") as file:
                file.write(stream.read())
        except IOError as error:
            print(error)
            sys.exit(-1)

print("++ Playing the synthesized audio file..\n")
os.system("play -t raw -r 16k -e signed -b 16 -c 1 " + cwd + "/answer.pcm")
