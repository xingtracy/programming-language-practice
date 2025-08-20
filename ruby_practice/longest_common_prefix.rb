# @param {String[]} strs
# @return {String}

def longest_common_prefix(strs)
  
    prefix = strs[0]   # Take the first word as the starting prefix
    strs.each do |str|
        # Shrink prefix until it matches the start of str
        while str.index(prefix) != 0
            prefix = prefix[0...-1]  # Remove last character
            return "" if prefix.empty?
        end
    end
    prefix

end