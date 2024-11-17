/* SCORE
Step 1) Define the direction from were a portal can be accesed
Step 2) For each direction a value is computed -> 
        this value coresponds to the last position accessibile by an object falling from the portal to that direction.
        In that way we define segments for each direction
Step 3) The first part of the heuristic is defined by sum of distance from the actual position to each segment.
Step 4) The second part is defined by the proximity of gems
*/
score([pos(MyX,MyY),Hammer,G1,G2,G3,Ice],OldScore,OldScore+1,ScoreH):-
    portal(pos(EndX,EndY)),

    
    UP is EndX-1, DOWN is EndX+1, RIGHT is EndY+1, LEFT is EndY-1,
    % Step 1: defining the available target entry, i.e. the direction from were a portal can be accesed
    target_entry([('up',pos(UP,EndY)),('down',pos(DOWN,EndY)),('right',pos(EndX,RIGHT)),('left',pos(EndX,LEFT))],Ice,[G1,G2,G3],AvailableEntry),
    % Step 2: define Projects list, containg the value that corresponds to the last position accessibile 
    % by an object falling from the portal to available target entry
    project(pos(EndX,EndY),AvailableEntry,Ice,[G1,G2,G3],Projected),
    
    % Step 3
    distance(AvailableEntry,pos(MyX,MyY),pos(EndX,EndY),Projected,Distance),
    sum_list(Distance,FoldedDist),
    ScorePortal is FoldedDist/2,

    % Step 4
    gem_dist(G1,G2,G3,ScoreGems),
    
    ScoreH is ScoreGems+ScorePortal.
    

target_entry([],_,_,[]).
target_entry([(Az,Pos)|ListPos],Ice,Gems,[Az|Next]):-
    move_check(Pos,Ice,Gems),!,
    target_entry(ListPos,Ice,Gems,Next).
target_entry([(Az,Pos)|ListPos],Ice,Gems,Next):-
    target_entry(ListPos,Ice,Gems,Next).

project(_,[],_,_,[]).
project(Pos,[Az|ListAz],Ice,Gems,[End|ListEnd]):-
    move_shift(Az,Pos,End,Ice,Gems),
    project(Pos,ListAz,Ice,Gems,ListEnd).



distance([],_,_,[],[]).
distance([up|AzList],pos(MyX,MyY),pos(EndX,Collumn),[pos(ShiftX,Collumn)|TailShifted],[Diff|DifferenceTail]):-
    MyX>=EndX,MyX=<ShiftX,
    Diff is abs(MyY-Collumn),
    distance(AzList,pos(MyX,MyY),pos(EndX,Collumn),TailShifted,DifferenceTail).
distance([up|AzList],pos(MyX,MyY),pos(EndX,Collumn),[pos(ShiftX,Collumn)|TailShifted],[Diff|DifferenceTail]):-
    MissedLeft is abs(EndX-MyX),
    MissedRight is abs(ShiftX-MyX),
    Diff is min(MissedLeft,MissedRight)+abs(MyY-Collumn),
    distance(AzList,pos(MyX,MyY),pos(EndX,Collumn),TailShifted,DifferenceTail).


distance([down|AzList],pos(MyX,MyY),pos(EndX,Collumn),[pos(ShiftX,Collumn)|TailShifted],[Diff|DifferenceTail]):-
    MyX=<EndX , MyX>=ShiftX,
    Diff is abs(MyY - Collumn),
    distance(AzList,pos(MyX,MyY),pos(EndX,Collumn),TailShifted,DifferenceTail).

distance([down|AzList],pos(MyX,MyY),pos(EndX,Collumn),[pos(ShiftX,Collumn)|TailShifted],[Diff|DifferenceTail]):-
    MissedLeft is abs(EndX-MyX),
    MissedRight is abs(ShiftX-MyX),
    Diff is min(MissedLeft,MissedRight)+abs(MyY-Collumn),
    distance(AzList,pos(MyX,MyY),pos(EndX,Collumn),TailShifted,DifferenceTail).


distance([right|AzList],pos(MyX,MyY),pos(Row,EndY),[pos(Row,ShiftY)|TailShifted],[Diff|DifferenceTail]):-
    MyY>=EndY, MyY=<ShiftY,!,
    Diff is abs(MyX-Row),
    distance(AzList,pos(MyX,MyY),pos(Row,EndY),TailShifted,DifferenceTail).

distance([right|AzList],pos(MyX,MyY),pos(Row,EndY),[pos(Row,ShiftY)|TailShifted],[Diff|DifferenceTail]):- 
    MissedLeft is abs(EndY-MyY),
    MissedRight is abs(ShiftY-MyY),
    Diff is min(MissedLeft,MissedRight)+abs(MyX-Row),
    distance(AzList,pos(MyX,MyY),pos(Row,EndY),TailShifted,DifferenceTail).



distance([left|AzList],pos(MyX,MyY),pos(Row,EndY),[pos(Row,ShiftY)|TailShifted],[Diff|DifferenceTail]):-
    MyY=<EndY, MyY>=ShiftY,!,
    Diff is abs(MyX-Row),
    distance(AzList,pos(MyX,MyY),pos(Row,EndY),TailShifted,DifferenceTail).

distance([left|AzList],pos(MyX,MyY),pos(Row,EndY),[pos(Row,ShiftY)|TailShifted],[Diff|DifferenceTail]):- 
    MissedLeft is abs(EndY-MyY),
    MissedRight is abs(ShiftY-MyY),
    Diff is min(MissedLeft,MissedRight)+abs(MyX-Row),
    distance(AzList,pos(MyX,MyY),pos(Row,EndY),TailShifted,DifferenceTail).

gem_dist(pos(G1X,G1Y),pos(G2X,G2Y),pos(G3X,G3Y),Total):-
    G1G2 is abs(G1X-G2X)+abs(G1Y-G2Y) - 1,
    G2G3 is abs(G3X-G2X)+abs(G3Y-G2Y) - 1,
    G1G3 is abs(G3X-G1X)+abs(G3Y-G1Y) -1 ,
    ScoreG1 is min(G1G2,G1G3),
    ScoreG2 is min(G1G2,G2G3),
    ScoreG3 is min(G1G3,G2G3),
    Total is (ScoreG1+ScoreG2+ScoreG3)/2.