def str_str(haystack, needle)

    first_occurence = haystack.index(needle)

    if first_occurence!=nil
        return first_occurence
    end
    return -1
end