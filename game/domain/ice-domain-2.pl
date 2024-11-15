%['domain/ice-domain-2.pl','domain/sort.pl','domain/actions.pl','domain/score.pl','algo/a-star.pl','algo/itdeepening.pl'].

rows(8).
collumns(8).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(4,4),0,pos(1,8),pos(5,5),pos(8,2),[]]).
end([pos(7,1),_,_,_,_,_]).

portal(pos(7,1)).
hammer(pos(1,2)).

occupied(pos(1,1)).
occupied(pos(2,5)).
occupied(pos(5,4)).
occupied(pos(6,5)).
occupied(pos(6,6)).
occupied(pos(6,8)).
occupied(pos(7,5)).
occupied(pos(8,1)).
occupied(pos(8,5)).
occupied(pos(8,6)).

ice(pos(7,2)).
ice(pos(7,3)).
ice(pos(7,4)).
