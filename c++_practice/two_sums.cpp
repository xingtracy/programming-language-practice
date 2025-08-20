class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {

        unordered_map<int,int> pairIndices;

        for(int i = 0 ; i < nums.size() ; i++){
            int num = nums[i];
            if (pairIndices.find(target-num)!=pairIndices.end()){
                return {pairIndices[target-num],i};
            }
            pairIndices[num]=i;
        }
        return {};
    }
};