import sys

natural = int(sys.argv[1])
if natural == 1:
  print "Neither"
elif natural == 2:
  print "Prime"
elif len(filter(lambda x:natural%x==0, range(2,natural))) > 0:
  print "Composite"
else:
  print "Prime"

