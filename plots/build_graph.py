#!/opt/local/bin/python

import os, sys, codecs

def main():
  start_time = int(sys.argv[1])
  span = int(sys.argv[2]) - start_time
  
  threads = {}
  progress = {}
  completed = 0
  for line in sys.stdin:
    if (line.startswith("#")):
      continue
    (sent, blah, sec, bleh, thread) = line.lstrip().rstrip().split()
    if (thread not in threads):
      threads[thread] = start_time
    threads[thread] += int(sec)
    if (threads[thread] not in progress):
      progress[threads[thread]] = 0
    progress[threads[thread]] += 1

  #  print threads

  max = 0
  for k in progress:
    if (k > max):
      max = k
  max -= start_time
      
  stretched = {}
  for k in progress:
    mapped = start_time + (float(k - start_time) / max) * span
    stretched[mapped] = progress[k]
      
  for i in xrange(start_time):
    print str(i) + "\t0"

  keys = stretched.keys()
  keys.sort()
  sum = 0
  for key in keys:
    sum += stretched[key]
    print str(key) + "\t" + str(sum)
    

if __name__ == "__main__":
  main()
