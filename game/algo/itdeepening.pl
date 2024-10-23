


searchITD(Path):-
    start(S0),
    deepening(S0,Path,0).

deepening(S0,Path,Deepest):-
    solve(S0,Path,[],Deepest),!,
    write('Solution found at depth '),write(Deepest),write('\n'),
    write(Path),write('\n').
deepening(S0,Path,Deepest):-
    write('Solution not found at depth '),write(Deepest),write('\n'),
    NewDeepest is Deepest + 1,
    deepening(S0,Path,NewDeepest).

    


solve(S,[],_,_):-
    end(S),!.

solve(S,[Az|ListaAzioni],Visitati,ProfMax):-
    ProfMax > 0,
    applicable(Az,S),
    trasforma(Az,S,Snuovo),
    \+member(Snuovo,Visitati),
    NuovaProfMax is ProfMax-1,
    solve(Snuovo,ListaAzioni,[S|Visitati],NuovaProfMax).


