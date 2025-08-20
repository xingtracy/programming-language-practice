class Solution {
public:
    int romanToInt(string s) {
        int num_of_roman = 0;
        int i = 0;
        while(i<s.length()){
            if (s[i]=='M'){
                num_of_roman = num_of_roman + 1000;
            }else if(s[i]=='D'){
                num_of_roman = num_of_roman + 500;
            }else if(s[i]=='C'){
                if (i!=(s.length()-1) && s[i+1]=='D'){
                    num_of_roman = num_of_roman + 400;
                    i++;
                }else if (i!=(s.length()-1) && s[i+1]=='M'){
                    num_of_roman = num_of_roman + 900;
                    i++;
                }else{
                    num_of_roman = num_of_roman + 100;
                }
            }else if(s[i]=='L'){
                num_of_roman = num_of_roman + 50;
            }else if(s[i]=='X'){
                if (i!=(s.length()-1) && s[i+1]=='L'){
                    num_of_roman = num_of_roman + 40;
                    i++;
                }else if (i!=(s.length()-1) && s[i+1]=='C'){
                    num_of_roman = num_of_roman + 90;
                    i++;
                }else{
                    num_of_roman = num_of_roman + 10;
                }
            }else if(s[i]=='V'){
                num_of_roman = num_of_roman + 5;
            }else if(s[i]=='I'){
                if (i!=(s.length()-1) && s[i+1]=='V'){
                    num_of_roman = num_of_roman + 4;
                    i++;
                }else if (i!=(s.length()-1) && s[i+1]=='X'){
                    num_of_roman = num_of_roman + 9;
                    i++;
                }else{
                    num_of_roman = num_of_roman + 1;
                }
            }
            i++;
        }
        return num_of_roman;
    }
};