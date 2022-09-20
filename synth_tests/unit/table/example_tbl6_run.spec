

[s : string, 
	
	assume : (mem (Tbl0, s) = false 
	] 
	 {sel (h, num) = 0
	/\sel h  tbl = Tbl0}

	Case twice_average_len 
		wp (twice_average_len, post)
		= 
		size (Tbl) > 0 /\
		\forall Tbl', v. 
			(Tbl' = Tbl /\
			min (Tbl') <= v)  
			=> 
			(min (Tbl') <= v) /\
			(v <= max (Tbl')) /\
					
					size (Tbl') == size (Tbl0) + 2 /\
					mem (Tbl', s) = true /\
					(len (Tbl') == len (Tbl0) + len (s) + 3))

	(Can I find a frame P0, such that 
	P0 /\ size (Tbl) > 0 
		\forall Tbl', v. 
			(Tbl' = Tbl /\
			min (Tbl') <= v)  
			=> 
			(min (Tbl') <= v) /\
			(v <= max (Tbl')) /\
					
					size (Tbl') == size (Tbl0) + 2 /\
					mem (Tbl', s) = true /\
					(len (Tbl') == len (Tbl0) + len (s) + 3))
	)				


	(*It appears we cannot*)

	Case average_len 
		wp (average_len, post)
		size (Tbl) > 0 /\
		\forall Tbl', v. 
			(Tbl' = Tbl /\
			min (Tbl') <= v) /\ 
			(v <= max (Tbl'))
			=> 
			(min (Tbl') <= v) /\
			(v <= max (Tbl')) /\
					
					size (Tbl') == size (Tbl0) + 2 /\
					mem (Tbl', s) = true /\
					(len (Tbl') == len (Tbl0) + len (s) + 3))
		
	(Can I find a frame P0, such that 
				
		P0 /\ size (Tbl) > 0 
		\forall Tbl', v. 
			(Tbl' = Tbl /\
			min (Tbl') <= v)  
			=> 
			(min (Tbl') <= v) /\
			(v <= max (Tbl')) /\
					
					size (Tbl') == size (Tbl0) + 2 /\
					mem (Tbl', s) = true /\
					(len (Tbl') == len (Tbl0) + len (s) + 3))
	)				

	P0 = 	size (Tbl) == size (Tbl0) + 2 /\
			mem (Tbl, s) = true /\
			(len (Tbl) == len (Tbl0) + len (s) + 3))

	the forward problem:
	
	[s : string, 
	
	assume : (mem (Tbl0, s) = false 
	] 
	 {sel (h, num) = 0
	/\sel h  tbl = Tbl0}
	
	[] : Unknown
	
	size (Tbl') == size (Tbl0) + 2 /\
	mem (Tbl', s) = true /\
	(len (Tbl') == len (Tbl0) + len (s) + 3))
	size (Tbl') > 0		

**********************************************

We are stuck here as we do not know if we are moving closer to the goal now



----------------------------------------------------------------------------
[s-wp-disj]
[s : string, 
	\delta =  sel (h, num) = 0/\sel h  tbl = Tbl
	assume : (mem (Tbl, s) = false 
	] ,  {sel (h, num) = 0
	/\sel h  tbl = Tbl0} 
	v : float 
								
	{\(h : heap), (v : float), (h' : heap). 
				exists (Tbl' : [int]). 
				not (sel (h, num) > 2) /\
				ilssel (h', tbl) = Tbl'
					
				/\  
				(
					not (min (Tbl') > v) /\
					not (v > max (Tbl')) /\
					
					size (Tbl') == size (Tbl) + 2 /\
					mem (Tbl', s) = true /\
					(len (Tbl') == len (Tbl) + len (s) + 3))
				)	
			};


-----------------------------------------------------------------------------
[s : string, 
	\delta =  sel (h, num) = 0/\sel h  tbl = Tbl
	] ,  {true} 
	v : float 
								
	{\(h : heap), (v : float), (h' : heap). 
				exists (Tbl' : [int]). 
				not (sel (h, num) > 2) /\
				ilssel (h', tbl) = Tbl'
					
				/\  
				(
					not (min (Tbl') > v) /\
					not (v > max (Tbl')) /\
					
					size (Tbl') == size (Tbl) + 2 /\
					mem (Tbl', s) = true /\
					
					(mem (Tbl, s) = false => 
						(len (Tbl') == len (Tbl) + len (s) + 3))
					\/ 
					(mem (Tbl, s) = true => 
						(len (Tbl') == len (Tbl) + 6))
				)
			};


