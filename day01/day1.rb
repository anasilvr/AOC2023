file_path = "input.txt"

begin
    input = File.read(file_path)
rescue Errno::ENOENT
    puts "File not found"
rescue => e
    puts "Error: #{e.message}"
end
## this is just me exploring the error handling in ruby :P

## PART 1:
# input = input.split('\n').map { |line| line.gsub(/[^0-9\n]/, '').split }

# input.each do |line|
#     ret = 0
#     line.each do |nb|
#         if nb.length == 1
#             ret += (nb.to_s * 2).to_i
#         elsif nb.length == 2
#             ret += nb.to_i
#         else
#             ret += (nb[0] + nb[-1]).to_i
#         end
#     end
#     puts ret
# end
## END OF PART 1

## ---> But lol, I'll need those spelled out numbers...
##      I should've seen this coming... Let's start again!

number_array = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

pattern = Regexp.union(number_array)

input = input.split('\n').map do |line|
  line.split.map do |nb|
    next if nb.nil?
    loop do
      original_nb = nb
      nb = nb.gsub(pattern) { |match| (number_array.index(match).to_s + match[-1]) }
      break if nb == original_nb
    end
    nb
  end
end

## recycling part 1's code...

input.each do |line|
    ret = 0
    line.each_with_index do |nb, i|
        nb.gsub!(/[^0-9\n]/, '')
        if nb.length == 1
            ret += (nb.to_s * 2).to_i
        elsif nb.length == 2
            ret += nb.to_i
        else
            ret += (nb[0] + nb[-1]).to_i
        end
    end
    puts ret
end
