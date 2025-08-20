class Solution {
public:
    bool isValid(string s) {
        stack<int> open_brackets;
        for(char c : s){
            if(c=='(' || c=='[' || c=='{'){
                open_brackets.push(c);
            }else{
                if(open_brackets.size()==0){
                    return false;
                }
                if (c==')'){
                    if (open_brackets.top()!='(') return false;
                    open_brackets.pop();
                }else if (c==']'){
                    if (open_brackets.top()!='[') return false;
                    open_brackets.pop();
                }else if (c=='}'){
                    if (open_brackets.top()!='{') return false;
                    open_brackets.pop();
                }
            }
        }
        if(open_brackets.size()==0) return true;
        return false;
    }
};