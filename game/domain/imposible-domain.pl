
%['domain/imposible-domain.pl','domain/sort.pl','domain/actions.pl','domain/score.pl','algo/a-star.pl','algo/itdeepening.pl'].

rows(8).
collumns(8).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(1,4),0,pos(1,7),pos(5,4),pos(8,8),[]]).
end([pos(8,8),_,_,_,_,_]).

portal(pos(8,8)).
hammer(pos(8,2)).

occupied(pos(7,8)).
occupied(pos(8,7)).

ice(pos(4,7)).
