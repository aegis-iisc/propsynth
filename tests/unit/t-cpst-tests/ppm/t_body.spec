tr : triple;
max : {tr : triple | true} ->   {v : int | v == max (tr)};
width : {tr : triple | true} ->  {v : int | v == width (tr)};
height : {tr : triple | true} -> {v : int | v == height (tr)};

cols : {\(h : heap).true} [rgb]] {\(h:heap),(v:[rgb]),(h':heap). len (v) == width (tr)};

annot : {\(h : heap). true} [[rgb]] {\(h:heap),(v:[[rgb]]),(h':heap). len (v) == height (tr)};
