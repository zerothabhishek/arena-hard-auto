require 'json'
require 'yaml'
require 'erb'

HIGHLIGHTED = [
  "8fc630418a6648de93c52240c9a27086",  ## Shortest
  "a309b458a5db427f974f305c95638204",  ## Short
  "ee9ae71956724d4591d4d9bc457d598d",  ## Longest
  "984787b1d5c64bb7b6dcd485ff8a70e6",  ## Bug puzzle
  "6225fbb8f3084d57852db56882e972ba",  ## Accounting
  "b5987b1c1dd3479bb9217e2f7822d70d",  ## Anime
  "07c7df22ca70487fafd0b08c31c7a7bb",  ## Electromagnetic Phenomena and Theorems
  "9b9b65ab647b45858a21e873de28b1f3",  ## Endurance swimming
  "1f40a942fe114308ae5fde2097c21f70",  ## Exam Cheating Strategies
  "e80139e32fb54b95a9a4effa86d8ddf5",  ## Preppers
  "34690d250eab4d9f9077513f10859335",  ## Grocery business
  "cc977fe528654d41ac494df48c6bebb2",  ## Health-nutrition
  "33cdce3020774e62959af8ca7a4132ca",  ## Hospital project
  "854302607f2046a9913841f81791facb",  ## Hospital project
  "23aecfcf36524c279c3ec77a366ca65e",  ## Housebuilding
  "3bd1d718d10f4b35b7547da999415ec6",  ## JPEG Compression
  "f2d3430aea0f4dc6a1c4f7210ded1491",  ## Investment

]

def render(args)
  tempalate = File.read("./questions.erb")
  erb = ERB.new(tempalate)
  questions = args[:questions]
  result = erb.result(binding)
end

def highlight(questions)
  questions1 = questions.map do |h|
    hl = HIGHLIGHTED.include?(h['question_id'])
    h['hl'] = true if hl
    h
  end

  puts "Highlighted:"
  questions1.select{|h| h['hl'] }.each do |h|
    puts h.to_yaml
  end
  puts
  
  questions1
end

def to_html(jsonl_file)
  jsonl = File.readlines(jsonl_file)
  hashes = jsonl.map { |json| JSON.parse(json) }

  puts "A random sample:"
  puts hashes.sample.to_yaml
  puts

  hashes = highlight(hashes)

  html = render(questions: hashes)
  File.write("questions.html", html)
end


to_html("./questions.jsonl")
