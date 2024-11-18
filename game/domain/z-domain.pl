%['domain/z-domain.pl','domain/sort.pl','domain/actions.pl','domain/score.pl','algo/a-star.pl','algo/itdeepening.pl'].

rows(6).
collumns(6).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(3,6),0,pos(1,6),pos(6,1),pos(5,4),[]]).
end([pos(3,1),_,_,_,_,_]).

portal(pos(3,1)).
hammer(pos(6,6)).

occupied(pos(4,1)).
occupied(pos(2,4)).
occupied(pos(3,4)).
occupied(pos(4,3)).
occupied(pos(4,4)).
occupied(pos(5,3)).

ice(pos(1,4)).