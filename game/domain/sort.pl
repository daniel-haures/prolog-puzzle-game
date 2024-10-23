%funzione di sort necessaria a definire quali gemme cadono per prima
quick_sort2(Az,List,Sorted):-q_sort(Az,List,[],Sorted).
q_sort(_,[],Acc,Acc).
q_sort(Az,[H|T],Acc,Sorted):-
	pivoting(Az,H,T,L1,L2),
	q_sort(Az,L1,Acc,Sorted1),q_sort(Az,L2,[H|Sorted1],Sorted).

pivoting(_,(Ht,pos(HposX,HposY)),[],[],[]).
pivoting(up,(Ht,pos(HposX,HposY)),[(Xt,pos(XposX,XposY))|T],[(Xt,pos(XposX,XposY))|L],G):-
    XposX>=HposX,pivoting(up,(Ht,pos(HposX,HposY)),T,L,G).
pivoting(up,(Ht,pos(HposX,HposY)),[(Xt,pos(XposX,XposY))|T],L,[(Xt,pos(XposX,XposY))|G]):-
    XposX<HposX,pivoting(up,(Ht,pos(HposX,HposY)),T,L,G).

pivoting(down,(Ht,pos(HposX,HposY)),[(Xt,pos(XposX,XposY))|T],[(Xt,pos(XposX,XposY))|L],G):-
    XposX<HposX,pivoting(down,(Ht,pos(HposX,HposY)),T,L,G).
pivoting(down,(Ht,pos(HposX,HposY)),[(Xt,pos(XposX,XposY))|T],L,[(Xt,pos(XposX,XposY))|G]):-
    XposX>=HposX,pivoting(down,(Ht,pos(HposX,HposY)),T,L,G).

pivoting(right,(Ht,pos(HposX,HposY)),[(Xt,pos(XposX,XposY))|T],[(Xt,pos(XposX,XposY))|L],G):-
    XposY<HposY,pivoting(right,(Ht,pos(HposX,HposY)),T,L,G).
pivoting(right,(Ht,pos(HposX,HposY)),[(Xt,pos(XposX,XposY))|T],L,[(Xt,pos(XposX,XposY))|G]):-
    XposY>=HposY,pivoting(right,(Ht,pos(HposX,HposY)),T,L,G).

pivoting(left,(Ht,pos(HposX,HposY)),[(Xt,pos(XposX,XposY))|T],[(Xt,pos(XposX,XposY))|L],G):-
    XposY>=HposY,pivoting(left,(Ht,pos(HposX,HposY)),T,L,G).
pivoting(left,(Ht,pos(HposX,HposY)),[(Xt,pos(XposX,XposY))|T],L,[(Xt,pos(XposX,XposY))|G]):-
    XposY<HposY,pivoting(left,(Ht,pos(HposX,HposY)),T,L,G).