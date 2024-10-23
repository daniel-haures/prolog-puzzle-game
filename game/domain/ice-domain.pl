
%['ice-domain.pl','sort.pl','actions.pl','score_classic.pl','a-star.pl'].

rows(8).
collumns(8).

% S = [pos monster, have the hammer, gem1, gem2, gem3]
start([pos(1,4),0,pos(1,7),pos(5,4),pos(8,8),[]]).
end([pos(4,8),_,_,_,_,_]).

portal(pos(4,8)).
hammer(pos(8,2)).

occupied(pos(1,6)).
occupied(pos(2,2)).
occupied(pos(2,8)).
occupied(pos(3,8)).
occupied(pos(4,4)).
occupied(pos(4,5)).
occupied(pos(5,5)).
occupied(pos(6,2)).
occupied(pos(7,2)).
occupied(pos(7,6)).
occupied(pos(8,3)).

ice(pos(4,7)).
ice(pos(5,8)).
ice(pos(2,6)).
ice(pos(2,7)).
ice(pos(7,7)).
