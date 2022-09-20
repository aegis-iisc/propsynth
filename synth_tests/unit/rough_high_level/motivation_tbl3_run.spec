\s  : string
if (mem s) then 
	s1 <- fresh_str ();
	_ <- add s1;
	s2 <- fresh_str ();
	_ <- add s2;
	return average_len ()
else 
	_ <- add s;
	s1 <- fresh_str ();
	_ <- add s1 
	return average_len()	







start-forward : GOTO L1
---------------------------------------------------------------
[s : string /\ not mem (tbl0, s) /\ tbl0 : table] ,  {true} H1 
	 
	 	mem (tbl', s) /\
		  size (tbl') = size (tbl0) + 2 /\
		  len (tbl') = len (tbl0) + len (s) + 3
          /\ size (tbl' > 0)
------------------------------------------------------------------------
[s : string /\ not mem (tbl0, s) /\ tbl0 : table] ,  {true} H1 
	find P0 , such that.
	{P0 /\ size(tbl) > 0 /\
		\forall x, tbl'. tbl' = tbl /\
		minmax x tbl' => 
		(minmax x tbl' /\
		  mem (tbl', s) /\
		  size (tbl') = size (tbl0) + 2 /\
		  len (tbl') = len (tbl0) + len (s) + 3 




	} x <- average_len () 



-------------------------------------------------------------------------------

[s : string /\ not mem (tbl, s) /\ tbl0 : table] ,  {true} H1 
	{size(tbl) > 0 /\
		\forall x, tbl'. tbl' = tbl /\
		minmax x tbl' => 
		(minmax x tbl' /\
		  mem (tbl', s) /\
		  size (tbl') = size (tbl0) + 2 /\
		  len (tbl') = len (tbl0) + len (s) + 3 




	} x <- average_len () 
									
									{sel (h', tbl) = tbl' /\ 
									not (min (tbl') > v) /\
									not (v > max (tbl')) /\
									size (tbl') = size (tbl) + 2 /\
									mem (tbl', s) /\
									(not mem (tbl, s) /\ len (tbl') == len (tbl) + len (s) + 3)}

-------------------------------------------------------------------------------
[s : string /\ not mem (tbl, s)] ,  {true} v : float 
									{sel (h', tbl) = tbl' /\ 
									not (min (tbl') > v) /\
									not (v > max (tbl')) /\
									size (tbl') = size (tbl) + 2 /\
									mem (tbl', s) /\
									(not mem (tbl, s) /\ len (tbl') == len (tbl) + len (s) + 3)}

-------------------------------------------------------------------------------
(disj-rule)  [s : string /\ mem (tbl, s)] ,  {true} v : float 
									{sel (h', tbl) = tbl' /\ 
									not (min (tbl') > v) /\
									not (v > max (tbl')) /\
									size (tbl') = size (tbl) + 2 /\
									mem (tbl', s) /\
									(mem (tbl, s) /\ len (tbl') == len (tbl) + 6)}

			 [s : string /\ not mem (tbl, s)] ,  {true} v : float 
									{sel (h', tbl) = tbl' /\ 
									not (min (tbl') > v) /\
									not (v > max (tbl')) /\
									size (tbl') = size (tbl) + 2 /\
									mem (tbl', s) /\
									(not mem (tbl, s) /\ len (tbl') == len (tbl) + len (s) + 3)}



-------------------------------------------------------------------------------
[s : string] ,  {true} v : float 
									{sel (h', tbl) = tbl' /\ 
									not (min (tbl') > v) /\
									not (v > max (tbl')) /\
									size (tbl') = size (tbl) + 2 /\
									mem (tbl', s) /\
									(not mem (tbl, s) /\ len (tbl') == len (tbl) + len (s) + 3) \/ 
									(mem (tbl, s) /\ len (tbl') == len (tbl) + 6)}

************************************************************************
Label L1 : 
[s : string /\ not mem (tbl0, s) /\ tbl0 : table] ,  {true} H1 
	 
	 	mem (tbl', s) /\
		  size (tbl') = size (tbl0) + 2 /\
		  len (tbl') = len (tbl0) + len (s) + 3
          /\ size (tbl' > 0)
----------------------------------------------------------
[s : string /\ not mem (tbl0, s) /\ tbl0 : table] ,  {true} x1 <- fresh_str () {len (x1) = 3 
	/\ tbl1 = tbl0
	/\ not (mem tbl1 x1)} ; 
H2  mem (tbl', s) /\
		  size (tbl') = size (tbl0) + 2 /\
		  len (tbl') = len (tbl0) + len (s) + 3
          /\ size (tbl' > 0)
------------------------------------------------------------------

[s : string /\ not mem (tbl0, s) /\ tbl0 : table] ,  {true} x1 <- fresh_str () {len (x1) = 3 
	/\ tbl1 = tbl0
	/\ not (mem tbl1 x1)} 
 
  _ <- add x1 

  {			(mem tbl2 x1) /\ 
			len (tbl2) == len (tbl1) + len (x1) /\ 
			size (tbl2) == size (tbl1) + 1}
 H3 [At this point the synthesis becomes very non-deterministic] 			

   mem (tbl', s) /\
		  size (tbl') = size (tbl0) + 2 /\
		  len (tbl') = len (tbl0) + len (s) + 3
          /\ size (tbl' > 0)

---------------------------------------------------------------
CASE 1 : x1 <- fresh_str ; add x1 ; x2<- fresh_str ; add x2
[s : string /\ not mem (tbl0, s) /\ tbl0 : table] ,  {true} x1 <- fresh_str () {len (x1) = 3 
	/\ tbl1 = tbl0
	/\ not (mem tbl1 x1)} 
 
  _ <- add x1 

  {			(mem tbl2 x1) /\ 
			len (tbl2) == len (tbl1) + len (x1) /\ 
			size (tbl2) == size (tbl1) + 1}
 H3 [At this point the synthesis becomes very non-deterministic] 			
x2 <- fresh_str 
	{len (x2) = 3 
	/\ tbl3 = tbl2
	/\ not (mem tbl3 x2)} 


   mem (tbl', s) /\
		  size (tbl') = size (tbl0) + 2 /\
		  len (tbl') = len (tbl0) + len (s) + 3
          /\ size (tbl' > 0)



