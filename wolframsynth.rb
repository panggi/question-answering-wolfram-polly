require 'aws-sdk'
require 'wolfram-alpha'

wolfram_options = { "format" => "plaintext" }
wolfram_client = WolframAlpha::Client.new "APPID-WOLFRAM", wolfram_options
wolfram_question = ARGV[0]

puts(":: Question: #{wolfram_question}")
puts("++ Getting Answer from WolframAlpha...")

wolfram_response = wolfram_client.query wolfram_question
wolfram_input = wolfram_response["Input"]
wolfram_result = wolfram_response.find { |pod| pod.title == "Result" }

puts(":: Answer:")
puts(wolfram_result.subpods[0].plaintext)

puts(":: Answer to synthesize:")
wolfram_answer = "for the question #{wolfram_question}, the interpretation is [ #{wolfram_input.subpods[0].plaintext} ], and the answer is #{wolfram_result.subpods[0].plaintext}"
puts wolfram_answer

puts("++ Getting synthesized audio file from Amazon Polly...")
polly_client = Aws::Polly::Client.new(region: "us-east-1")

polly_client.synthesize_speech({
  response_target: "#{Dir.pwd}/answer.pcm",
  output_format: "pcm",
  sample_rate: "16000",
  text: wolfram_answer,
  text_type: "text",
  voice_id: "Joanna",
})

exec("play -t raw -r 16k -e signed -b 16 -c 1 #{Dir.pwd}/answer.pcm")
