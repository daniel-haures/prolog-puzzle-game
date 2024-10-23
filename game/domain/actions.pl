/* In the case of the labirinth the domain state it's defined by:
!) The position of the moster
2) If the moster have the hammer
3) The positions of the gems
4) The position where the ice was broken */



trasforma(Az,[Mypos,Hammer,G1,G2,G3,Ice],[NextMypos,NextHammer,NextG1,NextG2,NextG3,NextIce]):-

    %move the objects of the maze    
    slide(Az,[('p',Mypos),('g1',G1),('g2',G2),('g3',G3)],[NextMypos,NextG1,NextG2,NextG3],Ice),
    %add hammer if hammer achieved
    check_hammer(Hammer,NextMypos,NextHammer),
    %remove ice if the monster have the hammer
    remove_ice(NextMypos,NextHammer,Ice,NextIce).

/*The item in the game are not allowed to fall in certain direction in random order.
Item that are closer to the side of the maze now considered as the 'bottom' should fall first.
Thus, a quick sort was implemented to define the correct order of the fall*/
slide(Az,Unordered,Next,Ice):-
    quick_sort2(Az,Unordered,Ordered),
    slide_sup(Az,Ordered,Next,Ice,[]).

/*Gems and The monster fall in different ways*/
/*Each element of the maze is PAIRED with a string defining it's type for two reasons:
1) After the sort it's possible to determine the object associate with the a position
2) Allows pattern-matching to right position in [NextMypos,NextG1,NextG2,NextG3]*/
slide_sup(_,[],_,_,_).
slide_sup(Az,[('p',Mypos)|Tail],[NextMypos,NextG1,NextG2,NextG3],Ice,NotAllowed):-
    move_shift(Az,Mypos,NextMypos,Ice,NotAllowed),
    slide_sup(Az,Tail,[_,NextG1,NextG2,NextG3],Ice,[NextMypos|NotAllowed]).

slide_sup(Az,[('g1',G1)|Tail],[NextMypos,NextG1,NextG2,NextG3],Ice,NotAllowed):-
    portal(P),
    append([P],NotAllowed,NewNotAllowed),
    move_shift(Az,G1,NextG1,Ice,NewNotAllowed),
    slide_sup(Az,Tail,[NextMypos,_,NextG2,NextG3],Ice,[NextG1|NotAllowed]).

slide_sup(Az,[('g2',G2)|Tail],[NextMypos,NextG1,NextG2,NextG3],Ice,NotAllowed):-
    portal(P),
    append([P],NotAllowed,NewNotAllowed),
    move_shift(Az,G2,NextG2,Ice,NewNotAllowed),
    slide_sup(Az,Tail,[NextMypos,NextG1,_,NextG3],Ice,[NextG2|NotAllowed]).

slide_sup(Az,[('g3',G3)|Tail],[NextMypos,NextG1,NextG2,NextG3],Ice,NotAllowed):-
    portal(P),
    append([P],NotAllowed,NewNotAllowed),
    move_shift(Az,G3,NextG3,Ice,NewNotAllowed),
    slide_sup(Az,Tail,[NextMypos,NextG1,NextG2,_],Ice,[NextG3|NotAllowed]).


/*Recursively define the next position of an object moved in direction (up,down,left,right),
  considering the not allowed positions through method move_check */
move_shift(up,pos(X,Y),NextMypos,Ice,NotAllowed):-
    C is X-1,
    move_check(pos(C,Y),Ice,NotAllowed),!,
    move_shift(up,pos(C,Y),NextMypos,Ice,NotAllowed).
move_shift(down,pos(X,Y),NextMypos,Ice,NotAllowed):-
    C is X+1,
    move_check(pos(C,Y),Ice,NotAllowed),!,
    move_shift(down,pos(C,Y),NextMypos,Ice,NotAllowed).
move_shift(right,pos(X,Y),NextMypos,Ice,NotAllowed):-
    C is Y+1,
    move_check(pos(X,C),Ice,NotAllowed),!,
    move_shift(right,pos(X,C),NextMypos,Ice,NotAllowed).
move_shift(left,pos(X,Y),NextMypos,Ice,NotAllowed):-
    C is Y-1,
    move_check(pos(X,C),Ice,NotAllowed),!,
    move_shift(left,pos(X,C),NextMypos,Ice,NotAllowed).
move_shift(_,pos(X,Y),pos(X,Y),_,_).

/*A block it's not available if
1) exceds row and collums
2) it's a black block
3) it's a gem, monster or portal, depends on the NotAllowed list defined 
considering falling order and type of object in predicate slide_sup
4) it's a not broken ice block*/
move_check(pos(X,Y),Ice,NotAllowed):-
    rows(R),
    collumns(C),
    X > 0,Y > 0,X =< R,Y =< C,
    \+occupied(pos(X,Y)),
    \+member(pos(X,Y),NotAllowed),
    ice_check(pos(X,Y),Ice).

ice_check(PosToCheck,_):-
    \+ice(PosToCheck),!.
ice_check(PosToCheck,Ice):-
    member(PosToCheck,Ice).

/*Remove the ice*/
remove_ice(_,0,Ice,Ice).
remove_ice(pos(X,Y),1,Ice,NextIce):-
    UP is X-1, DOWN is X+1, RIGHT is Y+1, LEFT is Y-1,
    remove_ice_sup([pos(UP,Y),pos(DOWN,Y),pos(X,RIGHT),pos(X,LEFT)],Ice,NextIce).

remove_ice_sup([],Ice,Ice).
remove_ice_sup([PosToCheck|Tail],Ice,[PosToCheck|NextIceTail]):-
    ice(PosToCheck),
    \+member(PosToCheck,Ice),!,
    remove_ice_sup(Tail,Ice,NextIceTail).
remove_ice_sup([_|Tail],Ice,NextIce):-
    remove_ice_sup(Tail,Ice,NextIce).

/*Check Hammer*/
check_hammer(1,_,1).
check_hammer(0,Pos,1):-
    hammer(Pos),!.
check_hammer(0,_,0).   

applicable(up,_).
applicable(down,_).
applicable(right,_).
applicable(left,_).


testing(AzList,F):-start(S),testing_sup(AzList,S,F).
testing_sup([],S,S).
testing_sup([Az|ListAz],S,F):-
    trasforma(Az,S,M),
    write(M),write('\n'),
    testing_sup(ListAz,M,F).
