int countPeaks(vector<double> values) {

  const int n = values.size();
  int peakCount=0;
  int i = 1;

  while (i<n-1){
    if((values[i]-values[i-1]>=5.0) && (values[i]-values[i+1]>=5.0) ||
        (values[i-1]-values[i]>=5.0) && (values[i+1]-values[i]>=5.0) ){
      peakCount+=1;
    }
    i+=1;
  }
  // Write your code here
  // To debug: cerr << "Debug messages..." << endl;

  return peakCount;
}