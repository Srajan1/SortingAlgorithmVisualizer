import 'dart:async';

class Sort {
  int sampleSize;
  List<int> numbers;
  StreamController streamController;
  Sort({this.numbers, this.sampleSize, this.streamController});
  void bubbleSort() async {
    for (int i = 0; i < sampleSize; ++i) {
      for (int j = 0; j < numbers.length - i - 1; ++j) {
        if (numbers[j] > numbers[j + 1]) {
          int temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: 500));
        streamController.add(numbers);
      }
    }
  }

  void heapSort() {
    heapify(List<int> arr, int n, int i) {
      int largest = i;
      int l = 2 * i + 1;
      int r = 2 * i + 2;

      if (l < n && arr[l] > arr[largest]) largest = l;

      if (r < n && arr[r] > arr[largest]) largest = r;

      if (largest != i) {
        int temp = numbers[i];
        numbers[i] = numbers[largest];
        numbers[largest] = temp;
        heapify(arr, n, largest);
      }
    }

    heapSort() async {
      for (int i = numbers.length ~/ 2; i >= 0; i--) {
        await heapify(numbers, numbers.length, i);
        streamController.add(numbers);
      }
      for (int i = numbers.length - 1; i >= 0; i--) {
        int temp = numbers[0];
        numbers[0] = numbers[i];
        numbers[i] = temp;
        await Future.delayed(Duration(microseconds: 500));
        await heapify(numbers, i, 0);
        streamController.add(numbers);
      }
    }

    heapSort();
  }

  selectionSort() async {
    print('here');
    for (int i = 0; i < numbers.length; i++) {
      for (int j = i + 1; j < numbers.length; j++) {
        if (numbers[i] > numbers[j]) {
          int temp = numbers[j];
          numbers[j] = numbers[i];
          numbers[i] = temp;
        }

        await Future.delayed(Duration(microseconds: 500));

        streamController.add(numbers);
      }
    }
  }

  insertionSort() async {
    print('here');
    for (int i = 1; i < numbers.length; i++) {
      int temp = numbers[i];
      int j = i - 1;
      while (j >= 0 && temp < numbers[j]) {
        numbers[j + 1] = numbers[j];
        --j;
        await Future.delayed(Duration(microseconds: 500));

        streamController.add(numbers);
      }
      numbers[j + 1] = temp;
      await Future.delayed(Duration(microseconds: 500));

      streamController.add(numbers);
    }
  }

  quickSort(int leftIndex, int rightIndex) async {
    print('here');
    int compare(int a, int b) {
      if (a < b) {
        return -1;
      } else if (a > b) {
        return 1;
      } else {
        return 0;
      }
    }

    Future<int> partition(int left, int right) async {
      int p = (left + (right - left) / 2).toInt();

      var temp = numbers[p];
      numbers[p] = numbers[right];
      numbers[right] = temp;
      await Future.delayed(Duration(microseconds: 500));

      streamController.add(numbers);

      int cursor = left;

      for (int i = left; i < right; i++) {
        if (compare(numbers[i], numbers[right]) <= 0) {
          var temp = numbers[i];
          numbers[i] = numbers[cursor];
          numbers[cursor] = temp;
          cursor++;

          await Future.delayed(Duration(microseconds: 500));

          streamController.add(numbers);
        }
      }

      temp = numbers[right];
      numbers[right] = numbers[cursor];
      numbers[cursor] = temp;

      await Future.delayed(Duration(microseconds: 500));

      streamController.add(numbers);

      return cursor;
    }

    if (leftIndex < rightIndex) {
      int p = await partition(leftIndex, rightIndex);

      await quickSort(leftIndex, p - 1);

      await quickSort(p + 1, rightIndex);
    }
  }

  mergeSort(int leftIndex, int rightIndex) async {
    Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
      int leftSize = middleIndex - leftIndex + 1;
      int rightSize = rightIndex - middleIndex;

      List leftList = new List(leftSize);
      List rightList = new List(rightSize);

      for (int i = 0; i < leftSize; i++) leftList[i] = numbers[leftIndex + i];
      for (int j = 0; j < rightSize; j++)
        rightList[j] = numbers[middleIndex + j + 1];

      int i = 0, j = 0;
      int k = leftIndex;

      while (i < leftSize && j < rightSize) {
        if (leftList[i] <= rightList[j]) {
          numbers[k] = leftList[i];
          i++;
        } else {
          numbers[k] = rightList[j];
          j++;
        }

        await Future.delayed(Duration(microseconds: 500));
        streamController.add(numbers);

        k++;
      }

      while (i < leftSize) {
        numbers[k] = leftList[i];
        i++;
        k++;

        await Future.delayed(Duration(microseconds: 500));
        streamController.add(numbers);
      }

      while (j < rightSize) {
        numbers[k] = rightList[j];
        j++;
        k++;

        await Future.delayed(Duration(microseconds: 500));
        streamController.add(numbers);
      }
    }

    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;

      await mergeSort(leftIndex, middleIndex);
      await mergeSort(middleIndex + 1, rightIndex);

      await Future.delayed(Duration(microseconds: 500));

      streamController.add(numbers);

      await merge(leftIndex, middleIndex, rightIndex);
    }
  }
}
