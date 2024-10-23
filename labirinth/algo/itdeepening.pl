

%Find the working Path in the research space from starting point with Iterative Deepening
searchITD(Path):-
    start(S0),
    deepening(S0,Path,0).

%Deepening check the existence of path with an increassing depth depth-first search.
deepening(S0,Path,Deepest):-
    solve(S0,Path,[],Deepest),!,
    write('Solution found at depth '),write(Deepest),write('\n'),
    write(Path),write('\n').
deepening(S0,Path,Deepest):-
    NewDeepest is Deepest + 1,
    deepening(S0,Path,NewDeepest).

%Solve is a limited depth first search.
solve(S,[],_,_):-
    end(S),!.
solve(S,[Az|ListaAzioni],Visitati,ProfMax):-
    ProfMax > 0,
    applicabile(Az,S),
    trasforma(Az,S,Snuovo),
    \+member(Snuovo,Visitati),
    NuovaProfMax is ProfMax-1,
    solve(Snuovo,ListaAzioni,[S|Visitati],NuovaProfMax).
    

