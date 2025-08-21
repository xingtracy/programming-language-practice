# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(s, num_rows)
    
    # Edge case where return just s
    if num_rows==1 || num_rows>=s.length 
        return s
    end

    # Array of empty strings for each row
    rows = Array.new(num_rows,"")

    # Current row index
    curr_row = 0
    # If direction moving is down
    going_down = false

    s.each_char do |char|
        # add char to current row
        rows[curr_row] = rows[curr_row]+char

        # if need to change directions
        if curr_row == 0 || curr_row == (num_rows-1) 
            going_down = !going_down
        end
        
        # Where to move next depending on direction
        if going_down
            curr_row+=1
        else
            curr_row-=1
        end
    end
    
    rows.join
end