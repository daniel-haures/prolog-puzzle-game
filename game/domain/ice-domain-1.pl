%['domain/ice-domain-1.pl','domain/sort.pl','domain/actions.pl','domain/score.pl','algo/a-star.pl','algo/itdeepening.pl'].

rows(8).
collumns(8).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(5,4),0,pos(1,1),pos(3,7),pos(8,5),[]]).
end([pos(5,2),_,_,_,_,_]).

portal(pos(5,2)).
hammer(pos(5,5)).

occupied(pos(1,3)).
occupied(pos(2,6)).
occupied(pos(3,3)).
occupied(pos(3,4)).
occupied(pos(3,5)).
occupied(pos(3,6)).
occupied(pos(4,3)).
occupied(pos(5,3)).
%occupied(pos(5,6)).
occupied(pos(6,3)).
occupied(pos(6,4)).
occupied(pos(6,5)).
occupied(pos(6,6)).
occupied(pos(7,1)).
occupied(pos(7,7)).
occupied(pos(8,4)).

ice(pos(5,6)).
