function prob = count_prob(S,w)
w = w/sum(w); % Make sure probabilites add up to 1.
cp = [0, cumsum(w)];
r = rand;
ind = find(r>cp, 1, 'last');
prob = S(ind);
end