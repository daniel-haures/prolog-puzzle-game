%['domain/wall-domain.pl','domain/sort.pl','domain/actions.pl','domain/score.pl','algo/a-star.pl','algo/itdeepening.pl'].

rows(8).
collumns(8).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(8,8),0,pos(1,8),pos(4,1),pos(8,6),[]]).
end([pos(1,1),_,_,_,_,_]).

portal(pos(1,1)).
hammer(pos(3,1)).

occupied(pos(2,1)).
occupied(pos(2,6)).
occupied(pos(4,6)).
occupied(pos(4,7)).
occupied(pos(4,8)).

ice(pos(1,2)).
ice(pos(1,6)).
ice(pos(3,6)).