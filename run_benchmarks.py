import sys
from subprocess import TimeoutExpired, run
from subprocess import call
import os, os.path
import csv
import resource

cobalt          = './effsynth.native'
TIMEOUT      = 120                          # Timeout in secs
FORCEDTO     = '600s'
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
  BenchmarkGroup("Databases",  [
   
    Benchmark('databases/small_query2', 'D2: NL_subscribe'),
    Benchmark('databases/newsletter_remove', 'D3: NL_remove'),
    Benchmark('databases/newsletter_read', 'D4: NL_read'),
    Benchmark('databases/newsletter_read_remove', 'D5: NL_read_remove'),
    Benchmark('databases/firewall1', 'D6: F_delete'),
    Benchmark('databases/firewall2', 'D7: F_insert_connect'),
    Benchmark('databases/firewall4', 'D8: F_delete_make_central'),
    Benchmark('databases/firewall_if_for_firewall1', 'D9: F_cond_delete'),
    Benchmark('databases/firewall_if_for_firewall2', 'D10: F_cond_insert_connect'),
    Benchmark('databases/firewall_if_for_firewall4', 'D11: F_cond_delete_make_central'),
    ]),    
  BenchmarkGroup("Parsers", [
    Benchmark('parsers/png_simple', 'P1 png_chunk'),
    Benchmark('parsers/png_simple2', 'P2 png_chunk'),
    Benchmark('parsers/png_simple_if', 'P3 png_chunk'),
    Benchmark('parsers/cdecl_typedecl', 'P4 C_typedec'),
    Benchmark('parsers/cdecl_fundec_simple', 'P5 C_extern_fundec'),
    Benchmark('parsers/cdecl_vardec_simple', 'P6 C_extern_vardec'),
   
     ]),
   
  BenchmarkGroup("Imperative", [
    Benchmark('imperative_ds_simple/queue/queue_query4', 'I1'),
    Benchmark('imperative_ds_simple/queue/queue_query4_plus', 'I2'),
    Benchmark('imperative_ds_simple/queue/queue_remove', 'I3'),
    Benchmark('imperative_ds_simple/queue/queue_if_query1', 'I4'),
    Benchmark('imperative_ds_simple/queue/queue_if_query2', 'I5'),
     #table 
    Benchmark('imperative_ds_simple/tbl/tbl_insert_input', 'I6'),
    Benchmark('imperative_ds_simple/tbl/tbl_insert_input_plus', 'I7'),
    Benchmark('imperative_ds_simple/tbl/tbl_insert_input_plus_plus', 'I8'),
    #vocal 
    Benchmark('vocal/Vector1', 'V1'),
    Benchmark('vocal/Vector2', 'V2'),
    Benchmark('vocal/Vector3', 'V3'),
    Benchmark('vocal/RingBuffer1', 'RB1'),
    Benchmark('vocal/RingBuffer2', 'RB2'),
    Benchmark('vocal/sll_goal1', 'SLL1'),
    Benchmark('vocal/sll_goal2', 'SLL2'),
    Benchmark('vocal/sll_goal3', 'SLL3'),
    Benchmark('vocal/Queue1', 'Q1'),
    Benchmark('vocal/Queue2', 'Q2'),
    Benchmark('vocal/Queue3', 'Q3'),
    Benchmark('vocal/ZipperList1', 'ZL1'),
    Benchmark('vocal/ZipperList2', 'ZL2'),
    Benchmark('vocal/ZipperList3', 'ZL3'),

    Benchmark('vocal/PriorityQueue2', 'PQ2'),

    Benchmark('vocal/HashTable1', 'HT1'),
    Benchmark('vocal/HashTable2', 'HT2'),
    Benchmark('vocal/HashTable3', 'HT3')
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
    print ('Running Varinat'+variant, file)
    if variant == 'cobalt':
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['timeout', FORCEDTO, 'time', cobalt,  '-bi', '-cdcl',  file], timeout =TIMEOUT,  stdout=outfile)
            usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)    
            cpu_time = usage_end.ru_utime - usage_start.ru_utime    
        except TimeoutExpired:
            cpu_time = 1000        
        
        
    elif variant == 'fw-alone':
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['timeout', FORCEDTO, 'time', cobalt, '-cdcl', file], timeout =TIMEOUT,  stdout=outfile)
            usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)    
            cpu_time = usage_end.ru_utime - usage_start.ru_utime    
        except TimeoutExpired:
            cpu_time = 1000        
        
    elif variant == 'bw-alone':
        
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['timeout', FORCEDTO, 'time', cobalt, '-bi', file], timeout =TIMEOUT,  stdout=outfile)
            usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)    
            cpu_time = usage_end.ru_utime - usage_start.ru_utime    
        except TimeoutExpired:
            cpu_time = 1000        
        
     
    elif variant == 'no-cdcl':
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['timeout', FORCEDTO, 'time', cobalt, file], timeout =TIMEOUT,  stdout=outfile)
            usage_end = resource.getrusage(resource.RUSAGE_CHILDREN)    
            cpu_time = usage_end.ru_utime - usage_start.ru_utime    
        except TimeoutExpired:
            cpu_time = 1000        
       
    else:
        usage_start = resource.getrusage(resource.RUSAGE_CHILDREN)
        try:
            run(['timeout', FORCEDTO, 'time', cobalt, '-bi', '-cdcl', file], timeout =TIMEOUT,  stdout=outfile)
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
    
  
