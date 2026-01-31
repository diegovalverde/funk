# roll list elements, or rows when input is a matrix

rroll([], _): [].
rroll(row, off):
      [ row[i - off] | 0 <= i < (len(row) / len(row[0])) ].
