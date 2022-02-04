void main() {
  List<BucketPack> buckets = [];
  List<int> weights = [2, 3, 5, 2, 1, 4, 7, 2, 5, 2, 10, 10, 2, 5, 2, 3, 1, 1];
  int bucketCapacity = 10;

  bestFit(buckets: buckets, weights: weights, bucketCapacity: bucketCapacity);
}

bestFit({
  required List<BucketPack> buckets,
  required List<int> weights,
  required int bucketCapacity,
}) {
  int i;
  for (i = 0; i < weights.length; i++) {
    int j;
    int minRemBucketIndex = -1;
    int minRemBucket = -1;

    // for each bucket
    for (j = 0; j < buckets.length; j++) {
      // if bucket has enough space to accomodate weight
      if (buckets[j].weightSum + weights[i] <= bucketCapacity) {
        int sumCurrenWeight = buckets[j].weightSum + weights[i];
        int currentRem = bucketCapacity - sumCurrenWeight;
        //check if this bucket has  the new minimum space for this weight
        if (minRemBucket == -1 || currentRem < minRemBucket) {
          minRemBucket = currentRem;
          minRemBucketIndex = j;
        }
      }
    }
    // weight didnt fit any bucket, add into a new bucket
    if (minRemBucketIndex == -1) {
      buckets.add(BucketPack(weightSum: weights[i], weights: [weights[i]]));
    } else {
      buckets[minRemBucketIndex] = BucketPack(
        weightSum: buckets[minRemBucketIndex].weightSum + weights[i],
        weights: [...buckets[minRemBucketIndex].weights, weights[i]],
      );
    }
  }

  // debuging.. print out values to verify results
  int weightsSum = weights.reduce((a, b) => a + b);
  BucketPack bucketsSum = buckets.reduce((a, b) => BucketPack(
      weightSum: a.weightSum + b.weightSum,
      weights: [...a.weights, ...b.weights]));

  print('$weightsSum ...  ${bucketsSum.weightSum} ... $buckets');
  // debuging.. print out values to verify results
}

class BucketPack {
  BucketPack({required this.weightSum, required this.weights});

  final int weightSum;
  final List<int> weights;

  @override
  toString() {
    return '$weights ... $weightSum';
  }
}
