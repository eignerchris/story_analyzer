# ruby 1.9.3
# use: ruby analyze.rb story1.txt

# read story encoding from file given as command line argument
story_encoding  = File.read ARGV[0]

# initialize a hash for storing the counts for all encodings
encoding_counts = {}

# generate all permutations of 1-4 character encodings
encoding_permutations =  story_encoding.chars.to_a.uniq.permutation(1).to_a
encoding_permutations += story_encoding.chars.to_a.uniq.permutation(2).to_a
encoding_permutations += story_encoding.chars.to_a.uniq.permutation(3).to_a
encoding_permutations += story_encoding.chars.to_a.uniq.permutation(4).to_a

# delete nonsense encodings
encoding_permutations.delete(["\n"])
encoding_permutations.delete(["#"])
encoding_permutations.delete(["0", "\n"])
encoding_permutations.delete(["\n", "#"])

# iterate over each encoding
encoding_permutations.each do |encoding|
  # look for matches
  matches                   = story_encoding.scan(encoding.join(""))
  
  # intialize hash to 0 if this is the first time we've scanned for this encoding
  encoding_counts[encoding] = 0 unless encoding_counts[encoding]

  # add total number of matches for this encoding
  encoding_counts[encoding] += matches.length
end

# delete encodings where count was 0
encoding_counts.delete_if { |k, v| v == 0 }

# open output file for writing
output = File.new("output.txt", "w")

# sort the encoding counts by value
sorted_encoding_counts = encoding_counts.sort {|a, b| b[1] <=> a[1]}

# iterate over counts and write each to output file
sorted_encoding_counts.each do |encoding, count|
  output.puts "#{encoding.join("")}: #{count}"
end

output.close