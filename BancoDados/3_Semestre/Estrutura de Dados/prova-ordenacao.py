def insertionSort(alist):
   for index in range(1,len(alist)):

     currentvalue = alist[index]
     position = index

     while position>0 and alist[position-1]>currentvalue:
         alist[position]=alist[position-1]
         position = position-1

     alist[position]=currentvalue
     print(alist)

def selectionSort(A):
  # Traverse through all array elements
  for i in range(len(A)):
      print(alist)
      # Find the minimum element in remaining
      # unsorted array
      min_idx = i
      for j in range(i+1, len(A)):
          if A[min_idx] > A[j]:
              min_idx = j
              
      # Swap the found minimum element with
      # the first element       
      A[i], A[min_idx] = A[min_idx], A[i]

def bubbleSort(arr):
    n = len(arr)
  
    # Traverse through all array elements
    for i in range(n-1):
    # range(n) also work but outer loop will repeat one time more than needed.
        print(alist)
        # Last i elements are already in place
        for j in range(0, n-i-1):
  
            # traverse the array from 0 to n-i-1
            # Swap if the element found is greater
            # than the next element
            if arr[j] > arr[j + 1] :
                arr[j], arr[j + 1] = arr[j + 1], arr[j]

# print("#Lista 1:")                
# alist = [89,42,55,98,93,77,13]
# selectionSort(alist)

# print("#Lista 2:")  
# alist = [69,41,93,16,30,24,57]
# bubbleSort(alist)

# print("#Lista 3:")  
# alist = [70,41,58,79,23,83,11]
# insertionSort(alist)

print("#Lista 4:")  
alist = [37,62,45,33,59,30,19]
bubbleSort(alist)