%['domain/L-domain.pl','domain/sort.pl','domain/actions.pl','domain/score.pl','algo/a-star.pl','algo/itdeepening.pl'].

rows(8).
collumns(8).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(7,2),0,pos(1,1),pos(5,3),pos(8,8),[]]).
end([pos(1,8),_,_,_,_,_]).

portal(pos(1,8)).
hammer(pos(8,3)).

occupied(pos(6,1)).
occupied(pos(6,2)).
occupied(pos(6,3)).
occupied(pos(7,3)).
occupied(pos(2,8)).

ice(pos(1,7)).
ice(pos(2,7)).
ice(pos(8,4)).