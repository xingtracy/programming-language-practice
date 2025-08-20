#include <iostream>
#include <unordered_map>
#include <unordered_set>
class Solution {
public:
    bool wordPattern(string pattern, string s) {

        unordered_map<char,string> char_to_string;
        unordered_map<string,char> string_to_char;
        
        string firstWord;
        size_t first_space_position;

        for(char letter : pattern){
            if(s.empty()) return false;
            size_t first_space_position = s.find(' ');
            // Get first word
            if (first_space_position!= string::npos){
            
                firstWord=s.substr(0,first_space_position);
                s.erase(0, first_space_position+1);
            }else{
                firstWord=s;
                s.clear();
            }

            // If first word is mapped by letter 
            if (char_to_string.find(letter)!=char_to_string.end() || 
                string_to_char.find(firstWord)!=string_to_char.end()){
                if (char_to_string[letter]!=firstWord ||
                    string_to_char[firstWord]!=letter){
                    return false;
                }
            }else{
                char_to_string[letter]=firstWord;
                string_to_char[firstWord]=letter;
            }

        }

        if(!s.empty())return false;

        return true;
    }
};