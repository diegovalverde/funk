# roll list elements, or rows when input is a matrix

rroll([], _): [].
rroll(row, off):
      n <- len(row) / len(row[0])
      [ row[i - off] | 0 <= i < n ].
