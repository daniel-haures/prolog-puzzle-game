%['domain/ice-domain-3.pl','domain/sort.pl','domain/actions.pl','domain/score.pl','algo/a-star.pl','algo/itdeepening.pl'].

rows(8).
collumns(8).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(8,8),0,pos(2,8),pos(3,3),pos(5,1),[]]).
end([pos(5,3),_,_,_,_,_]).

portal(pos(5,3)).
hammer(pos(8,2)).

occupied(pos(1,6)).
occupied(pos(2,2)).
occupied(pos(3,8)).
occupied(pos(4,3)).
occupied(pos(5,4)).
occupied(pos(6,1)).
occupied(pos(7,7)).
occupied(pos(8,3)).

ice(pos(2,6)).
ice(pos(3,6)).
ice(pos(3,7)).
ice(pos(8,5)).