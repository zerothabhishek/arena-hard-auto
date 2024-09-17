require 'json'
require 'erb'

def render(args)
  tempalate = File.read("./questions.erb")
  erb = ERB.new(tempalate)
  questions = args[:questions]
  result = erb.result(binding)
end

def to_html(jsonl_file)
  jsonl = File.readlines(jsonl_file)
  hashes = jsonl.map { |json| JSON.parse(json) }

  p hashes.sample

  html = render(questions: hashes)
  File.write("questions.html", html)
end


to_html("./questions.jsonl")
