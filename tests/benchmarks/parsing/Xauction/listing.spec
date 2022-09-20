




listing : StExc {\(h:heap). true} listing {\(h:heap), (v:listing), (h':heap). seller (v) = si /\ bidders (v) = bi /\ disjointlist (bi, si) = true};
sellerinfo : StExc {\(h:heap). true} sellerinfo {\(h:heap), (v:seller), (h':heap). h = h'};
bidderinfo : {s : [char] | true} -> StExc {\(h:heap). true} bidderinfo {\(h:heap), (v:bidderinfo), (h':heap). sel (h, inp) = li 
									/\ sel (h', inp) = lo 
									/\ elems (li) C= elems (lo) 
									/\ name (v) = bidder /\ not (elems (bidder) = elems (s)) };

bidders : {s : [char] | true} -> StExc {\(h : heap). true} [bidderinfo] {\(h:heap),(v:[bidderinfo]),(h':heap). disjointlist(v, s) = true /\ included (h, h', inp) = true};
auction :  {s : [char] | true} -> StExc {\(h : heap). true} [bidderinfo] {\(h:heap),(v:[bidderinfo]),(h':heap).isjointlist(v, s) = true  /\ included (h, h', inp) = true};
skip : StExc {\(h:heap). true} unit {\(h:heap), (v:unit), (h':heap). h = h'};

