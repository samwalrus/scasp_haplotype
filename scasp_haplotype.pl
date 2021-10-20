% s(CASP) Programming
:- use_module(library(scasp)).

% haplotypes

%g(i,j,k). ith genotyope at position j has value k
%genotype(1,[2,1,2]).
%genotype(2,[1,2,1]).

genotype(_G,[G1,G2,G3]):-
    haplotype([HA1,HA2,HA3]),
    haplotype([HB1,HB2,HB3]),
    combined_list([G1,G2,G3],[HA1,HA2,HA3],[HB1,HB2,HB3]).

combined_list([G1,G2,G3],[HA1,HA2,HA3],[HB1,HB2,HB3]):-
    combined(G1,HA1,HB1),
    combined(G2,HA2,HB2),
    combined(G3,HA3,HB3).
haplotype([_X,_Y,_Z]).


r_genotype(_G,Genotype):-
    haplotype_l(Hap1),
    haplotype_l(Hap2),
    r_combined_list(Genotype,Hap1,Hap2).
r_combined_list([],[],[]).
r_combined_list([G|Gs],[HA1|HAs],[HB1|HBs]):-
       combined(G,HA1,HB1),
       r_combined_list(Gs,HAs,HBs).


%conflation.
combined(2,0,1).
combined(2,1,0).
combined(0,0,0).
combined(1,1,1).


haplotype_l(_X).

/** <examples> Your example queries go here, e.g.
?- ? genotype(1,[2,1,2]),genotype(2,[1,2,1]).
*/
