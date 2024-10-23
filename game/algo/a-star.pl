/* 
A node in ASTAR search [
The state of a specific domain (es. actual position in the labirinth)
The path describing the action done in order to achieve the previous state
The cost to reach the actual state
The cost to reach the final state from actual state
]
*/
searchASTAR(Path):-
    start(S0),
    score(S0,0,ScoreG,ScoreH),
    astar([[S0,[],0,ScoreH]],[],CamminoInverso), 
    reverseL(CamminoInverso,Path),
    write(Path).

%Reverse a list 
reverseL(L,LInv):-rev(L,[],LInv).
rev([],Temp,Temp).
rev([Head|Tail],Temp,LInv):-rev(Tail,[Head|Temp],LInv).


/*
ASTAR predicate arguments
1: List of state stil to visit, added by expanding previous states
2: Store already visited state, in order to not visit them again. The path pursued to reach them doesn't matter
3: Is the argument that the predicate need to match: the path to the solution.
*/

%Check first if the reached start is the final state and math the final path.
astar([[S,Path,_,_]|_],_,Path):-end(S) , !.
%The reached state is already member of the visited list: PROLOG jumps the next astar predicate.
%The reached state is not member of the visited list: CUT next astar predicate and find the reacheable states from actual one. 
%    predicate astar should be checked on them.
astar([[S,Path,ScoreG,ScoreH]|Tail],Visited,Result):-
    \+member(S,Visited),!, 
    findall(Az,applicabile(Az,S),AzList), % Find possibile actions that can be applied to actual state.
    generateNewState([S,Path,ScoreG,ScoreH],AzList,NewState), % Generate the reacheable state
    addNewState(NewState,Tail,NewTail), % Add the new state to the list of states not visited yet. Avoiding duplicates.
    astar(NewTail,[S|Visited],Result). % Check the existence of final state in the previous list.
%Delete the already visited state and move to the remaining state to visit
astar([_|Tail],Visited,Result):-
    astar(Tail,Visited,Result).

% Generate the reacheable state
generateNewState(_,[],[]).
generateNewState([OldS,OldPath,OldScoreG,OldScoreH],[Az|AzTail],[[NewS,[Az|OldPath],NewScoreG,NewScoreH]|NSTail]):-
    trasforma(Az,OldS,NewS),
    score(NewS,OldScoreG,NewScoreG,NewScoreH),
    generateNewState([OldS,OldPath,OldScoreG,OldScoreH],AzTail,NSTail).


% Add the new state to the list of states not visited yet. Avoiding duplicates.
addNewState([],OldStates,OldStates).
addNewState([[S,Path,ScoreG,ScoreH]|Tail],OldStates,NewStates):-
    member([S,_,_,_],OldStates),!,
    updateS([S,Path,ScoreG,ScoreH],OldStates,Updated),
    addNewState(Tail,Updated,NewStates).
addNewState([[S,Path,ScoreG,ScoreH]|Tail],OldStates,NewStates):-
    insertS([S,Path,ScoreG,ScoreH],OldStates,Updated),
    addNewState(Tail,Updated,NewStates).

/*
It's possibile that a not visited state can be reached from two different source state. 
In that case, IF the cost of the new path reaching the state is BIGER that the previous path, the new should not be considered for further analysis. 
Otherwise, the old search node should be delete and the new one inserted in the un-explored list.
*/
updateS(S,OldStates,OldStates):-
    greaterS(S,OldStates),!.
updateS([S,Path,ScoreG,ScoreH],OldStates,Updated):-
    delete(OldStates, [S,_,_,_] , Deleted),
    insertS([S,Path,ScoreG,ScoreH],Deleted,Updated).

% IF the predicate is TRUE, a state with a lower value already exist in the un-explored list. 
greaterS([S,_,ScoreG,ScoreH],[[S,_,OldScoreG,OldScoreH]|_]):-
    ScoreG + ScoreH > OldScoreG + OldScoreH.
greaterS([S0,Path,ScoreG,ScoreH],[[S1,_,_,_]|OldTail]):-
    S0 \= S1,
    greaterS([S0,Path,ScoreG,ScoreH],OldTail).

% An important point in ASTAR search is that lower cost states should be explored first. 
% That requirement is achieved by inserting the un-explored states in an ordered way.
insertS([S0,Path,ScoreG,ScoreH],[],[[S0,Path,ScoreG,ScoreH]]).
insertS([S0,Path,ScoreG,ScoreH],[[S1,OldPath,OldScoreG,OldScoreH]|OldTail],[[S0,Path,ScoreG,ScoreH]|[[S1,OldPath,OldScoreG,OldScoreH]|OldTail]]):-
    ScoreG + ScoreH < OldScoreG + OldScoreH,!.
insertS([S0,Path,ScoreG,ScoreH],[[S1,OldPath,OldScoreG,OldScoreH]|OldTail],[[S1,OldPath,OldScoreG,OldScoreH]|UpdatedTail]):-
    insertS([S0,Path,ScoreG,ScoreH],OldTail,UpdatedTail).