def insertion_sort(arr, direction='nondecreasing'):
    """Insertion sort given an array"""
    j      = 1
    length = len(arr)

    while j < length:
        key = arr[j]
        i = j - 1

        if direction == 'nondecreasing':
            while i >= 0 and arr[i] < key:
                arr[i+1] = arr[i]
                i = i - 1
        elif direction == 'nonincreasing':
            while i >= 0 and arr[i] > key:
                arr[i+1] = arr[i]
                i = i - 1
        else:
            raise Exception('invalid direction')

        arr[i+1] = key
        j = j + 1
