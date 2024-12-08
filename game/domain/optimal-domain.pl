%['domain/imposible-domain.pl','domain/sort.pl','domain/actions.pl','domain/score.pl','algo/a-star.pl','algo/itdeepening.pl'].

rows(8).
collumns(8).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(1,1),0,pos(8,8),pos(8,7),pos(7,8),[]]).
end([pos(4,4),_,_,_,_,_]).

portal(pos(4,4)).
hammer(pos(8,6)).

occupied(pos(3,3)).
occupied(pos(3,4)).
occupied(pos(4,3)).
occupied(pos(3,8)).
occupied(pos(8,5)).
occupied(pos(2,6)).
occupied(pos(5,7)).




ice(pos(7,7)).
ice(pos(7,6)).
ice(pos(6,8)).


