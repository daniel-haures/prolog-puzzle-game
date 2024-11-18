%['domain/onlyice-domain.pl','domain/sort.pl','domain/actions.pl','domain/score.pl','algo/a-star.pl','algo/itdeepening.pl'].

rows(8).
collumns(8).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(1,1),0,pos(1,7),pos(7,1),pos(8,1),[]]).
end([pos(8,8),_,_,_,_,_]).

portal(pos(8,8)).
hammer(pos(1,8)).

occupied(pos(2,8)).
occupied(pos(3,1)).

ice(pos(4,1)).
ice(pos(4,2)).
ice(pos(4,3)).
ice(pos(4,4)).
ice(pos(4,5)).
ice(pos(4,6)).
ice(pos(4,7)).
ice(pos(4,8)).

