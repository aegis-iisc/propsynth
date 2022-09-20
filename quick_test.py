import sys
from subprocess import TimeoutExpired, run
from subprocess import call
import os, os.path
import csv
import resource

cobalt       = './effsynth.native'
TIMEOUT      = 120                            # Timeout in secs
TEST_DIR     = './synth_tests/unit/checked/'   # Root directory for the tests   
VARIANTS     = ['cobalt', 'fw-alone', 'bw-alone','no-cdcl']    # Configurations
RESULTS      = 'results.txt'                                      # Output file with synthesis results
TIMERESULTS  = 'timings'

class Benchmark:
  def __init__(self, name, description):
    self.name = name                # Test file name
    self.description = description  # Label of the benchmark in Fig 9

  def str(self):
    return self.name + ': ' + self.description

class BenchmarkGroup:
  def __init__(self, name, benchmarks):
    self.name = name              # Id
    self.benchmarks = benchmarks  # List of benchmarks in this group

ALL_BENCHMARKS = [
  BenchmarkGroup("synthetic",  [
     Benchmark('other_units/u_test3', 'Unit test 3'),
     ]),    
]

class SynthesisResult:
  def __init__(self, name, time_cobalt, time_fw_alone, time_bw_alone, time_no_cdcl, code_size_ast):
    self.name = name                                      # Benchmark name
    self.time_cobalt = time_cobalt                                      # Synthesis time (seconds)
    self.time_fw_alone = time_fw_alone
    self.time_bw_alone = time_bw_alone
    self.time_no_cdcl = time_no_cdcl 
    self.code_size = code_size_ast                            # Cumulative synthesized code size (in AST nodes)
    
  def str(self):
    return self.name + ', ' + '{0:0.2f}'.format(self.time_cobalt) + ', ' + '{0:0.2f}'.format(self.time_fw_alone) + ', ' \
                            + '{0:0.2f}'.format(self.time_bw_alone) + ', ''{0:0.2f}'.format(self.time_no_cdcl) + ', ' \
                            + str (self.code_size) 

# Run a single benchmark
def run_benchmark(file, variant):
  '''Run single benchmark'''
  cpu_time = 0
  with open(RESULTS, "a") as outfile:
    print ('Running Varinat '+variant, file)
    if variant == 'cobalt':
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['time', cobalt,  '-bi', '-cdcl',  file], timeout =TIMEOUT,  stdout=outfile)
            usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)    
            cpu_time = usage_end.ru_utime - usage_start.ru_utime    
        except TimeoutExpired:
            cpu_time = 1000        
        
        
    elif variant == 'fw-alone':
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['time', cobalt, '-cdcl', file], timeout =TIMEOUT,  stdout=outfile)
            usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)    
            cpu_time = usage_end.ru_utime - usage_start.ru_utime    
        except TimeoutExpired:
            cpu_time = 1000        
        
    elif variant == 'bw-alone':
        
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['time', cobalt, '-bi', file], timeout =TIMEOUT,  stdout=outfile)
            usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)    
            cpu_time = usage_end.ru_utime - usage_start.ru_utime    
        except TimeoutExpired:
            cpu_time = 1000        
        
     
    elif variant == 'no-cdcl':
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['time', cobalt, file], timeout =TIMEOUT,  stdout=outfile)
            usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)    
            cpu_time = usage_end.ru_utime - usage_start.ru_utime    
        except TimeoutExpired:
            cpu_time = 1000        
       
    else:
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['time', cobalt, '-bi', '-cdcl', file], timeout =TIMEOUT,  stdout=outfile)
            usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)    
            cpu_time = usage_end.ru_utime - usage_start.ru_utime    
        except TimeoutExpired:
            cpu_time = 1000        
       
    with open(TIMERESULTS, 'a') as f:
        f.write("\n "+file+"_"+variant+" : "+str(cpu_time))
        f.close ()    
  return cpu_time 
    ## create a csv file for each category with [name, tim1cob, timefw, timebw, timenocdcl, size]
    ## read the csv and build the graph.
    #read_csv()
    

def test_variants():
  '''Test all enabled configurations of each benchmark'''
  csvresults = dict()
  for group in groups:
    for b in group.benchmarks:
      test = TEST_DIR + b.name
      testFileName = test + '.spec'
      row = dict()
      if not os.path.isfile(testFileName):
        print ("Test file not found:", testFileName)
      else:
        # run_benchmark(testFileName, 'none') # Run default configuration
        with open(TIMERESULTS, 'a') as f:
            f.write("\n ********************************")
            f.close ()    
        for var in VARIANTS:
            row[var] = run_benchmark(testFileName, var) # Run variant
            print (row)
        if not (test in csvresults):
           csvresults[test] = SynthesisResult(test, row['cobalt'], row['fw-alone'], row['bw-alone'], row['no-cdcl'], 0)  

  return csvresults         
       
    
        
          
if __name__ == '__main__':
  
  if os.path.isfile(RESULTS):        
    os.remove(RESULTS)
    
  variants = []
  groups = ALL_BENCHMARKS
  
  csvres = test_variants()
  for row in csvres:
    print (csvres[row].str() ) 
    
  
